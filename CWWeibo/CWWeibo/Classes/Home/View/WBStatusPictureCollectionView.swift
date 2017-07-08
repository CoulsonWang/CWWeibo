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

