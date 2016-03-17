//
//  SegmentComponent.swift
//  Horn
//
//  Created by Thierry on 16/3/17.
//  Copyright © 2016年 Thierry. All rights reserved.
//

import UIKit
@objc protocol SegmentProtocol
{
    optional func segmentSelect(sender: YSSegmentedControl, selectedSegmentIndex: Int)
}

class SegmentComponent:BaseViewController {
    
    var listComps:[ListViewComponent] = Array<ListViewComponent>()
    var viewModels:[BaseViewModel] = Array<BaseViewModel>()
    var titles:[String]?
    private var adapter:SegmentProtocol?
    
    convenience init(adapter:SegmentProtocol,titles:[String]){
        self.init()
        self.adapter = adapter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initSegment()
    }

    func initSegment(){
        let segmented = YSSegmentedControl(
            frame: self.view.bounds,
            titles: self.titles!,
            action: {
                control, index in
                self.segmentSelect(control, selectedSegmentIndex: index)
        })
        self.view.addSubview(segmented)
        
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
        self.adapter?.segmentSelect?(sender, selectedSegmentIndex: selectedSegmentIndex)
    }
}