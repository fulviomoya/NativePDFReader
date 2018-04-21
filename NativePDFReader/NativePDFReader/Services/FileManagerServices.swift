//
//  FileManager.swift
//  NativePDFReader
//
//  Created by Fulvio Moya  on 4/21/18.
//  Copyright © 2018 Fulvio Moya. All rights reserved.
//

import Foundation

class FileManagerServices {
    var fileManager: FileManager!
    var documentDirectory: URL?
    
    init() {
        fileManager = FileManager.default
        documentDirectory = try! fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil,
                                                create: false)
    }
    
    func writeNew(file fileName: String, data: NSData) -> Bool{
        //  let pathWithNameFile = documentDirectory.lastPathComponent + fileName
        let fileURL = documentDirectory?.appendingPathComponent(fileName)
        
        return data.write(to: fileURL!, atomically: true)
    }
    
    func read(file fileName: String) -> String {
        let currentDirectoryFileNames = try! fileManager.contentsOfDirectory(at: documentDirectory!, includingPropertiesForKeys: nil,
                                                                        options: .skipsHiddenFiles)
        //print(currentDirectoryFileNames)
        //FIXME: make a search file to indentify by name
        return currentDirectoryFileNames[0].absoluteString

    }
}
