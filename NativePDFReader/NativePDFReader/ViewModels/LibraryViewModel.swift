//
//  LibraryViewModel.swift
//  NativePDFReader
//
//  Created by Fulvio Moya on 4/20/18.
//  Copyright © 2018 Fulvio Moya. All rights reserved.
//

import Foundation
import UIKit

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
    
    func getThumbnailImage(fileName: String, completion: @escaping completionImageHandler){
        let newThumbnailName = fileName.replacingOccurrences(of: ".pdf", with: ".png")
        
        if let localThumnailPath = fileManager.getPathOf(file: newThumbnailName){
            let localImage =  try! Data(contentsOf: URL(string: localThumnailPath)!)
            completion(UIImage(data: localImage)!)
        } else {
            //saving the thumbnailImage
            downloadService.downloadImageAsync(url: SensitiveConstants.THUMBNAIL_PATH + newThumbnailName){ image in
                let savedThumbnail = self.fileManager.writeNew(file: newThumbnailName, data: UIImagePNGRepresentation(image)!)
                print("was saved the thumbnail? \(savedThumbnail)")
                completion(image)
            }
        }
    }
    
    func saveToLocalFileSystem(path: String, fileName: String ) -> Bool {
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
