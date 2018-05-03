//
//  ViewController.swift
//  NativePDFReader
//
//  Created by Fulvio Moya on 4/19/18.
//  Copyright © 2018 Fulvio Moya. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    @IBOutlet weak var libraryButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        if FileManagerServices().getNameDocumentsOnDirectory().count > 0  &&
            UserDefaults.standard.object(forKey: "SerialValidCode") != nil {
            libraryButton.isEnabled = true
        }
    }
}
