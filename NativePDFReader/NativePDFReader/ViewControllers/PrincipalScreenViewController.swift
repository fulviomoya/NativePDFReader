//
//  ViewController.swift
//  NativePDFReader
//
//  Created by Fulvio Moya on 4/19/18.
//  Copyright © 2018 Fulvio Moya. All rights reserved.
//

import UIKit

class ViewController: BaseViewController {
    
    @IBOutlet weak var image: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad() 
    }
    
    @IBAction func testButtonTouched(_ sender: Any) {
        let download = DownloadServices()
        download.startDownload(url: "http://susaetaon.com:8080/ords/susaetaon/archivos/descargas/1,99")
       
        let fmanager = FileManagerServices()
        let imageName = fmanager.read(file: "newPhoto.png")
        
        image.image = UIImage(contentsOfFile: imageName)
        loadViewIfNeeded()
    }
}
