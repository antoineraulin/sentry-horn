//
//  EventListViewController.swift
//  Horn
//
//  Created by Thierry on 16/3/7.
//  Copyright © 2016年 Thierry. All rights reserved.
//

import UIKit

class EventListViewController: BaseListViewController {
    
    var project_name = ""
    var project_slug:String = "" {
        didSet
        {
            _viewModel.project_slug = project_slug
        }
    }
    
    let _viewModel = EventListViewModel()
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
        self.title = project_name
    }
    
    override func initController() {
        super.initController()
        cellHeight = 90
        reuseIdentifier = "events_identifier"
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: EventCell = EventCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: reuseIdentifier)
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        cell.titleLabel.text = _viewModel.titleAtIndexPath(indexPath)
        cell.detailLabel.text = _viewModel.detailAtIndexPath(indexPath)
        cell.flagLabel.text = _viewModel.flagAtIndexPath(indexPath)
        cell.timeLabel.text = _viewModel.timeAtIndexPath(indexPath)
        cell.levelView.backgroundColor = UIColor(rgba:_viewModel.levelColorAtIndexPath(indexPath))
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
