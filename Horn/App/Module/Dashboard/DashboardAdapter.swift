//
//  DashboardAdapter.swift
//  Horn
//
//  Created by Thierry on 16/3/17.
//  Copyright © 2016年 Thierry. All rights reserved.
//

import Foundation
import UIKit

class DashboardAdapter:NSObject, ListViewProtocol{
    
    var context:BaseViewController?
    var viewModel:DashboardViewModel?
    
    init(viewModel:DashboardViewModel, context:BaseViewController){
        self.viewModel = viewModel
        self.context = context
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell: EventCell = EventCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "dashboard_reuseIdentifier")
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        cell.textLabel?.text = viewModel?.nameAtIndexPath(indexPath)
        cell.detailTextLabel?.text = viewModel?.detailAtIndexPath(indexPath)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        let event = EventDetailViewController()
        event.url = viewModel!.permalinkAtIndexPath(indexPath)
        context?.pushViewController(event)
    }
    
}