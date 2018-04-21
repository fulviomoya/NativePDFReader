//
//  LibraryViewModel.swift
//  NativePDFReader
//
//  Created by Fulvio Moya on 4/20/18.
//  Copyright © 2018 Fulvio Moya. All rights reserved.
//

import Foundation

class LibraryViewModel {
    let service: ServicesProtocol!
    
    init() {
        service = ServicesManager()
    }
    
    func getLibraryBooks(identifier isbn: String, successHandler: @escaping completionHandler) {
        self.service.getSerialCollection(serial: isbn, completion: successHandler)
    }
    
    func getThumbnailImage(imageURL: String, successHandler: @escaping completionImageHandler) {
        self.service.downloadImageAsync(url: imageURL, completion: successHandler)
    }
}
