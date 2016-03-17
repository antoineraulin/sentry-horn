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
    var list:ListViewController?
    var viewModel:EventListViewModel?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.title = project_name
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = EventListViewModel(project_slug: self.project_slug)
        list = ListViewController(parent: self, viewModel: viewModel!)
        list!.view.frame = CGRectMake(0, _naviHeight, _viewWidth, _viewHeight)
        self.view.addSubview(list!.view)
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
    
    func updateOtherUI() {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
