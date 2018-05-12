//
//  DownloadServices.swift
//  NativePDFReader
//
//  Created by Fulvio Moya  on 4/29/18.
//  Copyright © 2018 Fulvio Moya. All rights reserved.
//

import Alamofire
import AlamofireImage

typealias completionImageHandler = (UIImage) -> Void

protocol DownloadServicesProtocol {
    func downloadImageAsync(url: String, completion: @escaping completionImageHandler)
    func downloadPDFFile(url: String) -> Data?
}

class DownloadServices: DownloadServicesProtocol {
    func downloadImageAsync(url: String, completion: @escaping completionImageHandler){
        Alamofire.request(url).responseImage { response in
            guard let image = response.result.value else {
                print("image can't be downloaded")
                return
            }
            completion(image)
        }
    }
    
    func downloadPDFFile(url: String) -> Data? {
        guard let pdfData = NSData(contentsOf: URL(string: url)!) else {
            print("ERROR: A problem download the pdf file")
            return nil
        }
        print(">> Download success")
        return pdfData as Data
    }
    //TODO: Create a light version to verify the books' names and match with downloaded
}
