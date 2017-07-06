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
// MARK:- 初始化界面
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
        let jsCode = "document.getElementById('userId').value='13802786785';document.getElementById('passwd').value='wyy24680000';"
        
        webView.stringByEvaluatingJavaScript(from: jsCode)
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
        SVProgressHUD.dismiss()
    }
    
    //确定是否加载界面。如果是登陆成功后的回调，则不加载
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        guard let url = request.url else { return true }
        let str = url.absoluteString
        guard str.contains("code=") else {
            return true
        }
        
        //获取AccessToken所需的Code
        let codeStr = str.components(separatedBy: "code=").last!
        loadAccessToken(code: codeStr)
        
        return false
    }
}

extension WBAuthorizeViewController {
    //发送请求获取AccessToken
    fileprivate func loadAccessToken(code : String) -> Void {
        CWNetworkTool.sharedInstance.loadAccessToken(code: code) { (result, error) in
            guard error == nil else {
                return
            }
            guard let accountDict = result else {
                return
            }
            //保存请求结果
            let account = WBUserAccount(dict: accountDict)
            
            self.loadUserInfo(account: account)
            
        }
    }
    
    //加载用户信息
    private func loadUserInfo(account : WBUserAccount) -> Void {
        guard let access_token = account.access_token else { return }
        guard let uid = account.uid else { return  }
        CWNetworkTool.sharedInstance.loadUserInfo(access_token: access_token, uid: uid) { (result, error) in
            guard error == nil else {
                return
            }
            guard let userInfoDict = result else {
                return
            }
            //保存用户信息的昵称和头像
            account.screen_name = userInfoDict["screen_name"] as? String
            account.avatar_large = userInfoDict["avatar_large"] as? String
            
            //归档保存用户信息
            NSKeyedArchiver.archiveRootObject(account, toFile: WBUserAccountViewModel.sharedInstance.accountPath)
        }
    }
}
