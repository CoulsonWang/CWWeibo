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
        dataSource = self
        register(PictureCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: cellID)
    }
}

extension WBStatusPictureCollectionView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictureURLs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! PictureCollectionViewCell
        
        let pictureURL = pictureURLs[indexPath.item]
        cell.imageView.sd_setImage(with: pictureURL, placeholderImage: #imageLiteral(resourceName: "empty_picture"))
        
        return cell
    }
}


// MARK:- 自定义cell
class PictureCollectionViewCell : UICollectionViewCell {
    lazy var imageView : UIImageView = UIImageView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView.frame = bounds
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        addSubview(imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
