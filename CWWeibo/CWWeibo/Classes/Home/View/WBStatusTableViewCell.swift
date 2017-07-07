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
    @IBOutlet weak var pictureViewWidthConstraint: NSLayoutConstraint!
    
    // MARK:- 控件
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var vertifyImageView: UIImageView!
    @IBOutlet weak var vipLevelView: UIImageView!
    @IBOutlet weak var contentTextLabel: UILabel!
    @IBOutlet weak var retweetContentLabel: UILabel!
    
    @IBOutlet weak var pictureCollectionView: WBStatusPictureCollectionView!
    
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
            //转发正文
            if viewModel.status?.retweeted_status != nil {
                if let screenName = viewModel.status?.retweeted_status?.user?.screen_name, let retweetedText = viewModel.status?.retweeted_status?.text {
                    retweetContentLabel.text = "@\(screenName) :" + retweetedText
                }
                
            } else {
                retweetContentLabel.text = nil
            }
            
            pictureViewBottomSpaceConstraint.constant = (viewModel.pictureURLs.count == 0) ? 0 : marginOfViews
            let pictureViewSize = calculatePictureViewSize(count: viewModel.pictureURLs.count)
            pictureViewWidthConstraint.constant = pictureViewSize.width
            pictureViewHeightConstraint.constant = pictureViewSize.height
            pictureCollectionView.pictureURLs = viewModel.pictureURLs
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        profileImageView.makeCircle()
        
    }

    
}


// MARK:- 计算相关
extension WBStatusTableViewCell {
    //计算总高度
    fileprivate func calculatePictureViewSize(count : Int) -> CGSize {
        if count == 0 {
            return CGSize.zero
        }
        
        let layout = pictureCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        if count == 1 {
            let image = SDWebImageManager.shared().imageCache?.imageFromDiskCache(forKey: viewModel?.pictureURLs.last?.absoluteString)
            if image != nil  {
                layout.itemSize = CGSize(width: (image?.size.width)! * 3, height: (image?.size.height)! * 3)
                return CGSize(width: (image?.size.width)! * 3, height: (image?.size.height)! * 3)
            }
            
        }
        let imageWH = calculateSizeOfEachPicture()
        layout.itemSize = CGSize(width: imageWH, height: imageWH)
        if count == 4{
            return CGSize(width: 2 * imageWH + marginBetweenPictures, height: 2 * imageWH + marginBetweenPictures)
        }
        let row = CGFloat((count - 1) / 3 + 1)
        let picViewH = row * imageWH + (row - 1) * marginBetweenPictures
        let picViewW = UIScreen.main.bounds.width - 2 * marginOfedge
        return CGSize(width: picViewW, height: picViewH)
    }
    
    //计算单张图片的宽高
    fileprivate func calculateSizeOfEachPicture() -> CGFloat {
        return calculateSizeOfEachPicture(colum: 3, row: 1)
    }
    private func calculateSizeOfEachPicture(colum : Int, row : Int) -> CGFloat {
        return (UIScreen.main.bounds.width - 2 * marginOfedge - CGFloat(colum - 1) * marginBetweenPictures) / CGFloat(colum)
    }
}
