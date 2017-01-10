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
    let timeLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(levelView)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(detailLabel)
        self.contentView.addSubview(flagLabel)
        self.contentView.addSubview(timeLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        levelView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.contentView.snp.top)
            make.left.equalTo(self.contentView.snp.left)
            make.bottom.equalTo(self.contentView.snp.bottom)
            make.width.equalTo(2)
        }
        
        titleLabel.numberOfLines = 1
        titleLabel.font = UIFont.systemFont(ofSize: 12)
        titleLabel.textColor = UIColor(rgba: Color.fontGray)
        titleLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.contentView.snp.top).offset(5)
            make.left.equalTo(levelView.snp.right).offset(5)
            make.right.equalTo(self.contentView.snp.right).offset(-5)
            make.height.equalTo(13)
        }
        
        detailLabel.numberOfLines = 1
        detailLabel.font = UIFont.systemFont(ofSize: 14)
        detailLabel.textColor = UIColor(rgba: Color.fontBlack)
        detailLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.equalTo(titleLabel.snp.left)
            make.right.equalTo(self.contentView.snp.right).offset(-5)
            make.height.equalTo(15)
        }
        
        flagLabel.numberOfLines = 1
        flagLabel.font = UIFont.systemFont(ofSize: 10)
        flagLabel.textColor = UIColor(rgba: Color.fontLightGray)
        flagLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(detailLabel.snp.bottom).offset(10)
            make.left.equalTo(detailLabel.snp.left)
            make.right.equalTo(self.contentView.snp.right).offset(-5)
            make.height.equalTo(11)
        }
        
        timeLabel.numberOfLines = 1
        timeLabel.font = UIFont.systemFont(ofSize: 10)
        timeLabel.textColor = UIColor(rgba: Color.fontLightGray)
        timeLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(flagLabel.snp.bottom).offset(10)
            make.left.equalTo(flagLabel.snp.left)
            make.right.equalTo(self.contentView.snp.right).offset(-5)
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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
