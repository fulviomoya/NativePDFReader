//
//  Download.swift
//  NativePDFReader
//
//  Created by Fulvio Moya  on 4/29/18.
//  Copyright © 2018 Fulvio Moya. All rights reserved.
//

import Foundation

class Download {
    var track: Int
    
    init(track: Int) {
        self.track = track
    }
    
    var task: URLSessionDownloadTask?
    var isDownloading = false
    var resumeData: Data?
    
    var progress: Float = 0
}
