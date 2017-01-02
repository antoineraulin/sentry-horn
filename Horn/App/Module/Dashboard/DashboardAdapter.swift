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
    
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell{
        let cell: EventCell = EventCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "dashboard_reuseIdentifier")
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        cell.textLabel?.text = viewModel?.nameAtIndexPath(indexPath)
        cell.detailTextLabel?.text = viewModel?.detailAtIndexPath(indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath){
        let event = EventDetailViewController()
        event.url = viewModel!.permalinkAtIndexPath(indexPath)
        context?.pushViewController(event)
    }
    
}
