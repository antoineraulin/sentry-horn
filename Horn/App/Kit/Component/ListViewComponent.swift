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
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell
    @objc optional func tableView(_ tableView: UITableView, heightForRowAtIndexPath indexPath: IndexPath) -> CGFloat
    @objc optional func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath)
    @objc optional func updateOtherUI()
}

class ListViewComponent: BaseViewController, UITableViewDataSource, UITableViewDelegate
{
    var needHeaderRefresh = true
    var needFooterRefresh = true
    var fetchDataWhenInit = true
    var tableStyle:UITableViewStyle = UITableViewStyle.plain
    
    fileprivate var tableView = UITableView(frame: CGRect.zero, style: UITableViewStyle.plain)
    fileprivate var viewModel: BaseListViewModel = BaseListViewModel()
    fileprivate let header = MJRefreshNormalHeader()
    fileprivate let footer = MJRefreshAutoNormalFooter()
    fileprivate var adapter:ListViewProtocol?
    
    convenience init(adapter:ListViewProtocol,viewModel:BaseListViewModel){
        self.init()
        self.adapter = adapter
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didMove(toParentViewController parent: UIViewController?) {
        super.didMove(toParentViewController: parent)
        
        self.addKVO()
        
        tableView = UITableView(frame: self.view.bounds, style: tableStyle)
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        
        if (needHeaderRefresh) {
            header.setRefreshingTarget(self, refreshingAction: #selector(ListViewComponent.headerRefreshing))
            self.tableView.mj_header = header
        }
        
        if (needFooterRefresh) {
            footer.setRefreshingTarget(self, refreshingAction: #selector(ListViewComponent.footerRefreshing))
            self.tableView.mj_footer = footer
            self.tableView.mj_footer.isHidden = true
        }
        
        if (fetchDataWhenInit){
            self.fetchData()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let height = self.adapter?.tableView?(tableView, heightForRowAtIndexPath: indexPath){
            return height
        }else{
            return CGFloat(60)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.adapter!.tableView(tableView, cellForRowAtIndexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.adapter?.tableView?(tableView, didSelectRowAtIndexPath: indexPath)
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
    
    func fetchData() {
        self.showLoading()
        viewModel.fetchRemoteData()
    }
    
    fileprivate func addKVO() {
        _ = viewModel.fetchDataResult.afterChange += {
            self.observeHandler($1)
        }
    }
    
    fileprivate func observeHandler(_ newValue: Int) {
        self.hideLoading()
        if (needHeaderRefresh) {
            self.tableView.mj_header.endRefreshing()
        }
        if (needFooterRefresh) {
            self.tableView.mj_footer.endRefreshing()
        }
        if newValue == FetchDataResult.success.rawValue {
            if viewModel.dataArray.count > 0{
                tableView.reloadData()
                updateOtherUI()
                if viewModel.dataArray.count>=10 && needFooterRefresh {
                    tableView.mj_footer.isHidden = false
                }
            }else{
                self.toast("Nothing to show here, move along")
            }
        } else if newValue == FetchDataResult.failed.rawValue {
            self.toast("Get data failed")
        }
    }
    
    fileprivate func updateOtherUI() {
        self.adapter?.updateOtherUI?()
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
