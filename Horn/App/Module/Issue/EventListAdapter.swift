//
//  EventListAdapter.swift
//  Horn
//
//  Created by Thierry on 16/3/30.
//  Copyright © 2016年 Thierry. All rights reserved.
//

import Foundation
import UIKit

class EventListApdater: NSObject, ListViewProtocol{
    
    var context:BaseViewController?
    var viewModel:EventListViewModel?
    
    init(viewModel:EventListViewModel, context:BaseViewController){
        self.viewModel = viewModel
        self.context = context
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
        self.context?.pushViewController(event)
    }
    
}