//
//  SettingsViewController.swift
//  Horn
//
//  Created by Thierry on 16/3/8.
//  Copyright © 2016年 Thierry. All rights reserved.
//

import UIKit

class AccountViewController: BaseViewController, ListViewProtocol {

    var viewModel:AccountViewModel?
    var listComp:ListViewComponent?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.title = "Account"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = AccountViewModel()
        listComp = ListViewComponent(adapter: self, viewModel: viewModel!)
        listComp?.needFooterRefresh = false
        listComp?.needHeaderRefresh = false
        listComp?.tableStyle = UITableViewStyle.grouped
        listComp?.view.frame = self.view.bounds
        self.addComponent(listComp!)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "account_identifier")
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        cell.textLabel?.text = viewModel?.titleAtIndexPath(indexPath)
        cell.detailTextLabel?.text = viewModel?.detailAtIndexPath(indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath) {
        if indexPath.row == 0 {
            NotificationCenter.default.post(name: Notification.Name(rawValue: Constants.Notification.LoginExpired), object: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
