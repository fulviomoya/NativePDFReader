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
    
    @IBAction func downloadButtonTouched(_ sender: Any) {
        print("Let's start download ...")
        let model = LibraryViewModel()
        let wasSuccess = model.savePDFToLocalFileSystem(pdfURL: GeneralConstants.DUMMY_PDF)
        print("result: \(String(describing: wasSuccess))")
        downloadButton.isHidden = true
    }
}
