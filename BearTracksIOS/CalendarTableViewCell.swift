//
//  CalendarTableViewCell.swift
//  BearTracks
//
//  Created by Tommy Yu on 12/25/15.
//  Copyright © 2015 Team766. All rights reserved.
//

import UIKit

class CalendarTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
