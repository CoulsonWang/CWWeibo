//
//  WBPhotoBrowserCollectionViewCell.swift
//  CWWeibo
//
//  Created by Coulson_Wang on 2017/7/9.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

import UIKit
import SDWebImage

class WBPhotoBrowserCollectionViewCell: UICollectionViewCell {
    var picURL : URL? {
        didSet {
            guard let picURL = picURL else { return }
            
            guard let image = SDWebImageManager.shared().imageCache?.imageFromDiskCache(forKey: picURL.absoluteString) else {
                return
            }
            imageView.frame = caclulateFrame(image: image)
            imageView.sd_setImage(with: getBigPictureURL(smallURL: picURL), placeholderImage: image, options: [], progress: { (current, total, _) in
                
            }) { (_, _, _, _) in
                
            }
            
            scrollView.contentSize = CGSize(width: 0, height: image.size.height)
        }
    }
    
    lazy var scrollView : UIScrollView = UIScrollView()
    lazy var imageView : FLAnimatedImageView = FLAnimatedImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUIs()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension WBPhotoBrowserCollectionViewCell {
    func setupUIs() {
        contentView.addSubview(scrollView)
        scrollView.addSubview(imageView)
        
        scrollView.frame = contentView.bounds
    }
    
    func caclulateFrame(image: UIImage) -> CGRect {
        let width = UIScreen.main.bounds.width
        let height = width / image.size.width * image.size.height
        
        var y :CGFloat = 0
        if height > UIScreen.main.bounds.height {
            y = 0
        } else {
            y = (UIScreen.main.bounds.height - height) * 0.5
        }
        
        return CGRect(x: 0, y: y, width: width, height: height)
    }
    
    func getBigPictureURL(smallURL : URL) -> URL {
        let smallURLStr = smallURL.absoluteString
        let bigURLStr = smallURLStr.replacingOccurrences(of: "bmiddle", with: "large")
        return URL(string: bigURLStr)!
    }
}
