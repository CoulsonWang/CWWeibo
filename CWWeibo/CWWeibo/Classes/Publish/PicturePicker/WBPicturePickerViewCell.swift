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
    @IBOutlet weak var removeButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    
    var image : UIImage? {
        didSet {
            if image != nil {
                imageView.isHidden = false
                imageView.image = image
                addButton.isUserInteractionEnabled = false
                removeButton.isHidden = false
            } else {
                imageView.isHidden = true
                addButton.isUserInteractionEnabled = true
                removeButton.isHidden = true
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    

    @IBAction func addPictureButtonClick(_ sender: UIButton) {
        
        NotificationCenter.default.post(name: PicturePickerAddPhotoNotification, object: self, userInfo: nil)
        
    }

    @IBAction func deleteButtonClick(_ sender: UIButton) {
        NotificationCenter.default.post(name: PicturePickerRemovePhotoNotification, object: self, userInfo: ["image" : imageView.image!])
    }

}
