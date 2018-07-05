//
//  BookTableViewCell.swift
//  NativePDFReader
//
//  Created by Fulvio Moya on 4/20/18.
//  Copyright © 2018 Fulvio Moya. All rights reserved.
//

import UIKit
import PDFReader

class BookTableViewCell: UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var books: [Book]!
    let viewModel = LibraryViewModel()
    let group = DispatchGroup()
    weak var reader: PDFViewController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.dataSource = self
        collectionView.delegate = self
       
        if let bookLibrary = BookLibraryViewController.books {
            books = bookLibrary
        } else if Network.reachability?.status.rawValue != "unreachable" {
            group.enter()
            let serialSaved = UserDefaults.standard.object(forKey: "SerialValidCode") as? String
            viewModel.getLibraryBooks(identifier: serialSaved!) { library in
                self.books = library.books
                self.group.leave()
            }
        } else {
            books = [Book]()
            for localItem in viewModel.fileManager.getNameDocumentsOnDirectory() {
                if localItem.contains(".pdf")  {
                    self.books.append(Book(id: "1", thumbnailName: localItem.replacingOccurrences(of: ".pdf", with: ".png"),
                                           fileName: localItem.replacingOccurrences(of: ".png", with: ".pdf"), expirationDate: "<#T##String#>"))
                }
            }
        }
    }
}

// UICollectionViewDataSource
extension BookTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return books == nil ? 4 : books.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookCell", for: indexPath) as? BookItemCollectionViewCell
        
        group.notify(queue: .main) {
            let selectedBook = self.books[indexPath.row].fileName
            
            cell?.activityIndicator.isHidden = true
            cell?.bookSelectedName = selectedBook
            cell?.downloadButton.isHidden = false
            
            self.viewModel.getThumbnailImage(fileName: selectedBook) { local_image in
                cell?.thumbnailImage.image = local_image
            }
            
            for name in FileManagerServices().getNameDocumentsOnDirectory() {
                if name == selectedBook {
                    cell?.downloadButton.isHidden = true
                    print("> \(name) exist on storage device")
                    break
                }
            }
        }
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? BookItemCollectionViewCell
        
        if cell?.downloadButton.isHidden == true {
            let fileName: String = books[indexPath.row].fileName
            let remotePDFDocumentURL = URL(string: self.viewModel.fileManager.getPathOf(file: fileName)!)!
            
            reader = PDFViewController.createNew(with: PDFDocument(url: remotePDFDocumentURL)!, title: fileName,
                                                     actionButtonImage: UIImage(named: "magnifier_icon"),
                                                     actionStyle: .customAction(presentGoToPage),
                                                     isThumbnailsEnabled: false )
            
            if let myViewController = self.parentViewController as? BookLibraryViewController {
                myViewController.navigationController?.pushViewController(reader, animated: true)
            }
        }
    }
    
    private func presentGoToPage() {
        let controller = UIAlertController(title: "Ir a la pagina", message: nil, preferredStyle: .alert)
        
        controller.addTextField(configurationHandler: { (textField) in
       //     textField.placeholder = "Page to go"
            textField.keyboardType = UIKeyboardType.decimalPad
        })
        
        controller.addAction(UIAlertAction(title: "Ok", style: .default, handler: {(UIAlertAction) in
            if let page = controller.textFields![0].text {
                if page != "" {
                    self.reader.goTo(page: Int(page)!)
                } 
            }
        }))
        
        controller.popoverPresentationController?.barButtonItem = reader.actionButton
        reader.present(controller, animated: true, completion: nil)
    }
}

// UICollectionViewDelegateFlowLayout
extension BookTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = TableConstants.getItemWidth(boundWidth: collectionView.bounds.size.width)
        return CGSize(width: itemWidth + 100, height: itemWidth*2.2)
    }
}
