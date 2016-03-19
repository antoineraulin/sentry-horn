//
//  DashboardViewController.swift
//  Horn
//
//  Created by Thierry on 16/3/5.
//  Copyright © 2016年 Thierry. All rights reserved.
//

import UIKit

class DashboardViewController: BaseViewController,SegmentProtocol {
    
    var listComps:[ListViewComponent] = Array<ListViewComponent>()
    var viewModels:[DashboardViewModel] = Array<DashboardViewModel>()
    var currentViewModel:DashboardViewModel?
    var currentComp:ListViewComponent?
    let titles = ["Assigned","New"]
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.title = "Dashboard"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addSegment()
        self.addSubControllers()
    }
    
    func addSegment(){
        let segmented = SegmentComponent(adapter:self, titles:titles)
        segmented.view.frame = CGRectMake(0, _naviHeight, _viewWidth, 40)
        self.addComponent(segmented)
    }
    
    func addSubControllers(){
        for (index, title) in titles.enumerate()
        {
            let viewModel = DashboardViewModel(type: title)
            let adapter = DashboardAdapter(viewModel:viewModel, context: self)
            let listComp = ListViewComponent(adapter: adapter, viewModel: viewModel)
            listComp.fetchDataWhenInit = false
            listComp.view.hidden = true
            listComp.view.frame = CGRectMake(0, 40 + _naviHeight, _viewWidth, _viewHeight - _tabHeight - _naviHeight)
            self.addComponent(listComp)
            
            listComps.append(listComp)
            viewModels.append(viewModel)
            
            if index == 0
            {
                currentComp = listComp
                currentViewModel = viewModel
            }
        }
        currentComp?.view.hidden = false
        currentComp?.fetchData()
    }
    
    func segmentSelect(sender: YSSegmentedControl, selectedSegmentIndex: Int) {
        currentViewModel = viewModels[selectedSegmentIndex]
        self.transitionViewController(currentComp!, newController: listComps[selectedSegmentIndex])
    }
    
    func transitionViewController(oldController:ListViewComponent, newController:ListViewComponent){
        self.transitionFromViewController(oldController, toViewController: newController, duration: 0.1, options: UIViewAnimationOptions.TransitionNone, animations: nil) { (finished) -> Void in
            if (finished) {
                oldController.view.hidden = true
                self.currentComp = newController
                self.currentComp?.view.hidden = false
                self.currentComp?.fetchData()
            }else{
                self.currentComp = oldController
                oldController.view.hidden = false
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
