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
    func downloadImageAsync(url: String)
}

typealias completionHandler = (Library) -> Void

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
            self.completeLibrary = library
            completion(library)
        }
    }
    
    func downloadImageAsync(url: String){
        Alamofire.request(url).responseImage { response in
            if let image = response.result.value {
                print("image downloaded: \(image)")
                self.ima = image
            }
        }
    }
}
