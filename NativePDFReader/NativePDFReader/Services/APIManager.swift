//
//  APIManager.swift
//  NativePDFReader
//
//  Created by Fulvio Moya on 4/19/18.
//  Copyright © 2018 Fulvio Moya. All rights reserved.
//

import Foundation

class APIManager {
    let service: ServicesProtocol!
    
    init() {
        service = ServicesManager()
    }
    
    func getLibraryBooks(identifier isbn: String, completion: @escaping completionHandler) {
        self.service.getSerialCollection(serial: isbn, completion: completion)
    }
}
