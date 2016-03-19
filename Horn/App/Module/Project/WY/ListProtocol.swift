//
//  TableViewProtocol.swift
//  test
//
//  Created by wangyang on 16/3/15.
//  Copyright © 2016年 北京更美互动信息科技有限公司. All rights reserved.
//

import UIKit
import MJRefresh

/*
    任何业务controller都可以挂上这个协议以实现list controller的功能
*/
protocol ListProtocol: class {

    // 这里需要一个实现 ViewModelType 的viewModel实例，通过这样一个泛型，可以适应不同的业务需求
    typealias ViewModelType : ViewModelProtocol

    var tableView: UITableView! { get set }
    var viewModel: ViewModelType! { get set }

    /**
     向controller.view中添加一个table，并根据 fetchNow 的情况来判断是否自动请求网络
     - parameter tableStyle: UITableViewStyle
     - parameter now:        true表示立即请求风格
     */
    func addTableView(style tableStyle: UITableViewStyle, fetchNow now: Bool)

    /**
     主动调用该方法以请求数据
     */
    func fetchListData()

    /**
     请求完网络，会执行该方法以更新非table cell、section UI
     */
    func updateOtherUIData()

    // 设置是否需要刷新和加载更多，默认是都需要。另外：使用方法而非属性。少些变量，多些方法，这样可以让协议更简单一些
    func setNeedFooterRefresh(need: Bool)
    func setNeedHeaderRefresh(need: Bool)

}

extension ListProtocol where Self: BaseViewController {

    func addTableView(style tableStyle: UITableViewStyle, fetchNow now: Bool) {

        // init
        tableView = UITableView(frame: self.view.bounds, style: tableStyle)
        viewModel = ViewModelType()

        // 下拉、下拉刷新
        setNeedHeaderRefresh(true)
        setNeedFooterRefresh(true)

        self.view.addSubview(tableView)
        if now {
            self.fetchListData()
        }
    }

    func fetchListData() {
        if self.viewModel.dataArray.count == 0 {
            self.showLoading()
        }

        viewModel.fetchRemoteData() { [unowned self] success, message -> Void in
            self.tableView.mj_header.endRefreshing()
            self.tableView.mj_footer.endRefreshing()

            if success {

                /*
                关于下面两行代码
                self.tableView.reloadData()
                self.updateOtherUIData()

                - 如果 updateOtherUIData 中没有给table设置tableHeaderView或者tableFooterView，那么这两行谁执行都可以。
                - 如果 updateOtherUIData 中有给table设置tableHeaderView或者tableFooterView，那么此时会立即走 table 的 dataSource 方法
                如果此接下来再执行一次 tableView.reloadData，就显得有些多余了
                
                所以，先reloadData，再 updateOtherUIData 是一个比较好的方法
                */
                self.tableView.reloadData()
                self.updateOtherUIData()

                self.hideLoading()
                if self.viewModel.dataArray.count == 0 {
                    self.toast("Nothing to show here, move along")
                }
            } else {
                self.toast(message)
            }
        }
    }

    func refreshList() {
        viewModel.page = 1
        viewModel.cursor = ""
        viewModel.dataArray.removeAll()

        tableView.reloadData()
        fetchListData()
    }

    func updateOtherUIData() {
        print("default updateOtherUIData")
    }

    func setNeedHeaderRefresh(need: Bool) {
        if need {
            let header = MJRefreshNormalHeader()

            header.refreshingBlock = { [unowned self] in
                // 改成更美的代码
                self.viewModel.page = 0
                self.fetchListData()
            }
            self.tableView.mj_header = header
        } else {
            self.tableView.mj_header = nil
        }
    }

    func setNeedFooterRefresh(need: Bool) {
        if need {
            let footer = MJRefreshAutoNormalFooter()
            footer.refreshingBlock = { [unowned self] in
                // 改成更美的代码
                self.viewModel.page = self.viewModel.page + 1
                self.fetchListData()
            }

            self.tableView.mj_footer = footer
        } else {
            self.tableView.mj_footer = nil
        }
    }

    func headerRefreshing() {

    }

}


