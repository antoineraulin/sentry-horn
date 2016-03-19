//
//  ProjectListAdapter.swift
//  Horn
//
//  Created by wangyang on 16/3/19.
//  Copyright © 2016年 Thierry. All rights reserved.
//

import UIKit

// 这个是高复用的 Adapter，只处理ProjectList这个业务
final class WYProjectListAdapter: NSObject, UITableViewDataSource, UITableViewDelegate {
    weak private var controller: BaseViewController!
    weak private var viewModel: WYProjectListViewModel!

    private let cellIdentifier = "project_reuseIdentifier"
    convenience init(ownerController: BaseViewController, table: UITableView, ownerViewModel: WYProjectListViewModel) {
        self.init()
        table.delegate = self
        table.dataSource = self
        table.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: cellIdentifier)

        controller = ownerController
        viewModel = ownerViewModel
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataArray.count
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        return CGFloat(60)
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        cell.textLabel?.text = viewModel.nameAtIndexPath(indexPath)
        cell.detailTextLabel?.text = viewModel.detailAtIndexPath(indexPath)
        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let event = EventListViewController()
        event.project_name = viewModel.nameAtIndexPath(indexPath)
        event.project_slug = viewModel.slugAtIndexPath(indexPath)
        controller.pushViewController(event)
    }
    
}