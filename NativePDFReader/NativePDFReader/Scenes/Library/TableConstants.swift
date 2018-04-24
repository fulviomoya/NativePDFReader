//
//  BookTableConstants.swift
//  NativePDFReader
//
//  Created by Fulvio Moya on 4/20/18.
//  Copyright © 2018 Fulvio Moya. All rights reserved.
//

import Foundation
import UIKit

class TableConstants {
    static let totalItem: CGFloat = 37
    static let column: CGFloat = 4
    
    static let minLineSpacing: CGFloat = 1
    static let minItemSpacing: CGFloat = 1
    
    static let offset: CGFloat = 10
    
    static func getItemWidth(boundWidth: CGFloat) -> CGFloat {
        let totalWidth = boundWidth - (offset * 2 ) - ((column - 1) * minItemSpacing)
        
        return totalWidth / column
    }
}
