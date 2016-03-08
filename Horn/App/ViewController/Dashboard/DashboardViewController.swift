//
//  DashboardViewController.swift
//  Horn
//
//  Created by Thierry on 16/3/5.
//  Copyright © 2016年 Thierry. All rights reserved.
//

import UIKit

class DashboardViewController: BaseListViewController {
    
    let _viewModel = DashboardViewModel()
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
        self.tabBarController?.title = "Dashboard"
    }
    
    override func initController() {
        super.initController()
        needFooterRefresh = false
        reuseIdentifier = "dashboard_identifier"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let segmented = YSSegmentedControl(
            frame: CGRect(x: 0, y: _tabHeight, width: _viewWidth, height: 50),
            titles: ["Assigned","New",],
            action: {
                control, index in
                self.segmentSelect(control, selectedSegmentIndex: index)
        })
        self.view.addSubview(segmented)
        
        tableView.frame = CGRectMake(0, 40, _viewWidth, _viewHeight - _tabHeight - _naviHeight)
        
        segmented.appearance = YSSegmentedControlAppearance(
            backgroundColor: UIColor.whiteColor(),
            selectedBackgroundColor: UIColor.whiteColor(),
            
            textColor: UIColor(rgba: Color.FontGray),
            font: UIFont.systemFontOfSize(14),
            
            selectedTextColor: UIColor(rgba: Color.FontBlack),
            selectedFont: UIFont.systemFontOfSize(14),
            
            bottomLineColor: UIColor(rgba: Color.LineGray),
            selectorColor: UIColor(rgba:Color.Blue),
            
            bottomLineHeight: 0.5,
            selectorHeight: 1,
            labelTopPadding: 10
        )
        
    }
    
    func segmentSelect(sender: YSSegmentedControl, selectedSegmentIndex: Int) {
        if selectedSegmentIndex == 0 {
            _viewModel.type = "Assigned"
        } else {
            _viewModel.type = "New"
        }
        reuseIdentifier = "dashboard_identifier"+_viewModel.type
        
        self.showLoading()
        self.clearAndRefreshView()
    }
    
    override func configDataForCell(cell: UITableViewCell, indexPath: NSIndexPath) {
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        cell.textLabel?.text = _viewModel.nameAtIndexPath(indexPath)
        cell.detailTextLabel?.text = _viewModel.detailAtIndexPath(indexPath)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        super.tableView(tableView, didSelectRowAtIndexPath: indexPath)
        let event = EventDetailViewController()
        event.url = _viewModel.permalinkAtIndexPath(indexPath)
        self.pushViewController(event)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
