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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.title = "Projects"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ProjectListViewModel()
        listComp = ListViewComponent(adapter: self, viewModel: viewModel!)
        listComp!.view.frame = self.view.bounds
        self.addComponent(listComp!)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "project_reuseIdentifier")
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        cell.textLabel?.text = viewModel!.nameAtIndexPath(indexPath)
        cell.detailTextLabel?.text = viewModel!.detailAtIndexPath(indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath) {
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
