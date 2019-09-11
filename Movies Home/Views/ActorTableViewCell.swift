//
//  ActorTableViewCell.swift
//  Movies Home
//
//  Created by Mai Abd Elmonem on 9/11/19.
//  Copyright © 2019 Mai Ahmed. All rights reserved.
//

import UIKit

class ActorTableViewCell: UITableViewCell {
    
    @IBOutlet weak var actorImage: UIImageView!
    
    @IBOutlet weak var actorName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
