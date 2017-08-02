//
//  FishTableViewCell.swift
//  Gacha
//
//  Created by nttr on 2017/07/19.
//  Copyright © 2017年 nttr. All rights reserved.
//

import UIKit

class FishTableViewCell: UITableViewCell {
    
    @IBOutlet var fishImageView : UIImageView!
    @IBOutlet var fishLabel : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
