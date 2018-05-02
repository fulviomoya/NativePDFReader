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
    
    func writeNew(file fileName: String, data: Data) -> Bool{
        let fileURL = documentDirectory?.appendingPathComponent(fileName)
        do {
            try data.write(to: fileURL!, options: .atomic)
            print("File saved on device disk")
        } catch {
            return false
        }
        return true
    }
    
    func read(file fileName: String) -> String {
        let currentDirectoryFileNames = try! fileManager.contentsOfDirectory(at: documentDirectory!, includingPropertiesForKeys: nil,
                                                                             options: .skipsHiddenFiles)
        for file in currentDirectoryFileNames {
            if file.lastPathComponent == fileName {
                return file.absoluteString
            }
        }
        return currentDirectoryFileNames[0].absoluteString
    }
}
