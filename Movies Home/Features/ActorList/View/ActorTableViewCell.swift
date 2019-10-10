//
//  ActorTableViewCell.swift
//  Movies Home
//
//  Created by Mai Abd Elmonem on 9/11/19.
//  Copyright © 2019 Mai Ahmed. All rights reserved.
//

import UIKit
import SDWebImage

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
    
    func configureCell(actor : Actor) {
        let  baseimageURL=URL(string: "https://image.tmdb.org/t/p/w500/")
        let placeholderImage = UIImage(named: "apple")
        let ImageUrl = baseimageURL?.appendingPathComponent(actor.profilepath!)
        actorName.text = actor.name
        actorImage.sd_setImage(with: ImageUrl, placeholderImage: placeholderImage)
    }

}
