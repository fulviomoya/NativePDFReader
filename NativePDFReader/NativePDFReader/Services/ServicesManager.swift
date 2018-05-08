//
//  ServicesProtocol.swift
//  NativePDFReader
//
//  Created by Fulvio Moya on 4/19/18.
//  Copyright © 2018 Fulvio Moya. All rights reserved.
//

import Foundation
import Alamofire

typealias completionHandler = (Library) -> Void

protocol ServicesProtocol {
    func getSerialCollection(serial code: String, completion: @escaping completionHandler)
}

class ServicesManager: ServicesProtocol {
    var completeLibrary: Library?
    func getSerialCollection(serial code: String, completion: @escaping completionHandler) {
        Alamofire.request(SensitiveConstants.COLLECTION_INFO + code).responseJSON { dataResponse in
            guard let _ = dataResponse.data else {
                print(Errors.NO_DATA_FOUND)
                return
            }
            
            guard let library = try? JSONDecoder().decode(Library.self, from: dataResponse.data!) else {
                print(Errors.CANT_DECODE_DATA)
                return
            } 
            completion(library)
        }
    }
}
