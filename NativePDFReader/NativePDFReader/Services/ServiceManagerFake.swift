//
//  ServiceManagerFake.swift
//  NativePDFReader
//
//  Created by Fulvio Moya on 4/23/18.
//  Copyright © 2018 Fulvio Moya. All rights reserved.
//

import Foundation

class ServiceManagerFake: ServicesManager {
    var fakeLibrary: Library?
    
    override init() {
        super.init()
        self.fakeLibrary = Library(books: self.createAFakeBook())
    }
    
    override func getSerialCollection(serial code: String, completion: @escaping completionHandler) {
        completion(fakeLibrary!)
    }
    
    override func downloadImageAsync(url: String, completion: @escaping completionImageHandler) {
       // super.downloadImageAsync(url: SensitiveConstants.TEMP_PATH + url, completion: completion)
         super.downloadImageAsync(url: url, completion: completion)
    }
    
    override func downloadPDFFile(url: String) -> NSData? {
        return super.downloadPDFFile(url: url)
    }
    
    func createAFakeBook() -> [Book] {
        let book  = Book(id: "1234", thumbnailName: "http://susaetaon.com:8080/portadas/978994512513.png", fileName: "978994512513.pdf", expirationDate: "NoNe")
        let book2 = Book(id: "1234", thumbnailName: "http://susaetaon.com:8080/portadas/978994512514.png", fileName: "978994512514.pdf", expirationDate: "NoNe")
        let book3 = Book(id: "1234", thumbnailName: "http://susaetaon.com:8080/portadas/978994512517.png", fileName: "978994512517.pdf", expirationDate: "NoNe")
        let book4 = Book(id: "1234", thumbnailName: "http://susaetaon.com:8080/portadas/978994512518.png", fileName: "978994512518.pdf", expirationDate: "NoNe")
     
        return [book, book2, book3, book4]
    }
    
}
