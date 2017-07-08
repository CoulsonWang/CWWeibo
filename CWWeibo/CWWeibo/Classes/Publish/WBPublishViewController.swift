//
//  WBPublishViewController.swift
//  CWWeibo
//
//  Created by Coulson_Wang on 2017/7/8.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

import UIKit

class WBPublishViewController: UIViewController {

    @IBOutlet weak var textView: WBPublishTextView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    fileprivate lazy var coverView : UIView = {
        let view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = UIColor.clear
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tempViewDidBeenClick)))
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        
        textView.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame(note:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        textView.becomeFirstResponder()
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
}

// MARK:- 监听事件
extension WBPublishViewController {
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
        view.addSubview(coverView)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        coverView.removeFromSuperview()
    }
}

