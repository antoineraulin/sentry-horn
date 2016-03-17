//
//  ProjectsViewController.swift
//  Achilles
//
//  Created by Thierry on 16/3/5.
//  Copyright © 2016年 Thierry. All rights reserved.
//

import UIKit

class ProjectListViewController: BaseViewController, ListViewProtocol  {

    var listComp:ListViewComponent?
    var viewModel:ProjectListViewModel?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.title = "Projects"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ProjectListViewModel()
        listComp = ListViewComponent(adapter: self, viewModel: viewModel!)
        listComp!.view.frame = self.view.bounds
        
        self.addChildViewController(listComp!)
        self.view.addSubview(listComp!.view)
        listComp?.didMoveToParentViewController(self)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        return CGFloat(60)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "project_reuseIdentifier")
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        cell.textLabel?.text = viewModel!.nameAtIndexPath(indexPath)
        cell.detailTextLabel?.text = viewModel!.detailAtIndexPath(indexPath)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let event = EventListViewController()
        event.project_name = viewModel!.nameAtIndexPath(indexPath)
        event.project_slug = viewModel!.slugAtIndexPath(indexPath)
        self.pushViewController(event)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
