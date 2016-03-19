//
//  ProjectsViewController.swift
//  Achilles
//
//  Created by Thierry on 16/3/5.
//  Copyright © 2016年 Thierry. All rights reserved.
//

import UIKit

final class WYProjectListViewController: BaseViewController, ListProtocol {

    // 来自 ListProtocol 的属性
    var tableView: UITableView!
    var viewModel: WYProjectListViewModel!

    private var listAdapter: WYProjectListAdapter!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "WY_Project"

        self.addTableView(style: .Plain, fetchNow: true)

        listAdapter = WYProjectListAdapter(ownerController: self, table:tableView, ownerViewModel: viewModel)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.title = "WY_Project"
    }

    func updateOtherUIData() {
        
    }
}

