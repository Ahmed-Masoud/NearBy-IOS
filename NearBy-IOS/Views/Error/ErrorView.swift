//
//  ErrorView.swift
//  NearBy-IOS
//
//  Created by Ahmed masoud on 7/17/20.
//  Copyright © 2020 Ahmed Masoud. All rights reserved.
//

import UIKit

class ErrorView: UIView {

    //MARK:- Outlets
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var myLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("ErrorView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
    }
    
    func updateWith(image: UIImage, text: String) {
        myImage.image = image
        myLabel.text = text
    }

}
