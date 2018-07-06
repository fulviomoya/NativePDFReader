//
//  BookTableViewCell+UICollectionViewDataSource.swift
//  NativePDFReader
//
//  Created by Fulvio Moya on 7/5/18.
//  Copyright © 2018 Fulvio Moya. All rights reserved.
//

import UIKit
import PDFReader

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
