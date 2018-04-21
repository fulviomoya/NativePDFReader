//
//  ValidationCodeViewController.swift
//  NativePDFReader
//
//  Created by Fulvio Moya on 4/19/18.
//  Copyright © 2018 Fulvio Moya. All rights reserved.
//

import UIKit
import QuickLook

class ValidationCodeViewController: BaseViewController, QLPreviewControllerDataSource {
    var model: LibraryViewModel!
    var quicklook: QLPreviewController!
    
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var inProgressActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var downloadButton: UIButton!

    @IBOutlet weak var bookButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model = LibraryViewModel()
        quicklook = QLPreviewController()
        quicklook.dataSource = self
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
    
    @IBAction func showBook(_ sender: Any) {
        super.present(quicklook, animated: true, completion: nil)
    }
    
    @IBAction func downloadPDFTouched(_ sender: Any) {
        print("Let's start download ...")
        let wasSuccess = model.savePDFToLocalFileSystem(pdfURL: GeneralConstants.DUMMY_PDF)
        print("result: \(String(describing: wasSuccess))")
        bookButton.isHidden = false
    }
    
    private func setThumbnailImage(_ newImage: UIImage)  {
        self.thumbnailImage.image = newImage
        self.inProgressActivityIndicator.isHidden = true
        self.downloadButton.isHidden = false
    }
}

// Quicklook data source
extension ValidationCodeViewController {
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return 1
    }
    
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        let fileNamePath = FileManagerServices().read(file: "")
        print("item: \(fileNamePath)")
        return NSURL(fileURLWithPath: fileNamePath)
    }
}
