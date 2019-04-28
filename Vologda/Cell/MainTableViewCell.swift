//
//  MainTableViewCell.swift
//  Vologda
//
//  Created by Maxim Pyatovskiy on 25/04/2019.
//  Copyright © 2019 Maxim Pyatovskiy. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    @IBOutlet weak var Title: UILabel!
    @IBOutlet weak var Description: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
