//
//  BookmarksViewController.swift
//  Horn
//
//  Created by Thierry on 16/3/30.
//  Copyright © 2016年 Thierry. All rights reserved.
//

import UIKit

class BookmarksViewController: BaseViewController {

    var viewModel:BookmarksViewModel?
    var listComp:ListViewComponent?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Bookmarks"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = BookmarksViewModel()
        let adapter = EventListApdater(viewModel: viewModel!, context: self)
        listComp = ListViewComponent(adapter: adapter, viewModel: viewModel!)
        listComp!.view.frame = self.view.bounds
        self.addComponent(listComp!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
