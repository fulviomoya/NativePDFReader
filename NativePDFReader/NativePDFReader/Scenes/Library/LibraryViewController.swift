//
//  LibraryViewController.swift
//  NativePDFReader
//
//  Created by Fulvio Moya on 4/20/18.
//  Copyright © 2018 Fulvio Moya. All rights reserved.
//

import UIKit

class LibraryViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    static var validationCode: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //disabling scroll because no need scroll inside cell
        tableView.isScrollEnabled = false
        tableView.dataSource = self
        tableView.delegate   = self
    }
}

extension LibraryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            return tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath)
        default:
             return tableView.dequeueReusableCell(withIdentifier: "BookCollectionCell", for: indexPath)
        }
    }
}

//UITableViewDelegate
extension LibraryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0: //header cell
            return 100
        case 1: //collection cell
            let itemHeight = TableConstants.getItemWidth(boundWidth: tableView.bounds.size.width)
            let totalRow = ceil(TableConstants.totalItem / TableConstants.column)
            
            let totalTopButtonOffset = TableConstants.offset * 2
            
            let totalSpacing = CGFloat(totalRow - 1) * TableConstants.offset
            let totalHeight = ((itemHeight * CGFloat(totalRow)) + totalTopButtonOffset + totalSpacing)
            
            return totalHeight
        default:
            return UITableViewAutomaticDimension
        }
    }
    
}
