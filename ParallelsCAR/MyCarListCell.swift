//
//  CarTypeListCell.swift
//  ParallelsCAR
//
//  Created by tangchunhui on 15/3/5.
//  Copyright (c) 2015年 tangchunhui. All rights reserved.
//

import Foundation

class CarTypeListCell:UITableViewCell {
    @IBOutlet var title:UILabel!
    @IBOutlet var detail:UILabel!
    @IBOutlet var price:UILabel!
    @IBOutlet var fbsj:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.title.text=""
        self.detail.text=""
        self.price.text = ""
        self.fbsj.text = ""
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}