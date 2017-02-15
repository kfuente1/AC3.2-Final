//
//  FeedCellTableViewCell.swift
//  AC3.2-Final
//
//  Created by Karen Fuentes on 2/15/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit

class FeedCellTableViewCell: UITableViewCell {

    @IBOutlet weak var commentLabel: UILabel!
  
    @IBOutlet weak var uploadImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
