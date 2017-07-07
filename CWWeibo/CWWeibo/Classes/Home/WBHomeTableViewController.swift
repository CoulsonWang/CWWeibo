//
//  WBHomeTableViewController.swift
//  CWWeibo
//
//  Created by Coulson_Wang on 2017/7/5.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

import UIKit
import SDWebImage

class WBHomeTableViewController: WBBaseTableViewController {
    
    let cellID = "WBStatusTableViewCell"
    
    // MARK:- 懒加载
    fileprivate lazy var titleBtn : WBNavigationTitleButton = WBNavigationTitleButton()
    fileprivate lazy var popoverAnimator : WBPopoverAnimator = WBPopoverAnimator()
    fileprivate lazy var statusViewModels : [WBStatusViewModel] = [WBStatusViewModel]()
    // MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        visitorView.addRotationAnim()
        
        guard isLogin else {
            return
        }
        
        tableView.register(UINib.init(nibName: cellID, bundle: nil), forCellReuseIdentifier: cellID)
        
        setupNavigationBar()
        
        loadStatuses()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
    }


}


// MARK: - 初始化界面
extension WBHomeTableViewController {
    
    fileprivate func setupNavigationBar() {
        //设置左侧按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "navigationbar_friendattention"), highlightedImage: #imageLiteral(resourceName: "navigationbar_friendattention_highlighted"))
        //设置右侧按钮
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "navigationbar_pop"), highlightedImage: #imageLiteral(resourceName: "navigationbar_pop_highlighted"))
        //设置中间
        titleBtn.setTitle("Coulson", for: .normal)
        titleBtn.addTarget(self, action: #selector(titleBtnClick(_:)), for: .touchUpInside)
        navigationItem.titleView = titleBtn
    }
}

// MARK:- 监听事件
extension WBHomeTableViewController {
    
    @objc fileprivate func titleBtnClick(_ button : WBNavigationTitleButton) {
        
        //弹出控制器
        let popVc = WBPopoverViewController()
        popVc.modalPresentationStyle = .custom
        
        let popverWidth : CGFloat = self.view.bounds.size.width * 0.5
        let popoverX : CGFloat = (self.view.bounds.size.width - popverWidth) * 0.5
        let popoverHeight : CGFloat = self.view.bounds.height * 0.5
        let popoverY : CGFloat = 55
        
        
        popoverAnimator.presentedFrame = CGRect(x: popoverX, y: popoverY, width: popverWidth, height: popoverHeight)
        popoverAnimator.delegate = self
        popVc.transitioningDelegate = popoverAnimator
        
        present(popVc, animated: true, completion: nil)
    }
}

// MARK:- WBPopoverAnimatorDelegate
extension WBHomeTableViewController : WBPopoverAnimatorDelegate {
    func statusChange(isPresented: Bool) {
        titleBtn.isSelected = isPresented
    }
}

// MARK:- 请求数据
extension WBHomeTableViewController {
    fileprivate func loadStatuses() {
        CWNetworkTool.sharedInstance.loadStatusesData { (result, error) in
            if error != nil {
                print(error!)
                return
            }
            guard let resultArray = result else {
                return
            }
            
            for statusDict in resultArray {
                //字典转模型
                let status = WBStatusItem(dict: statusDict)
                let viewModel = WBStatusViewModel(status: status)
                self.statusViewModels.append(viewModel)
            }
            
            self.cacheImages(viewModels: self.statusViewModels)
            
        }
    }
    
    private func cacheImages(viewModels : [WBStatusViewModel]) {
        let group = DispatchGroup.init()
        for viewModel in viewModels {
            guard viewModel.pictureURLs.count == 1 else { continue }
            let picURL = viewModel.pictureURLs.last
            group.enter()
            SDWebImageManager.shared().loadImage(with: picURL, options: [], progress: nil, completed: { (_, _, _, _, _, _) in
                group.leave()
            })
        }
        group.notify(queue: .main) { 
            self.tableView.reloadData()
        }
    }
}

// MARK:- TableViewDataSource
extension WBHomeTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statusViewModels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! WBStatusTableViewCell
        
        cell.viewModel = statusViewModels[indexPath.row]
        
        return cell
    }
}
