//
//  DownloadServices.swift
//  NativePDFReader
//
//  Created by Fulvio Moya  on 4/29/18.
//  Copyright © 2018 Fulvio Moya. All rights reserved.
//

import Foundation

class DownloadServices {
    // var downloadSession: URLSession!
    var activeDownloads: [Int: Download] = [:]
    
    func startDownload(url: String) {
        let download = Download(track: 1)
        let urlSession = URLSession(configuration: .default)
        var dataTask: URLSessionDataTask?
        let fmanager = FileManagerServices()
        
        dataTask = urlSession.dataTask(with: URL(string: url)!) {  (data, response, error) in
            if error != nil {
                print("\(String(describing: error?.localizedDescription))")
            }
            guard let pdf = data else {
                print("error in download")
                return
            }
            
            if fmanager.writeNew(file: "newPhoto.png", data: pdf) {
                print("> download success")
               
            }
        }
        dataTask?.resume()
        
        download.isDownloading = true
        activeDownloads[download.track] = download
    }
}
