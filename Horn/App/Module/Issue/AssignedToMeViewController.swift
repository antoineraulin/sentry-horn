//
//  AssignedToMeViewController.swift
//  Horn
//
//  Created by Thierry on 16/3/30.
//  Copyright © 2016年 Thierry. All rights reserved.
//

import UIKit

class AssignedToMeViewController: BaseViewController {

    var viewModel:AssignedToMeViewModel?
    var listComp:ListViewComponent?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Assigned To Me"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = AssignedToMeViewModel()
        let adapter = EventListApdater(viewModel: viewModel!, context: self)
        listComp = ListViewComponent(adapter: adapter, viewModel: viewModel!)
        listComp!.view.frame = self.view.bounds
        self.addComponent(listComp!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
