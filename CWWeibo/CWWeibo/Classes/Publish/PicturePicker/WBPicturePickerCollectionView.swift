//
//  WBPicturePickerCollectionView.swift
//  CWWeibo
//
//  Created by Coulson_Wang on 2017/7/8.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

import UIKit

private let cellID = "UICollectionViewCell"
private let marginOfEdge : CGFloat = 15
private let marginBetweenItems : CGFloat = 12

class WBPicturePickerCollectionView: UICollectionView {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        dataSource = self
        
        register(UINib.init(nibName: "WBPicturePickerViewCell", bundle: nil), forCellWithReuseIdentifier: cellID)
        
        setupFlowLayout()

    }

}

extension WBPicturePickerCollectionView {
    func setupFlowLayout() {
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        let itemWH = (UIScreen.main.bounds.width - 2 * marginOfEdge - 2 * marginBetweenItems) / 3
        layout.itemSize = CGSize(width: itemWH, height: itemWH)
        layout.minimumLineSpacing = marginBetweenItems
        layout.minimumInteritemSpacing = marginBetweenItems
        
        contentInset = UIEdgeInsets(top: marginOfEdge, left: marginOfEdge, bottom: marginOfEdge, right: marginOfEdge)
    }
}

extension WBPicturePickerCollectionView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        
        
        
        return cell
    }
}
