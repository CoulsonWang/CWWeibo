//
//  WBStatusTableViewCell.swift
//  CWWeibo
//
//  Created by Coulson_Wang on 2017/7/6.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

import UIKit
import SDWebImage

class WBStatusTableViewCell: UITableViewCell {
    // MARK:- 约束
    @IBOutlet weak var textLabelConstraintWidth: NSLayoutConstraint!
    @IBOutlet weak var textLabelConstraintLeftMargin: NSLayoutConstraint!
    // MARK:- 控件
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var vertifyImageView: UIImageView!
    @IBOutlet weak var vipLevelView: UIImageView!
    @IBOutlet weak var contentTextLabel: UILabel!
    // MARK:- 模型属性
    var viewModel : WBStatusViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            
            profileImageView.sd_setImage(with: viewModel.profileImageURL, placeholderImage: #imageLiteral(resourceName: "avatar_default_small"))
            nameLabel.text = viewModel.status?.user?.screen_name
            timeLabel.text = viewModel.creatTimeText
            vertifyImageView.image = viewModel.vipLevelImage
            sourceLabel.text = viewModel.sourceText
            vipLevelView.image = viewModel.vipLevelImage
            contentTextLabel.text = viewModel.status?.text
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        profileImageView.makeCircle()
        textLabelConstraintWidth.constant = UIScreen.main.bounds.width - 2 * textLabelConstraintLeftMargin.constant
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
