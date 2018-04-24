//
//  BookTableViewCell.swift
//  NativePDFReader
//
//  Created by Fulvio Moya on 4/20/18.
//  Copyright © 2018 Fulvio Moya. All rights reserved.
//

import UIKit
import QuickLook

class BookTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var books: [Book]!
    
    let service = ServiceManagerFake()
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        service.getSerialCollection(serial: (LibraryViewController.validationCode)!) { libary in
            self.books = libary.books
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
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
        }
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       // self.books[indexPath.row].fileName
    }
}

// UICollectionViewDelegateFlowLayout
extension BookTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = TableConstants.getItemWidth(boundWidth: collectionView.bounds.size.width)
        return CGSize(width: itemWidth + 100, height: itemWidth*2.2) //Same because is a square
    }
}
