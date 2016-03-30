//
//  IssuesViewController.swift
//  Horn
//
//  Created by Thierry on 16/3/30.
//  Copyright © 2016年 Thierry. All rights reserved.
//

import UIKit

class IssuesViewController: BaseViewController, ListViewProtocol {
    var viewModel:IssueViewModel?
    var listComp:ListViewComponent?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.title = "Account"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = IssueViewModel()
        listComp = ListViewComponent(adapter: self, viewModel: viewModel!)
        listComp?.needFooterRefresh = false
        listComp?.needHeaderRefresh = false
        listComp?.tableStyle = UITableViewStyle.Grouped
        listComp?.view.frame = self.view.bounds
        self.addComponent(listComp!)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "account_identifier")
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        cell.textLabel?.text = viewModel?.titleAtIndexPath(indexPath)
        cell.detailTextLabel?.text = viewModel?.detailAtIndexPath(indexPath)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let className = self.viewModel?.viewControllerAtIndexPath(indexPath)
        let viewController = NSObject.fromClassName(className!) as! UIViewController
        self.pushViewController(viewController)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
