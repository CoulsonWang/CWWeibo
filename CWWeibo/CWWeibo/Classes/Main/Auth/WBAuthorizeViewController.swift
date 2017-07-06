//
//  WBAuthorizeViewController.swift
//  CWWeibo
//
//  Created by Coulson_Wang on 2017/7/6.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

import UIKit
import SVProgressHUD


class WBAuthorizeViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.delegate = self
        
        setupNavigationBar()
        
        loadLoginPage()
    }
}

extension WBAuthorizeViewController {
    func setupNavigationBar() -> Void {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: .plain, target: self, action: #selector(closeBtnClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "填充", style: .plain, target: self, action: #selector(fillBtnClick))
        title = "登录"
    }
}

// MARK: - 监听事件
extension WBAuthorizeViewController {
    @objc fileprivate func closeBtnClick() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc fileprivate func fillBtnClick() {
        
    }
    
    fileprivate func loadLoginPage() {
        let urlString = "https://api.weibo.com/oauth2/authorize?client_id=\(app_key)&redirect_uri=\(redirect_uri)"
        guard let url = URL(string: urlString) else {
            return
        }
        let urlRequest = URLRequest(url: url)
        
        webView.loadRequest(urlRequest)
    }
}

extension WBAuthorizeViewController : UIWebViewDelegate {
    func webViewDidStartLoad(_ webView: UIWebView) {
        SVProgressHUD.show()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        SVProgressHUD.showError(withStatus: "加载失败!")
    }
}
