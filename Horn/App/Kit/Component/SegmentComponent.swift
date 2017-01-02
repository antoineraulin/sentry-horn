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
    @objc optional func segmentSelect(_ sender: YSSegmentedControl, selectedSegmentIndex: Int)
}

class SegmentComponent:BaseViewController {

    fileprivate var titles:[String]?
    fileprivate var adapter:SegmentProtocol?
    
    convenience init(adapter:SegmentProtocol, titles:[String]){
        self.init()
        self.adapter = adapter
        self.titles = titles
    }
    
    override func didMove(toParentViewController parent: UIViewController?){
        super.didMove(toParentViewController: parent)
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
            backgroundColor: UIColor.white,
            selectedBackgroundColor: UIColor.white,
            
            textColor: UIColor(rgba: Color.FontGray),
            font: UIFont.systemFont(ofSize: 14),
            
            selectedTextColor: UIColor(rgba: Color.FontBlack),
            selectedFont: UIFont.systemFont(ofSize: 14),
            
            bottomLineColor: UIColor(rgba: Color.LineGray),
            selectorColor: UIColor(rgba:Color.Blue),
            
            bottomLineHeight: 0.5,
            selectorHeight: 1,
            labelTopPadding: 0
        )
    }
    
    func segmentSelect(_ sender: YSSegmentedControl, selectedSegmentIndex: Int) {
        self.adapter?.segmentSelect?(sender, selectedSegmentIndex: selectedSegmentIndex)
    }
}
