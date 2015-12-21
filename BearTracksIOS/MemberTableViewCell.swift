//
//  MemberTableViewCell.swift
//  
//
//  Created by Tommy Yu on 12/19/15.
//
//

import UIKit

class MemberTableViewCell: UITableViewCell {
    
    //MARK: Properties
    
    @IBOutlet weak var memberNameLabel: UILabel!
    @IBOutlet weak var memerPhotoView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
