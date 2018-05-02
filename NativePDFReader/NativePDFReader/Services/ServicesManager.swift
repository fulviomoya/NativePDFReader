//
//  ServicesProtocol.swift
//  NativePDFReader
//
//  Created by Fulvio Moya on 4/19/18.
//  Copyright © 2018 Fulvio Moya. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

protocol ServicesProtocol {
    func getSerialCollection(serial code: String, completion: @escaping completionHandler)
    func downloadImageAsync(url: String, completion: @escaping completionImageHandler)
    func downloadPDFFile(url: String) -> NSData?
}

typealias completionHandler = (Library) -> Void
typealias completionImageHandler = (UIImage) -> Void

class ServicesManager: ServicesProtocol {
    var completeLibrary: Library?
    var ima: UIImage?
    
    func getSerialCollection(serial code: String, completion: @escaping completionHandler) {
        Alamofire.request(SensitiveConstants.COLLECTION_INFO + code).responseJSON{ dataResponse in
            guard let _ = dataResponse.data else {
                print("Error: No data to decode")
                return
            }
            
            guard let library = try? JSONDecoder().decode(Library.self, from: dataResponse.data!) else {
                print("Error: Coudn't decode data into Library")
                return
            }
            completion(library)
        }
    }
    
    func downloadImageAsync(url: String, completion: @escaping completionImageHandler){
        Alamofire.request(url).responseImage { response in
            guard let image = response.result.value else {
                print("image can't be downloaded")
                return
            }
            completion(image)
        }
    }
    
    func downloadPDFFile(url: String) -> NSData? {
        let downloadService = DownloadServices()
        downloadService.startDownload(url: url)
     /*   guard let pdfData = NSData(contentsOf: URL(string: url + "," + "L429OKT1XJBBB2R")!) else {
            print("ERROR: A problem download the pdf file")
            return nil
        }
        
        print(">> Download success")
        return pdfData */
        return nil
    }
}
