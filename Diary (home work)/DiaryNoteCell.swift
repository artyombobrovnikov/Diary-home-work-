//
//  DiaryNoteCell.swift
//  Diary (home work)
//
//  Created by Admin on 21.04.16.
//  Copyright © 2016 Bobrovnikov. All rights reserved.
//

import UIKit
class DiaryNoteCell: UITableViewCell {

@IBOutlet var titleLabel: UILabel!
@IBOutlet var timeLabel: UILabel!
    
    @IBOutlet weak var weatherImageView: UIImageView!

override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
}

override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
}
}

