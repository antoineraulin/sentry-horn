//
//  BaseListViewController.swift
//  Achilles
//
//  Created by Thierry on 15/12/28.
//  Copyright © 2015年 Thierry. All rights reserved.
//

import UIKit
import Observable
import MJRefresh

class BaseListViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    let tableView = UITableView(frame: CGRectZero, style: UITableViewStyle.Plain)
    var viewModel: BaseListViewModel = BaseListViewModel()
    
    var needHeaderRefresh = true
    var needFooterRefresh = true
    var cellHeight = 60
    
    // 顶部刷新
    let header = MJRefreshNormalHeader()
    // 底部刷新
    let footer = MJRefreshAutoNormalFooter()
    
    var reuseIdentifier = "default_resueIdentifier"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addKVO()
        
        tableView.frame = self.view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        
        if (needHeaderRefresh) {
            header.setRefreshingTarget(self, refreshingAction: Selector("headerRefreshing"))
            self.tableView.mj_header = header
        }
        
        if (needFooterRefresh) {
            footer.setRefreshingTarget(self, refreshingAction: Selector("footerRefreshing"))
            self.tableView.mj_footer = footer
        }
        
        refreshView()
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return CGFloat(cellHeight)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: reuseIdentifier)
        self.configDataForCell(cell, indexPath: indexPath)
        return cell
    }
    
    func configDataForCell(cell: UITableViewCell, indexPath: NSIndexPath) {
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func addKVO() {
        viewModel.fetchDataResult.afterChange += {
            self.observeHandler($1)
        }
    }

    func observeHandler(newValue: Int) {
        self.hideLoading()
        if (needHeaderRefresh) {
            self.tableView.mj_header.endRefreshing()
        }
        if (needFooterRefresh) {
            self.tableView.mj_footer.endRefreshing()
        }
        if newValue == FetchDataResult.Success.rawValue {
            if viewModel.dataArray.count > 0{
                tableView.reloadData()
                updateOtherUI()
            }else{
                if (needFooterRefresh) {
                    tableView.mj_footer.hidden = true
                }
                toast("Nothing to show here, move along")
            }
        } else if newValue == FetchDataResult.Failed.rawValue {
            self.toast("Get data failed")
        }
    }
    
    func updateOtherUI() {
    }

    
    func clearAndReset() {
        viewModel.page = 1
        viewModel.cursor = ""
        viewModel.clearData()
        tableView.reloadData()
    }
    
    func clearAndRefreshView() {
        clearAndReset()
        viewModel.fetchRemoteData()
    }
    
    func refreshView() {
        self.showLoading()
        viewModel.fetchRemoteData()
    }
    
    func headerRefreshing() {
        self.viewModel.handleHeaderRefreshing()
    }

    func footerRefreshing() {
        self.viewModel.handleFooterRereshing()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}