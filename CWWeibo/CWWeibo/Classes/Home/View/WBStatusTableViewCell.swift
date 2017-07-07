//
//  WBStatusTableViewCell.swift
//  CWWeibo
//
//  Created by Coulson_Wang on 2017/7/6.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

import UIKit

class WBStatusTableViewCell: UITableViewCell {

    @IBOutlet weak var textLabelConstraintWidth: NSLayoutConstraint!
    @IBOutlet weak var textLabelConstraintLeftMargin: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        textLabelConstraintWidth.constant = UIScreen.main.bounds.width - 2 * textLabelConstraintLeftMargin.constant
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
