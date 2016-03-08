//
//  ProjectsViewController.swift
//  Achilles
//
//  Created by Thierry on 16/3/5.
//  Copyright © 2016年 Thierry. All rights reserved.
//

import UIKit

class ProjectListViewController: BaseListViewController {
    
    let _viewModel = ProjectListViewModel()
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
        self.tabBarController?.title = "Projects"
    }
    
    override func initController() {
        super.initController()
        reuseIdentifier = "projects_identifier"
    }
    
    override func configDataForCell(cell: UITableViewCell, indexPath: NSIndexPath) {
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        cell.textLabel?.text = _viewModel.nameAtIndexPath(indexPath)
        cell.detailTextLabel?.text = _viewModel.detailAtIndexPath(indexPath)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        super.tableView(tableView, didSelectRowAtIndexPath: indexPath)
        let event = EventListViewController()
        event.project_name = _viewModel.nameAtIndexPath(indexPath)
        event.project_slug = _viewModel.slugAtIndexPath(indexPath)
        self.pushViewController(event)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
