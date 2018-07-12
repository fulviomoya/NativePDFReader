//
//  AvanceEncryptation.swift
//  NativePDFReader
//
//  Created by Fulvio Moya  on 7/10/18.
//  Copyright © 2018 Fulvio Moya. All rights reserved.
//

import Foundation
import CryptoSwift

class AvanceEncryptation {
    public static let json = "{\"initVector\":\"KEQySyRSLUMqQTVNK1tVMg\\u003d\\u003d\\r\\n\",\"key\":\"A00he8$DOG#\"}"
    
    func aesDesencrypt(key: String, ivData: String, dataEncrypt: ArraySlice<UInt8>) throws -> String {
        let keyTrimmed = key.trimmingCharacters(in: .whitespacesAndNewlines)
        let keyUTLFormatted = keyTrimmed.bytes
        
       // let desencrypt = try! AES(key: key, blockMode: CBC(ivData)).decrypt(dataEncrypt)
        
        return ""
    }
    
    func decodeJson(string json: String) -> [String: String]{
        let decoder = JSONDecoder()
        var dictionary: [String: String]  = [:]
        let keychain: KeyChain = try! decoder.decode(KeyChain.self, from: json.data(using: .utf8)!)
        print("initVector: \(keychain.initVector.trimmingCharacters(in: .whitespacesAndNewlines)) (.) key: \(keychain.key)")
        
        return dictionary
    }
}

struct KeyChain: Codable {
    var initVector: String
    var key: String
}
