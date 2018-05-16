//
//  BookItemCollectionViewCell.swift
//  NativePDFReader
//
//  Created by Fulvio Moya  on 4/22/18.
//  Copyright © 2018 Fulvio Moya. All rights reserved.
//

import UIKit

class BookItemCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var downloadButton: UIButton!
    
    var bookSelectedName: String?
    
    @IBAction func downloadButtonTouched(_ sender: Any) {
        print("Let's start download ... \(bookSelectedName!)")
        activityIndicator.isHidden = false
        activityIndicator.color = UIColor.white
        
        downloadButton.setTitle("Downloading...", for: .normal)
        self.layoutIfNeeded()
        
        DispatchQueue.global(qos: .utility).async {
            let wasSuccess = LibraryViewModel().saveToLocalFileSystem(path: SensitiveConstants.BOOK_PATH,
                                                                         fileName: self.bookSelectedName!)
            print("result: \(String(describing: wasSuccess))")
            self.downloadButton.isHidden = true
            self.activityIndicator.isHidden = true
        }
    }
}
