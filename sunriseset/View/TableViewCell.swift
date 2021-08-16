//
//  tabTableViewCell.swift
//  sunriseset
//
//  Created by Mohammed Al-Quraini on 8/12/21.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    static let identifier : String = "TableViewCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    
    
}
