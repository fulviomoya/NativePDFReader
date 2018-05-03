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
    let fmanager = FileManagerServices()
    let viewModel = LibraryViewModel()
    let group = DispatchGroup()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        if let bookLibrary = BookLibraryViewController.books {
            books = bookLibrary
        } else {
            group.enter()
            let serialSaved = UserDefaults.standard.object(forKey: "SerialValidCode") as? String
            viewModel.getLibraryBooks(identifier: serialSaved!) { library in
                
                self.books = library.books
                self.group.leave()
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
            self.viewModel.getThumbnailImage(imageURL: self.books[indexPath.row].thumbnailName) { image in
                cell?.thumbnailImage.image = image
                cell?.activityIndicator.isHidden = true
                cell?.bookSelectedName = self.books[indexPath.row].fileName
                cell?.downloadButton.isHidden = false
                
                for name in FileManagerServices().getNameDocumentsOnDirectory() {
                    if name == self.books[indexPath.row].fileName {
                        cell?.downloadButton.isHidden = true
                        print("> \(name) exist on storage device")
                        break
                    }
                }
            }
        }
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let fileName: String = books[indexPath.row].fileName
        let remotePDFDocumentURL = URL(string: fmanager.getPathOf(file: fileName))!
        let reader = PDFViewController.createNew(with: PDFDocument(url: remotePDFDocumentURL)!, title: fileName)
        
        if let myViewController = self.parentViewController as? BookLibraryViewController {
            myViewController.navigationController!.pushViewController(reader, animated: true)
        }
    }
}

// UICollectionViewDelegateFlowLayout
extension BookTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = TableConstants.getItemWidth(boundWidth: collectionView.bounds.size.width)
        return CGSize(width: itemWidth + 100, height: itemWidth*2.2)
    }
}
