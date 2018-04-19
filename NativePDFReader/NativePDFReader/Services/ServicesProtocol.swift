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
    func getSerialCollection(serial code: String) -> [String]
}

class ServicesManager: ServicesProtocol {
    func getSerialCollection(serial code: String) -> [String] {
        Alamofire.request("http://application.com:8080/ords/application/archivos/coleccion/\(code)").responseJSON (completionHandler: responseHandler)
        return []
    }
    
    func responseHandler(data: DataResponse<Any> ) {
        print("result \(data.result.value)")
    }
}
