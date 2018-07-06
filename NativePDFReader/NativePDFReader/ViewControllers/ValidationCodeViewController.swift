//
//  ValidationCodeViewController.swift
//  NativePDFReader
//
//  Created by Fulvio Moya on 4/19/18.
//  Copyright © 2018 Fulvio Moya. All rights reserved.
//

import UIKit

class ValidationCodeViewController: BaseViewController {
    @IBOutlet weak var errorBar: UIView!
    @IBOutlet weak var validateButton: UIButton!
    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var errorDescriptionLabel: UILabel!
    
    let libraryViewModel = LibraryViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.errorDescriptionLabel.text = "El código proporcionado no es valido favor verificar."
    }
    
    @IBAction func validateButtonTouched(_ sender: Any) {
        if (Network.reachability?.isRunningOnDevice)! &&
            Network.reachability?.status == Network.Status.unreachable  {
            self.errorDescriptionLabel.text = "No es posible establecer conexion de red"
            self.showErrorMessage()
        } else {
            libraryViewModel.getLibraryBooks(identifier: codeTextField.text!) { library in
                if library.books.count > 0 {
                    self.saveSerialApproved()
                    self.performSegue(withIdentifier: "validationCodeToLibrarySegue", sender: library.books)
                } else {
                    self.showErrorMessage()
                }
                self.codeTextField.text = ""
                self.removeFromParentViewController()
                self.validateButton.isEnabled = false
            }
        }
    }
    
    @IBAction func serialCodeEditBegin(_ sender: Any) {
        if (codeTextField.text?.count)! > 0 {
            validateButton.isEnabled = true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "validationCodeToLibrarySegue" {
            BookLibraryViewController.books = sender as? [Book]
        }
    }
    
    fileprivate func saveSerialApproved() {
        if var serialUsed = UserDefaults.standard.array(forKey: "SerialValidCode") as? [String] {
            if !serialUsed.contains(self.codeTextField.text!) { //Idenfy new serials.
                serialUsed.append(self.codeTextField.text!)
            }
            print("serial used serials: \(String(describing: serialUsed))")
            UserDefaults.standard.set(serialUsed, forKey: "SerialValidCode")
        } else {
            UserDefaults.standard.set([self.codeTextField.text!], forKey: "SerialValidCode")
        }
    }
    
    fileprivate func showErrorMessage() {
        UIView.animate(withDuration: 0.3, animations: {
            self.errorBar.alpha = 0.9
        })
        
        UIView.animate(withDuration: 5, animations: {
            self.errorBar.alpha = 0
        })
    }
}
