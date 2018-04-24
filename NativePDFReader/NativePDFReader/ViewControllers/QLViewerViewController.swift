//
//  QLViewerViewController.swift
//  NativePDFReader
//
//  Created by Fulvio Moya  on 4/22/18.
//  Copyright © 2018 Fulvio Moya. All rights reserved.
//

import UIKit
import PDFReader

class QLViewerViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let remotePDFDocumentURL = URL(string: GeneralConstants.DUMMY_PDF)!
        let document = PDFDocument(url: remotePDFDocumentURL)!
        let reader = PDFViewController.createNew(with: document, title: "Favorite Cupcakes")
        self.navigationController!.pushViewController(reader, animated: true)
    }
    
    @IBAction func touched(_ sender: Any) {
       
    }
}
