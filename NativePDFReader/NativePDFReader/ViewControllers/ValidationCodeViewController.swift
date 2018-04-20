//
//  ValidationCodeViewController.swift
//  NativePDFReader
//
//  Created by Fulvio Moya on 4/19/18.
//  Copyright © 2018 Fulvio Moya. All rights reserved.
//

import UIKit

class ValidationCodeViewController: BaseViewController {

    var service: ServicesManager!
    
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var codeTextField: UITextField!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        service = ServicesManager()
    }
   
    @IBAction func validateButtonTouched(_ sender: Any) {
        var image: UIImage?
            self.service.getSerialCollection(serial: (self.codeTextField?.text)!, completetion:  {
                for book in (self.service.completeLibrary?.books)! {
                    self.service.downloadImage(url: book.thumbnailName, completetion: {
                       self.thumbnailImage.image = self.service.ima
                    })
                }
                
              /*  if let imageValue = image {
                    let aspectScaledToFitImage = imageValue.af_imageAspectScaled(toFit: CGSize(width: 100.0, height: 100.0))
                     aspectScaledToFitImage
                    self.view.layoutIfNeeded()
                } */
            })
        
    }
}
