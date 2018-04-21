//
//  ValidationCodeViewController.swift
//  NativePDFReader
//
//  Created by Fulvio Moya on 4/19/18.
//  Copyright © 2018 Fulvio Moya. All rights reserved.
//

import UIKit

class ValidationCodeViewController: BaseViewController {
    var model: LibraryViewModel?
    
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var inProgressActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var downloadButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.model = LibraryViewModel()
    }
    
    @IBAction func validateButtonTouched(_ sender: Any) {
        model!.getLibraryBooks(identifier: codeTextField.text!){ response in
            for book in response.books {
                print("book title: \(book.fileName)")
                self.inProgressActivityIndicator.isHidden = false
                self.downloadButton.isHidden = true
                self.model!.getThumbnailImage(imageURL: book.thumbnailName,
                                              successHandler: self.setThumbnailImage)
            }
        }
    }
    
    @IBAction func downloadPDFTouched(_ sender: Any) {
        print("Let's start download ...")
    }
    
    private func setThumbnailImage(_ newImage: UIImage)  {
        self.thumbnailImage.image = newImage
        self.inProgressActivityIndicator.isHidden = true
        self.downloadButton.isHidden = false
    }
}
