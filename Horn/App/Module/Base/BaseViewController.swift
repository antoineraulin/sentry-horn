//
//  BaseViewController.swift
//  Achilles
//
//  Created by Thierry on 9/4/15.
//  Copyright (c) 2015 Thierry. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    var _viewWidth: CGFloat = 0.0
    var _viewHeight: CGFloat = 0.0
    let _tabHeight: CGFloat = 50
    let _naviHeight: CGFloat = 64

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        initController()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func initController() {
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        hideLoading()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 必须要设置一个背景色，否则会出现tabbar残留的情况
        self.view.backgroundColor = UIColor.white

        // Do any additional setup after loading the view.
        _viewWidth = self.view.frame.size.width
        _viewHeight = self.view.frame.size.height
    }

    func showLoading() {
        self.view.hideToastActivity()
        self.view.makeToastActivity()
    }

    func hideLoading() {
        self.view.hideToastActivity()
    }

    func toast(_ message: String) {
        self.navigationController?.view.makeToast(message: message, duration: 1, position: HRToastPositionCenter as AnyObject)
    }

    func pushViewController(_ viewController: UIViewController) {
        self.navigationController?.pushViewController(viewController, animated: true)
    }

    func popViewController() {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func addComponent(_ component: UIViewController) {
        self.addChildViewController(component)
        self.view.addSubview(component.view)
        component.didMove(toParentViewController: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
