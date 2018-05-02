//
//  ViewController.swift
//  NativePDFReader
//
//  Created by Fulvio Moya on 4/19/18.
//  Copyright © 2018 Fulvio Moya. All rights reserved.
//

import UIKit

class ViewController: BaseViewController {
    @IBOutlet weak var libraryButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if FileManagerServices().getNameDocumentsOnDirectory().count > 0  &&
            UserDefaults.standard.object(forKey: "SerialValidCode") != nil {
            libraryButton.isEnabled = true
        }
    }
    
    /*@IBAction func testButtonTouched(_ sender: Any) {
        DownloadServices().startDownload(url: "http://susaetaon.com:8080/ords/susaetaon/archivos/descargas/1,99")
        
        let imageName = FileManagerServices().getPathOf(file: "newPhoto.png")
        
        image.image = UIImage(contentsOfFile: imageName)
        loadViewIfNeeded()
    }*/
}
