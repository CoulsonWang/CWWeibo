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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        
        textView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        textView.becomeFirstResponder()
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
        dismiss(animated: true, completion: nil)
    }
    
    @objc fileprivate func sendPublish() {
        
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
}

