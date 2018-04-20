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
    func getSerialCollection(serial code: String,completetion:  @escaping ()->())
    func downloadImage(url: String, completetion: @escaping ()->())
}

class ServicesManager: ServicesProtocol {
    var completeLibrary: Library?
    var ima: UIImage?
    
    func getSerialCollection(serial code: String, completetion: @escaping ()->()) {
        let URL = "http://susaetaon.com:8080/ords/susaetaon/archivos/coleccion/\(code)"
        Alamofire.request(URL).responseJSON{ dataResponse in
            guard let _ = dataResponse.data else {
                print("Error: No data to decode")
                return
            }
            
            guard let library = try? JSONDecoder().decode(Library.self, from: dataResponse.data!) else {
                print("Error: Coudn't decode data into Library")
                return
            }
            //let image = downloadImage(url: URL(fileURLWithPath: library.books[0].thumbnailName))
            self.completeLibrary = library
            completetion()
        }
        
    }
    
    func handlerSuccess(dataResponse : DataResponse<Any>) {
        
    }
    
    func downloadImage(url: String, completetion: @escaping ()->()){
        
        Alamofire.request(url).responseImage { response in
            if let image = response.result.value {
                print("image downloaded: \(image)")
                self.ima = image
            }
            completetion()
        } 
    }
}
