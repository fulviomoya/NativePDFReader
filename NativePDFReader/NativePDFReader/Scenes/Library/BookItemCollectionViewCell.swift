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
        for state: UIControlState in [.normal, .highlighted, .disabled, .selected, .focused, .application, .reserved] {
            downloadButton.setTitle("Downloading...", for: state)
        }
        
        let wasSuccess = LibraryViewModel().savePDFToLocalFileSystem(path: SensitiveConstants.TEMP_PATH , fileName:  bookSelectedName!)
        print("result: \(String(describing: wasSuccess))")
        downloadButton.isHidden = true
    }
}
