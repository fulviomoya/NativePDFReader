//
//  ValidationCodeViewController.swift
//  NativePDFReader
//
//  Created by Fulvio Moya on 4/19/18.
//  Copyright © 2018 Fulvio Moya. All rights reserved.
//

import UIKit

class ValidationCodeViewController: BaseViewController {
    var model: LibraryViewModel!
    
    @IBOutlet weak var validateButton: UIButton!
    @IBOutlet weak var codeTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        model = LibraryViewModel()
    }
    
    @IBAction func validateButtonTouched(_ sender: Any) {
        UserDefaults.standard.set(codeTextField.text, forKey: "SerialValidCode")
        self.performSegue(withIdentifier: "validationCodeToLibrarySegue", sender: codeTextField.text)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "validationCodeToLibrarySegue" {
             LibraryViewController.validationCode = sender as? String
        }
    }
    
    @IBAction func serialCodeEditBegin(_ sender: Any) {
        if (codeTextField.text?.count)! > 0 {
            validateButton.isEnabled = true
        }
    }
}
