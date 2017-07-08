//
//  WBPublishViewController.swift
//  CWWeibo
//
//  Created by Coulson_Wang on 2017/7/8.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

import UIKit
import Photos
import SVProgressHUD

class WBPublishViewController: UIViewController {

    @IBOutlet weak var textView: WBPublishTextView!
    @IBOutlet weak var picturePickerView: WBPicturePickerCollectionView!
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    
    fileprivate lazy var coverView : UIView = {
        let view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = UIColor.clear
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tempViewDidBeenClick)))
        
        return view
    }()
    fileprivate lazy var images : [UIImage] = [UIImage]()
    lazy var pickerVC : UIImagePickerController = {
        let pickVC = UIImagePickerController()
        pickVC.sourceType = .photoLibrary
        pickVC.delegate = self
        return pickVC
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        
        textView.delegate = self
        
        setupNotifications()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if collectionViewHeightConstraint.constant == 0 {
            textView.becomeFirstResponder()
        }
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}
// MARK:- 初始化界面
extension WBPublishViewController {
    fileprivate func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(cancelPublish))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发布", style: .plain, target: self, action: #selector(sendPublish))
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        navigationItem.titleView = WBPublishTitleView(frame: CGRect(x: 0, y: 0, width: 200, height: 44))
    }
    
    fileprivate func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame(note:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(addPicture(note:)), name: PicturePickerAddPhotoNotification, object: nil)
        
    }
}

// MARK:- 监听事件
extension WBPublishViewController {
    @IBAction func pickPictureButtonClick(_ sender: UIButton) {
        textView.resignFirstResponder()
        collectionViewHeightConstraint.constant = picturePickerView.isPicking ? 0 : UIScreen.main.bounds.height * 0.64
        picturePickerView.isPicking = !picturePickerView.isPicking
        UIView.animate(withDuration: 0.25) { 
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func expressionButtonClick(_ sender: UIButton) {
    }
    
    @objc fileprivate func cancelPublish() {
        textView.resignFirstResponder()
        dismiss(animated: true, completion: nil)
    }
    
    @objc fileprivate func sendPublish() {
        
    }
    
    @objc fileprivate func keyboardWillChangeFrame(note : Notification) {
        let duration = note.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval
        
        let keyboardEndFrame = (note.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardY = keyboardEndFrame.origin.y
        
        let spaceOfToolBetweenBottom = UIScreen.main.bounds.height - keyboardY
        bottomConstraint.constant = spaceOfToolBetweenBottom
        
        UIView.animate(withDuration: duration) { 
            self.view.layoutIfNeeded()
        }
    }
    
    @objc fileprivate func tempViewDidBeenClick() {
        textView.resignFirstResponder()
    }
    
    
}

// MARK:- textView代理方法
extension WBPublishViewController : UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        self.textView.placeholderLabel.isHidden = textView.hasText
        navigationItem.rightBarButtonItem?.isEnabled = textView.hasText
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        textView.resignFirstResponder()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.addSubview(coverView)
        
        //收起图片选择器
        picturePickerView.isPicking = false
        collectionViewHeightConstraint.constant = 0
        UIView.animate(withDuration: 0.25) {
            self.view.layoutIfNeeded()
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        coverView.removeFromSuperview()
    }
}

// MARK:- 图片选取相关
extension WBPublishViewController {
    @objc fileprivate func addPicture(note : Notification) {
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else { return }
        
        let libraryStatus = PHPhotoLibrary.authorizationStatus()
        if libraryStatus == .notDetermined {
            PHPhotoLibrary.requestAuthorization({ (status) in
                self.handleStatus(status: status)
            })
        } else {
            handleStatus(status: libraryStatus)
        }
        
    }
    
    private func handleStatus(status : PHAuthorizationStatus) {
        if status == .authorized {
            self.present(self.pickerVC, animated: true, completion: nil)
        } else {
            SVProgressHUD.showError(withStatus: "请先开启相册权限！")
        }
    }
}

// MARK:- UIImagePickerControllerDelegate 
extension WBPublishViewController : UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        images.append(image)
        picturePickerView.images = images
        
        picker.dismiss(animated: true, completion: nil)
    }
}
