//
//  QLViewerViewController.swift
//  NativePDFReader
//
//  Created by Fulvio Moya  on 4/22/18.
//  Copyright © 2018 Fulvio Moya. All rights reserved.
//

import UIKit
import QuickLook

class QLViewerViewController: UIViewController {
    let quicklook = QLPreviewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        quicklook.dataSource =  self
        self.Touched(quicklook)
    }
    
    @IBAction func Touched(_ sender: Any) {
         present(quicklook, animated: true, completion: nil)
    }
}

// Quicklook data source
extension QLViewerViewController: QLPreviewControllerDataSource {
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return 1
    }
    
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        let fileNamePath = FileManagerServices().read(file: "")
        print("item: \(fileNamePath)")
        return NSURL(fileURLWithPath: fileNamePath)
    }
}
