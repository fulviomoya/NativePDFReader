//
//  ValidationCodeViewController.swift
//  NativePDFReader
//
//  Created by Fulvio Moya on 4/19/18.
//  Copyright © 2018 Fulvio Moya. All rights reserved.
//

import UIKit
import QuickLook

class ValidationCodeViewController: BaseViewController {
    var model: LibraryViewModel!
    var quicklook: QLPreviewController!
    
    @IBOutlet weak var codeTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        model = LibraryViewModel()
    }
    
    @IBAction func validateButtonTouched(_ sender: Any) {
        self.performSegue(withIdentifier: "validationCodeToLibrarySegue", sender: codeTextField.text)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "validationCodeToLibrarySegue" {
             LibraryViewController.validationCode = sender as? String
        }
    }
}
