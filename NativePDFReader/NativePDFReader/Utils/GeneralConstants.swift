//
//  GeneralConstants.swift
//  NativePDFReader
//
//  Created by Fulvio Moya on 4/19/18.
//  Copyright © 2018 Fulvio Moya. All rights reserved.
//

import Foundation
import UIKit

enum GeneralConstants {
    static let DUMMY_PDF = "http://www.pdf995.com/samples/pdf.pdf"
    static let START_PERIOD_MONTH = 8
}

enum DocumentStatus: String {
    case IN_PROGRESS
    case DOWNLOADING
    case READY_TO_READ
}

enum Errors {
    static let NO_DATA_FOUND    = "No found data for decode"
    static let CANT_DECODE_DATA = "Coudn't decode data into object"
}

enum TableConstants {
    static let totalItem: CGFloat = 7*2
    static let column: CGFloat = 3
    
    static let minLineSpacing: CGFloat = 1
    static let minItemSpacing: CGFloat = 1
    
    static let offset: CGFloat = 10
    
    static func getItemWidth(boundWidth: CGFloat) -> CGFloat {
        let totalWidth = boundWidth - (offset * 2 ) - ((column - 1) * minItemSpacing)
        
        return totalWidth / column
    }
}
