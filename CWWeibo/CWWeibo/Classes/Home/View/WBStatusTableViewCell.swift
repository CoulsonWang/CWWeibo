//
//  WBStatusTableViewCell.swift
//  CWWeibo
//
//  Created by Coulson_Wang on 2017/7/6.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

import UIKit
import SDWebImage

private let marginBetweenPictures : CGFloat = 10
private let marginOfedge : CGFloat = 8
private let marginOfViews : CGFloat = 12


class WBStatusTableViewCell: UITableViewCell {
    // MARK:- 约束
    @IBOutlet weak var pictureViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var pictureViewBottomSpaceConstraint: NSLayoutConstraint!
    
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
            //昵称颜色
            nameLabel.textColor = viewModel.vipLevelImage == nil ? UIColor.black : UIColor.orange
            
            let pictureHeight = calculatePictureViewHeight(count: viewModel.pictureURLs.count)
            pictureViewHeightConstraint.constant = pictureHeight
            pictureViewBottomSpaceConstraint.constant = (viewModel.pictureURLs.count == 0) ? 0 : marginOfViews
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        profileImageView.makeCircle()
    }
    
}

extension WBStatusTableViewCell {
    fileprivate func calculatePictureViewHeight(count : Int) -> CGFloat {
        var colum = 0
        var row = 0
        
        //计算列数
        switch count {
        case 0:
            return 0
        case 1:
            colum = 1
        case 2,4:
            colum = 2
        default:
            colum = 3
        }
        //计算行数
        row = (count - 1) / colum + 1
        //计算每张图片的宽高
        let imageWH = (UIScreen.main.bounds.width - 2 * marginOfedge - CGFloat(colum - 1) * marginBetweenPictures) / CGFloat(colum)
        
        return (imageWH * CGFloat(row) + CGFloat(row - 1) * marginBetweenPictures)
    }

}
