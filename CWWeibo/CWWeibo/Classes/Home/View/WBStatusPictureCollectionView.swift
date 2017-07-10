//
//  WBStatusPictureCollectionView.swift
//  CWWeibo
//
//  Created by Coulson_Wang on 2017/7/7.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

import UIKit
import SDWebImage

private let cellID = "WBStatusPictureCollectionView"


class WBStatusPictureCollectionView: UICollectionView {
    
    var pictureURLs : [URL] = [URL]() {
        didSet {
            reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.isScrollEnabled = false
        dataSource = self
        delegate = self
        register(UINib.init(nibName: "WBPictureCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellID)
    }
}

extension WBStatusPictureCollectionView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictureURLs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! WBPictureCollectionViewCell
        
        let pictureURL = pictureURLs[indexPath.item]
        cell.imageView.sd_setImage(with: pictureURL, placeholderImage: #imageLiteral(resourceName: "empty_picture"))
        
        return cell
    }
}

extension WBStatusPictureCollectionView : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let userInfo : [String : Any] = [ShowPhotoBrowserNoteIndexpathKey : indexPath, ShowPhotoBrowserNoteURLsKey : pictureURLs]
        NotificationCenter.default.post(name: ShowPhotoBrowserNotification, object: self, userInfo: userInfo)
    }
}

extension WBStatusPictureCollectionView : WBPhotoBrowserAnimatorPresentDelegate {
    func startRect(indexPath: IndexPath) -> CGRect {
        let cell = self.cellForItem(at: indexPath)!
        
        //获取cell相对于整个屏幕的frame
        return self.convert(cell.frame, to: UIApplication.shared.keyWindow)
    }
    
    func endRect(indexPath: IndexPath) -> CGRect {
        let picURL = pictureURLs[indexPath.item]
        let image = (SDWebImageManager.shared().imageCache?.imageFromCache(forKey: picURL.absoluteString))!
        let endRect = image.caclulateFrameInFullScreenMode()
        return endRect
    }
    
    func imageView(indexPath: IndexPath) -> UIImageView {
        let image = (SDWebImageManager.shared().imageCache?.imageFromCache(forKey: pictureURLs[indexPath.item].absoluteString))!
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }
}
