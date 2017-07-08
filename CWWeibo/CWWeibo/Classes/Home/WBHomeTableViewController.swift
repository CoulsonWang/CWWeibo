//
//  WBHomeTableViewController.swift
//  CWWeibo
//
//  Created by Coulson_Wang on 2017/7/5.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

import UIKit
import SDWebImage
import MJRefresh

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
        //注册cell
        tableView.register(UINib.init(nibName: cellID, bundle: nil), forCellReuseIdentifier: cellID)
        //初始化Nav
        setupNavigationBar()
        //设置下拉刷新
        setupHeaderView()
        //设置上拉刷新
        setupFooterView()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
        
        tableView.mj_header.beginRefreshing()
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
    
    fileprivate func setupHeaderView() {
        let header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(loadNewestData))
        header?.setTitle("下拉刷新", for: .idle)
        header?.setTitle("松开即可刷新", for: .pulling)
        header?.setTitle("加载中", for: .refreshing)
        
        tableView.mj_header = header
    }
    
    fileprivate func setupFooterView() {
        let footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(loadMoreData))
        tableView.mj_footer = footer
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
    fileprivate func loadStatuses(_ isNewData : Bool) {
        var since_id = 0
        var max_id = 0
        
        if isNewData {
            since_id = statusViewModels.first?.status?.id ?? 0
        } else {
            max_id = statusViewModels.last?.status?.id ?? 0
            max_id = (max_id == 0) ? 0 : (max_id - 1)
        }
        
        CWNetworkTool.sharedInstance.loadStatusesData(since_id: since_id, max_id: max_id) { (result, error) in
            if error != nil {
                print(error!)
                return
            }
            guard let resultArray = result else {
                return
            }
            //创建临时数组
            var tempViewModels = [WBStatusViewModel]()
            //遍历字典，将转换为模型后加到临时数组中
            for statusDict in resultArray {
                //字典转模型
                let status = WBStatusItem(dict: statusDict)
                let viewModel = WBStatusViewModel(status: status)
                tempViewModels.append(viewModel)
            }
            //拼接两个数组
            self.statusViewModels = (isNewData) ? (tempViewModels + self.statusViewModels) : (self.statusViewModels + tempViewModels)
            
            self.cacheImages(viewModels: tempViewModels)
            
        }
    }
    
    /// 缓存图片，用于计算单图微博的图片尺寸
    ///
    /// - Parameter viewModels: 需要缓存的模型数组
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
            self.tableView.mj_header.endRefreshing()
            self.tableView.mj_footer.endRefreshing()
        }
    }
    
    @objc fileprivate func loadNewestData() {
        loadStatuses(true)
    }
    @objc fileprivate func loadMoreData() {
        loadStatuses(false)
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
