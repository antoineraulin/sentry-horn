//
//  ListViewController.swift
//  Horn
//
//  Created by Thierry on 16/3/17.
//  Copyright © 2016年 Thierry. All rights reserved.
//

import UIKit
import Observable
import MJRefresh

protocol ListViewProtocol
{
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    func updateOtherUI()
}

class ListViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate
{
    private var tableView = UITableView(frame: CGRectZero, style: UITableViewStyle.Plain)
    var viewModel: BaseListViewModel = BaseListViewModel()
    
    var needHeaderRefresh = true
    var needFooterRefresh = true
    
    private var tableStyle:UITableViewStyle = UITableViewStyle.Plain
    private var cellHeight = 60
    
    // 顶部刷新
    private let header = MJRefreshNormalHeader()
    // 底部刷新
    let footer = MJRefreshAutoNormalFooter()
    
    var reuseIdentifier = "default_resueIdentifier"
    
    var parent:ListViewProtocol?
    
    convenience init(parent: BaseViewController,viewModel:BaseListViewModel){
        self.init()
        self.parent = (parent as! ListViewProtocol)
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addKVO()
        
        tableView = UITableView(frame: self.view.bounds, style: tableStyle)
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
        return self.parent!.tableView(tableView, heightForRowAtIndexPath: indexPath)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return self.parent!.tableView(tableView, cellForRowAtIndexPath: indexPath)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        self.parent!.tableView(tableView, didSelectRowAtIndexPath: indexPath)
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
                self.toast("Nothing to show here, move along")
            }
        } else if newValue == FetchDataResult.Failed.rawValue {
            self.toast("Get data failed")
        }
    }
    
    func updateOtherUI() {
        self.parent?.updateOtherUI()
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
