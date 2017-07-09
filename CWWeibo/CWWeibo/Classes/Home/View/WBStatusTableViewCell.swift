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
private let marginOfRetweetBottom : CGFloat = 15


class WBStatusTableViewCell: UITableViewCell {
    // MARK:- 约束
        @IBOutlet weak var pictureViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var pictureViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var pictureViewBottomSpaceConstraint: NSLayoutConstraint!
    @IBOutlet weak var retweetContextBottomSpaceConstraint: NSLayoutConstraint!

    
    // MARK:- 控件
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var vertifyImageView: UIImageView!
    @IBOutlet weak var vipLevelView: UIImageView!
    @IBOutlet weak var contentTextLabel: HYLabel!
    @IBOutlet weak var retweetContentLabel: HYLabel!
    
    @IBOutlet weak var pictureCollectionView: WBStatusPictureCollectionView!
    @IBOutlet weak var retweetBackgroundView: UIView!
    
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
            //正文
            contentTextLabel.attributedText = CWStringReplacer.sharedInstance.replaceEmoticons(context: viewModel.status?.text, font: contentTextLabel.font)
            //昵称颜色
            nameLabel.textColor = viewModel.vipLevelImage == nil ? UIColor.black : UIColor.orange
            //转发正文
            if viewModel.status?.retweeted_status != nil {
                if let screenName = viewModel.status?.retweeted_status?.user?.screen_name, let retweetedText = viewModel.status?.retweeted_status?.text {
//                    retweetContentLabel.attributedText = "@\(screenName): " + retweetedText
                    let tempStr = "@\(screenName): " + retweetedText
                    retweetContentLabel.attributedText = CWStringReplacer.sharedInstance.replaceEmoticons(context: tempStr, font: retweetContentLabel.font)

                }
                retweetBackgroundView.isHidden = false
                retweetContextBottomSpaceConstraint.constant = marginOfRetweetBottom
            } else {
                retweetContentLabel.text = nil
                retweetBackgroundView.isHidden = true
                retweetContextBottomSpaceConstraint.constant = 0
            }
            //配图底部约束
            pictureViewBottomSpaceConstraint.constant = (viewModel.pictureURLs.count == 0) ? 0 : marginOfViews
            //计算配图View的尺寸
            let pictureViewSize = calculatePictureViewSize(count: viewModel.pictureURLs.count)
            pictureViewWidthConstraint.constant = pictureViewSize.width
            pictureViewHeightConstraint.constant = pictureViewSize.height
            //给配图View传数据
            pictureCollectionView.pictureURLs = viewModel.pictureURLs
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        profileImageView.makeCircle()
        
        contentTextLabel.matchTextColor = UIColor.blue
        retweetContentLabel.matchTextColor = UIColor.blue
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
            if let image = SDWebImageManager.shared().imageCache?.imageFromDiskCache(forKey: viewModel?.pictureURLs.last?.absoluteString) {
                let viewWidth = UIScreen.main.bounds.width - 2 * marginOfedge
                if image.size.width <= viewWidth {
                    layout.itemSize = image.size
                    return image.size
                } else {
                    let displayHeight = viewWidth * image.size.height / image.size.width
                    layout.itemSize = CGSize(width: viewWidth, height: displayHeight)
                    return CGSize(width: viewWidth, height: displayHeight)
                }
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
