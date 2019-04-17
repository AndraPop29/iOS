//
//  ListCell.swift
//  FlowControllersExample
//
//  Created by Halcyonmobile on 28/02/2018.
//  Copyright © 2018 Halcyonmobile. All rights reserved.
//

import UIKit

class Cell: UITableViewCell {
    
    private var lblTitle = UILabel()
    private var lblDirector = UILabel()
    
    var viewModel: CellViewModel? {
        didSet {
            lblTitle.text = viewModel?.title
            lblDirector.text = viewModel?.director
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    
    }
  
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        lblTitle.textColor = .red
        lblTitle.frame = CGRect(x: 10, y: 10, width: 200, height: 30)
        
        lblDirector.textColor = .black
        lblDirector.frame = CGRect(x: 10, y: 30, width: 200, height: 30)
        contentView.addSubview(lblTitle)
        contentView.addSubview(lblDirector)
    }
}
