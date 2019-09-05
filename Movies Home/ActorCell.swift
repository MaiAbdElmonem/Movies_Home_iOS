//
//  ActorCell.swift
//  Movies Home
//
//  Created by Lost Star on 9/2/19.
//  Copyright © 2019 Mai Ahmed. All rights reserved.
//

import UIKit

class ActorCell: UITableViewCell {

    @IBOutlet weak var actorImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
