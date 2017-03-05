//
//  BookMarkTableViewCell.swift
//  MyCalenderApp
//
//  Created by kawahara keisuke on 2017/01/29.
//  Copyright © 2017年 kawahara keisuke. All rights reserved.
//

import UIKit

class LikedTableViewCell: UITableViewCell{
    
    @IBOutlet weak var sentenceLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
