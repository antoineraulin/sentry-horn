//
//  EventListViewController.swift
//  Horn
//
//  Created by Thierry on 16/3/7.
//  Copyright © 2016年 Thierry. All rights reserved.
//

import UIKit

class EventListViewController: BaseViewController {
    
    var projectName = ""
    var projectSlug:String = ""
    var listComp:ListViewComponent?
    var viewModel:EventListViewModel?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = projectName
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = EventListViewModel(projectSlug: projectSlug)
        let adapter = EventListApdater(viewModel: viewModel!, context: self)
        listComp = ListViewComponent(adapter: adapter, viewModel: viewModel!)
        listComp!.view.frame = self.view.bounds
        self.addComponent(listComp!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
