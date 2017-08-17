//
//  UserDetailTableViewCell.swift
//  GS
//
//  Created by andyron on 2017/8/18.
//  Copyright © 2017年 andyron. All rights reserved.
//

import UIKit

class UserDetailTableViewCell: UITableViewCell {

    @IBOutlet var numberLabel: UILabel!
    @IBOutlet var loginLabel: UILabel!
    @IBOutlet var starLabel: UILabel!
    @IBOutlet var ownerLabel: UILabel!
    @IBOutlet var languageLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
