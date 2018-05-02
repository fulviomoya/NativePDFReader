//
//  GeneralConstants.swift
//  NativePDFReader
//
//  Created by Fulvio Moya on 4/19/18.
//  Copyright © 2018 Fulvio Moya. All rights reserved.
//

import Foundation

enum GeneralConstants {
    static let DUMMY_PDF = "http://www.pdf995.com/samples/pdf.pdf"
}

enum DocumentStatus: String {
    case IN_PROGRESS
    case DOWNLOADING
    case READY_TO_READ
}
