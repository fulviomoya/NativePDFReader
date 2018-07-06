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
            for serialSaved in UserDefaults.standard.array(forKey: "SerialValidCode") as! [String] {
                viewModel.getLibraryBooks(identifier: serialSaved) { library in
                    self.books = library.books
                    self.group.leave()
                }
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

// UICollectionViewDelegateFlowLayout
extension BookTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = TableConstants.getItemWidth(boundWidth: collectionView.bounds.size.width)
        return CGSize(width: itemWidth + 100, height: itemWidth*2.2)
    }
}
