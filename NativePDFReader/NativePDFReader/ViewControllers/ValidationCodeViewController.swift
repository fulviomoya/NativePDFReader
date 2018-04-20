//
//  ValidationCodeViewController.swift
//  NativePDFReader
//
//  Created by Fulvio Moya on 4/19/18.
//  Copyright © 2018 Fulvio Moya. All rights reserved.
//

import UIKit

class ValidationCodeViewController: BaseViewController {
    var api: APIManager?
    
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var codeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.api = APIManager()
        
    }
    
    @IBAction func validateButtonTouched(_ sender: Any) {
        api!.getLibraryBooks(identifier: codeTextField.text!){ response in 
            for book in response.books {
                print("book title: \(book.fileName)")
            }
        }
    }
}

/*for book in (self.service.completeLibrary?.books)! {
 self.service.downloadImage(url: book.thumbnailName, completetion: {
 self.thumbnailImage.image = self.service.ima
 })
 }
 */
