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
        documentDirectory = try! fileManager.url(for: .documentDirectory, in: .userDomainMask,
                                                 appropriateFor: nil, create: false)
    }
    
    func writeNew(file fileName: String, data: Data) -> Bool {
        let fileURL = documentDirectory?.appendingPathComponent(fileName)
        do {
            try data.write(to: fileURL!, options: .atomicWrite)
            print("File saved on device disk")
        } catch {
            return false
        }
        return true
    }
    
    func getPathOf(file fileName: String) -> String {
        for file in getLocalFileRoute() {
            if file.lastPathComponent == fileName {
                return file.absoluteString
            }
        }
        //Fix that what return when no exist documents
        return getLocalFileRoute()[0].absoluteString
    }
    
    func getLocalFileRoute() -> [URL] {
        let contentDirectory = try! fileManager.contentsOfDirectory(at: documentDirectory!, includingPropertiesForKeys: nil,
                                                                    options: .skipsHiddenFiles)
        return contentDirectory
    }
    
    func getNameDocumentsOnDirectory() -> [String] {
        var fileNames: [String] = []
        
        for file in getLocalFileRoute() {
            fileNames.append(file.absoluteURL.lastPathComponent)
        }
        return fileNames
    }
}
