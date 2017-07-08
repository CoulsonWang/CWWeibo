//
//  WBPicturePickerViewCell.swift
//  CWWeibo
//
//  Created by Coulson_Wang on 2017/7/8.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

import UIKit

class WBPicturePickerViewCell: UICollectionViewCell {
    
    @IBOutlet weak var addButton: UIButton!
    
    
    var image : UIImage? {
        didSet {
            if image != nil {
                addButton.setBackgroundImage(image, for: .normal)
                addButton.isUserInteractionEnabled = false
            } else {
                addButton.setBackgroundImage(#imageLiteral(resourceName: "compose_pic_add"), for: .normal)
                addButton.setBackgroundImage(#imageLiteral(resourceName: "compose_pic_add_highlighted"), for: .highlighted)
                addButton.isUserInteractionEnabled = true
            }
        }
    }
    

    @IBAction func addPictureButtonClick(_ sender: UIButton) {
        
        NotificationCenter.default.post(name: PicturePickerAddPhotoNotification, object: self, userInfo: nil)
        
    }

    @IBAction func deleteButtonClick(_ sender: UIButton) {
    }

}
