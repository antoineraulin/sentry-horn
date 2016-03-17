//
//  EventListViewController.swift
//  Horn
//
//  Created by Thierry on 16/3/7.
//  Copyright © 2016年 Thierry. All rights reserved.
//

import UIKit

class EventListViewController: BaseViewController, ListViewProtocol {
    
    var project_name = ""
    var project_slug:String = ""
    var listComp:ListViewComponent?
    var viewModel:EventListViewModel?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.title = project_name
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = EventListViewModel(project_slug: self.project_slug)
        listComp = ListViewComponent(adapter: self, viewModel: viewModel!)
        listComp!.view.frame = self.view.bounds
        self.addChildViewController(listComp!)
        self.view.addSubview(listComp!.view)
        listComp?.didMoveToParentViewController(self)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        return CGFloat(90)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell: EventCell = EventCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "event_reuseIdentifier")
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        cell.titleLabel.text = viewModel?.titleAtIndexPath(indexPath)
        cell.detailLabel.text = viewModel?.detailAtIndexPath(indexPath)
        cell.flagLabel.text = viewModel?.flagAtIndexPath(indexPath)
        cell.timeLabel.text = viewModel?.timeAtIndexPath(indexPath)
        cell.levelView.backgroundColor = UIColor(rgba:(viewModel?.levelColorAtIndexPath(indexPath))!)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        let event = EventDetailViewController()
        event.url = (viewModel?.permalinkAtIndexPath(indexPath))!
        self.pushViewController(event)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
