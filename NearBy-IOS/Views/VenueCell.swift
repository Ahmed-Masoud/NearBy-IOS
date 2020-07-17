//
//  VenueCell.swift
//  NearBy-IOS
//
//  Created by Ahmed masoud on 7/17/20.
//  Copyright © 2020 Ahmed Masoud. All rights reserved.
//

import UIKit
import Kingfisher

class VenueCell: UITableViewCell {
    
    //MARK:- Outlets
    @IBOutlet weak var venueImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    //MARK:-
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    func update(with venue: FourSquareVenueVMProtocol) {
        nameLabel.text = venue.name
        addressLabel.text = venue.address
        self.venueImageView.image = UIImage(named: "placeholderImage")!
        self.venueImageView.kf.indicatorType = .activity
        if let image = venue.image {
            if let url = image.url {
                self.venueImageView.kf.setImage(with: URL(string: url), placeholder: UIImage(named: "placeholderImage")!, options: [.transition(.fade(1)) ])
            }
        }
    }
}
