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
    
    func tableView(_ tableView: UITableView, heightForRowAtIndexPath indexPath: IndexPath) -> CGFloat{
        return CGFloat(90)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell{
        let cell: EventCell = EventCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "event_reuseIdentifier")
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        cell.titleLabel.text = viewModel?.titleAtIndexPath(indexPath)
        cell.detailLabel.text = viewModel?.detailAtIndexPath(indexPath)
        cell.flagLabel.text = viewModel?.flagAtIndexPath(indexPath)
        cell.timeLabel.text = viewModel?.timeAtIndexPath(indexPath)
        cell.levelView.backgroundColor = UIColor(rgba:(viewModel?.levelColorAtIndexPath(indexPath))!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath){
        let event = EventDetailViewController()
        event.url = (viewModel?.permalinkAtIndexPath(indexPath))!
        self.context?.pushViewController(event)
    }
    
}
