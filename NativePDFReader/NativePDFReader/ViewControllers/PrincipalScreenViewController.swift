//
//  ViewController.swift
//  NativePDFReader
//
//  Created by Fulvio Moya on 4/19/18.
//  Copyright © 2018 Fulvio Moya. All rights reserved.
//

import UIKit

class ViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad() 
    }
    @IBOutlet weak var testButton: UIButton!
    
    @IBAction func testButtonTouched(_ sender: Any) {
        testButton.setTitle("Touched.!", for: .normal)
    }
}
