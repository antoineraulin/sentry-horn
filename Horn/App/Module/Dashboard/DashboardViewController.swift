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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.title = "Dashboard"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addSegmented()
        self.addSubControllers()
    }
    
    func addSegmented(){
        let segmented = SegmentComponent(adapter:self, titles:titles)
        segmented.view.frame = CGRect(x: 0, y: _naviHeight, width: _viewWidth, height: 40)
        self.addComponent(segmented)
    }
    
    func addSubControllers(){
        for (index, title) in titles.enumerated()
        {
            let viewModel = DashboardViewModel(type: title)
            let adapter = DashboardAdapter(viewModel:viewModel, context: self)
            let listComp = ListViewComponent(adapter: adapter, viewModel: viewModel)
            listComp.fetchDataWhenInit = false
            listComp.view.isHidden = true
            listComp.view.frame = CGRect(x: 0, y: 40 + _naviHeight, width: _viewWidth, height: _viewHeight - _tabHeight - _naviHeight)
            self.addComponent(listComp)
            
            listComps.append(listComp)
            viewModels.append(viewModel)
            
            if index == 0
            {
                currentComp = listComp
                currentViewModel = viewModel
            }
        }
        currentComp?.view.isHidden = false
        currentComp?.fetchData()
    }
    
    func segmentSelect(_ sender: YSSegmentedControl, selectedSegmentIndex: Int) {
        currentViewModel = viewModels[selectedSegmentIndex]
        self.transitionViewController(currentComp!, newController: listComps[selectedSegmentIndex])
    }
    
    func transitionViewController(_ oldController:ListViewComponent, newController:ListViewComponent){
        self.transition(from: oldController, to: newController, duration: 0.1, options: UIViewAnimationOptions(), animations: nil) { (finished) -> Void in
            if (finished) {
                oldController.view.isHidden = true
                self.currentComp = newController
                self.currentComp?.view.isHidden = false
                self.currentComp?.fetchData()
            }else{
                self.currentComp = oldController
                oldController.view.isHidden = false
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
