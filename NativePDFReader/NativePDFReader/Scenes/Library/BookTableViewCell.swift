//
//  BookTableViewCell.swift
//  NativePDFReader
//
//  Created by Fulvio Moya on 4/20/18.
//  Copyright © 2018 Fulvio Moya. All rights reserved.
//

import UIKit
import QuickLook
import PDFReader

class BookTableViewCell: UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var books: [Book]!
    
    let service = ServiceManagerFake()
    let fmanager = FileManagerServices()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        service.getSerialCollection(serial: (LibraryViewController.validationCode)!) { libary in
            self.books = libary.books
        }
    }
}

// UICollectionViewDataSource
extension BookTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return books.count  //Int(TableConstants.totalItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookCell", for: indexPath) as? BookItemCollectionViewCell
        service.downloadImageAsync(url: books[indexPath.row].thumbnailName) { image in
            cell?.thumbnailImage.image = image
            cell?.activityIndicator.isHidden = true
            cell?.downloadButton.isHidden = false
            cell?.bookSelectedName = self.books[indexPath.row].fileName
        }
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let fileName: String = books[indexPath.row].fileName
        let remotePDFDocumentURL = URL(string: fmanager.read(file: fileName))!
        let reader = PDFViewController.createNew(with: PDFDocument(url: remotePDFDocumentURL)!, title: fileName)
        
        if let myViewController = parentViewController as? LibraryViewController {
            myViewController.navigationController!.pushViewController(reader, animated: true)
        }
    }
}

// UICollectionViewDelegateFlowLayout
extension BookTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = TableConstants.getItemWidth(boundWidth: collectionView.bounds.size.width)
        return CGSize(width: itemWidth + 100, height: itemWidth*2.2) //Same because is a square
    }
}

extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}
