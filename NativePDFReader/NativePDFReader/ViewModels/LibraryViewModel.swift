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
    let fileManager: FileManagerServices!
    
    init() {
        service = ServicesManager()//ServiceManagerFake()
        fileManager = FileManagerServices()
    }
    
    func getLibraryBooks(identifier isbn: String, successHandler: @escaping completionHandler) {
        self.service.getSerialCollection(serial: isbn, completion: successHandler)
    }
    
    func getThumbnailImage(imageURL: String, successHandler: @escaping completionImageHandler) {
        self.service.downloadImageAsync(url: imageURL, completion: successHandler)
    }
    
    func savePDFToLocalFileSystem(path: String, fileName: String ) -> Bool {
        let filePathSerial = path  + fileName// + "," + "F5TFXF3X5FEKJ6C"
        if let pdf = self.service.downloadPDFFile(url: filePathSerial) {
            if fileManager.writeNew(file: fileName, data: pdf) {
                print(">> Save file correct")
                return true
            }
        }
        print("> Something bad happend can't save")
        return false
    }
}
