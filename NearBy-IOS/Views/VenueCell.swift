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
        self.venueImageView.image = nil
        loadImage(venue: venue.id ?? "")
    }
    
    func loadImage(venue: String) {
        let api = FourSquareAPI()
        api.getPhotos(for: venue) { [weak self] (result) in
            switch result {
            case .success(let response):
                guard let photo = response else { return }
                self?.venueImageView.kf.indicatorType = .activity
                let vm = FourSquarePhotoVM(photo: photo)
                self?.venueImageView.kf.setImage(with: URL(string: vm.url ?? ""), options : [ .transition(.fade(1)) ])
            case .failure(let err):
                print(err)
            }
        }
    }
}
