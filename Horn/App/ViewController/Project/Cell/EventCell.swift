//
//  EventCell.swift
//  Horn
//
//  Created by Thierry on 16/3/7.
//  Copyright © 2016年 Thierry. All rights reserved.
//

import UIKit

class EventCell: UITableViewCell {
    
    let levelView = UIView()
    let titleLabel = UILabel()
    let detailLabel = UILabel()
    let flagLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(levelView)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(detailLabel)
        self.contentView.addSubview(flagLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        levelView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.contentView.snp_top)
            make.left.equalTo(self.contentView.snp_left)
            make.bottom.equalTo(self.contentView.snp_bottom)
            make.width.equalTo(2)
        }
        
        titleLabel.numberOfLines = 1
        titleLabel.font = UIFont.systemFontOfSize(12)
        titleLabel.textColor = UIColor(rgba: Color.FontGray)
        titleLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.contentView.snp_top).offset(5)
            make.left.equalTo(levelView.snp_right).offset(5)
            make.right.equalTo(self.contentView.snp_right).offset(-5)
            make.height.equalTo(13)
        }
        
        detailLabel.numberOfLines = 1
        detailLabel.font = UIFont.systemFontOfSize(14)
        detailLabel.textColor = UIColor(rgba: Color.FontBlack)
        detailLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(titleLabel.snp_bottom).offset(10)
            make.left.equalTo(titleLabel.snp_left)
            make.right.equalTo(self.contentView.snp_right).offset(-5)
            make.height.equalTo(15)
        }
        
        flagLabel.numberOfLines = 1
        flagLabel.font = UIFont.systemFontOfSize(10)
        flagLabel.textColor = UIColor(rgba: Color.FontLightGray)
        flagLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(detailLabel.snp_bottom).offset(10)
            make.left.equalTo(detailLabel.snp_left)
            make.right.equalTo(self.contentView.snp_right).offset(-5)
            make.height.equalTo(11)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
