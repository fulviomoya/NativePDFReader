//
//  Books.swift
//  NativePDFReader
//
//  Created by Fulvio Moya on 4/19/18.
//  Copyright © 2018 Fulvio Moya. All rights reserved.
//

import Foundation

struct Library: Decodable {
    let books: [Book]
    
    enum CodingKeys: String, CodingKey {
        case books = "items"
    }
}

struct Book: Decodable {
    let id: String
    let thumbnailName: String
    let fileName: String
    let expirationDate: String
    let isDownloaded: Bool? = false
    
    enum CodingKeys: String, CodingKey {
        case id = "articulo"
        case thumbnailName = "nombre_portada"
        case fileName = "nombre_archivo"
        case expirationDate = "fecha_vence"
    }
}
