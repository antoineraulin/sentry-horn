//
//  SettingsViewController.swift
//  Horn
//
//  Created by Thierry on 16/3/8.
//  Copyright © 2016年 Thierry. All rights reserved.
//

import UIKit

class SettingsViewController: BaseListViewController {

    let _viewModel = SettingsViewModel()
    override var viewModel: BaseListViewModel {
        get {
            return _viewModel
        }
        set {
            super.viewModel = newValue
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.title = "Settings"
    }
    
    override func initController() {
        super.initController()
        needFooterRefresh = false
        needHeaderRefresh = false
        tableStyle = UITableViewStyle.Grouped
        reuseIdentifier = "settings_identifier"
    }
    
    override func configDataForCell(cell: UITableViewCell, indexPath: NSIndexPath) {
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        cell.textLabel?.text = _viewModel.titleAtIndexPath(indexPath)
        cell.detailTextLabel?.text = _viewModel.detailAtIndexPath(indexPath)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        super.tableView(tableView, didSelectRowAtIndexPath: indexPath)
        if indexPath.row == 0 {
            NSNotificationCenter.defaultCenter().postNotificationName(Constants.Notification.LoginExpired, object: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
