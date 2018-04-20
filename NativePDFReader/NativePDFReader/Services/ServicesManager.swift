//
//  ServicesProtocol.swift
//  NativePDFReader
//
//  Created by Fulvio Moya on 4/19/18.
//  Copyright © 2018 Fulvio Moya. All rights reserved.
//

import Foundation
import Alamofire

protocol ServicesProtocol {
    func getSerialCollection(serial code: String) -> Library
}

class ServicesManager: ServicesProtocol {
    private var completeLibrary: Library!
    
    func getSerialCollection(serial code: String) -> Library {
        let URL = "http://application.com:8080/ords/application/archivos/coleccion/\(code)"
        Alamofire.request(URL).responseJSON{(dataResponse) in
            guard let _ = dataResponse.data else {
                print("Error: No data to decode")
                return
            }
            
            guard let library = try? JSONDecoder().decode(Library.self, from: dataResponse.data!) else {
                print("Error: Coudn't decode data into Library")
                return
            }
            
            self.completeLibrary = library
        }
        return completeLibrary
    }
}
