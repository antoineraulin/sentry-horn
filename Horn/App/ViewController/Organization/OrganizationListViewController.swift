//
//  OrganizationListViewController.swift
//  Horn
//
//  Created by Thierry on 16/3/6.
//  Copyright © 2016年 Thierry. All rights reserved.
//

import UIKit

class OrganizationListViewController: BaseListViewController {

    let _viewModel = OrganizationListViewModel()
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
        self.title = "Organizations"
    }
    
    override func initController() {
        super.initController()
        needFooterRefresh = false
        reuseIdentifier = "organizations_identifier"
    }
    
    override func configDataForCell(cell: UITableViewCell, indexPath: NSIndexPath) {
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        cell.textLabel?.text = _viewModel.nameAtIndexPath(indexPath)
        cell.detailTextLabel?.text = _viewModel.detailAtIndexPath(indexPath)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        super.tableView(tableView, didSelectRowAtIndexPath: indexPath)
        Constants.CurrentOrganization = _viewModel.slugAtIndexPath(indexPath)
        AppDelegate.shareInstance().showMainView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
