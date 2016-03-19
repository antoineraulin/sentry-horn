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

@objc protocol ListViewProtocol
{
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    optional func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    optional func updateOtherUI()
}

class ListViewComponent: BaseViewController, UITableViewDataSource, UITableViewDelegate
{
    var needHeaderRefresh = true
    var needFooterRefresh = true
    var tableStyle:UITableViewStyle = UITableViewStyle.Plain
    
    private var tableView = UITableView(frame: CGRectZero, style: UITableViewStyle.Plain)
    private var viewModel: BaseListViewModel = BaseListViewModel()
    private let header = MJRefreshNormalHeader()
    private let footer = MJRefreshAutoNormalFooter()
    private var adapter:ListViewProtocol?
    
    convenience init(adapter:ListViewProtocol,viewModel:BaseListViewModel){
        self.init()
        self.adapter = adapter
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
    }
    
    override func didMoveToParentViewController(parent: UIViewController?) {
        super.didMoveToParentViewController(parent)
        refreshView()
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return self.adapter!.tableView(tableView, heightForRowAtIndexPath: indexPath)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return self.adapter!.tableView(tableView, cellForRowAtIndexPath: indexPath)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        self.adapter?.tableView?(tableView, didSelectRowAtIndexPath: indexPath)
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
        self.adapter?.updateOtherUI?()
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
