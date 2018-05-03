//
//  LibraryViewModel.swift
//  NativePDFReader
//
//  Created by Fulvio Moya on 4/20/18.
//  Copyright © 2018 Fulvio Moya. All rights reserved.
//

import Foundation

class LibraryViewModel {
    let downloadService: DownloadServicesProtocol!
    let apiService: ServicesProtocol!
    let fileManager: FileManagerServices!
    
    init() {
        downloadService = DownloadServices()
        fileManager = FileManagerServices()
        apiService = ServicesManager()
    }
    
    func getLibraryBooks(identifier code: String, successHandler: @escaping completionHandler) {
        apiService.getSerialCollection(serial: code, completion: successHandler)
    }
    
    func getThumbnailImage(imageURL: String, successHandler: @escaping completionImageHandler) {
        downloadService.downloadImageAsync(url: imageURL, completion: successHandler)
    }
    
    func savePDFToLocalFileSystem(path: String, fileName: String ) -> Bool {
        let filePathSerial = path + fileName
        if let pdf = downloadService.downloadPDFFile(url: filePathSerial) {
            if fileManager.writeNew(file: fileName, data: pdf) {
                print(">> Save file correct")
                return true
            }
        }
        print("> Something bad happend can't save")
        return false
    }
}
