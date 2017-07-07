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
            
            let pictureHeight = calculatePictureViewHeight(count: viewModel.pictureURLs.count)
            pictureViewHeightConstraint.constant = pictureHeight
            pictureViewBottomSpaceConstraint.constant = (viewModel.pictureURLs.count == 0) ? 0 : marginOfViews
            pictureCollectionView.pictureURLs = viewModel.pictureURLs
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        profileImageView.makeCircle()
        
        setupPictureView()
    }

    
}

extension WBStatusTableViewCell {
    func setupPictureView() {
        let layout = pictureCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumInteritemSpacing = marginBetweenPictures
        layout.minimumLineSpacing = marginBetweenPictures
        let imageWH = calculateSizeOfEachPicture()
        layout.itemSize = CGSize(width: imageWH, height: imageWH)
    }
    
    func updatePictureViewLayout() {
        let layout = pictureCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        guard let count = viewModel?.pictureURLs.count else {
            return
        }
        let imageWH = calculateSizeOfEachPicture(count: count)
        layout.itemSize = CGSize(width: imageWH, height: imageWH)
    }
}

// MARK:- 计算相关
extension WBStatusTableViewCell {
    //计算总高度
    fileprivate func calculatePictureViewHeight(count : Int) -> CGFloat {
        let (colum, row) = calculateColumAndRow(count: count)
        if colum == 0 { return 0 }
        let imageWH = calculateSizeOfEachPicture()
        return (imageWH * CGFloat(row) + CGFloat(row - 1) * marginBetweenPictures)
    }
    
    
    //计算行数列数
    func calculateColumAndRow(count : Int) -> (colum : Int, row : Int) {
        var colum = 0
        var row = 0
        
        //计算列数
        switch count {
        case 0:
            return (0,0)
        case 1:
            colum = 1
        case 2,4:
            colum = 2
        default:
            colum = 3
        }
        //计算行数
        row = (count - 1) / colum + 1
        return (colum, row)
    }
    //计算单张图片的宽高
    fileprivate func calculateSizeOfEachPicture(count : Int) -> CGFloat {
        let (colum, row) = calculateColumAndRow(count: count)
        return (colum == 0) ? 0 : calculateSizeOfEachPicture(colum: colum, row: row)
    }
    fileprivate func calculateSizeOfEachPicture() -> CGFloat {
        return calculateSizeOfEachPicture(colum: 3, row: 1)
    }
    private func calculateSizeOfEachPicture(colum : Int, row : Int) -> CGFloat {
        return (UIScreen.main.bounds.width - 2 * marginOfedge - CGFloat(colum - 1) * marginBetweenPictures) / CGFloat(colum)
    }
}
