//
//  LoadingVC.swift
//  NearBy-IOS
//
//  Created by Ahmed masoud on 7/17/20.
//  Copyright © 2020 Ahmed Masoud. All rights reserved.
//

import UIKit

class LoadingVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let api = FourSquareAPI()
        api.getLocations { (result) in
            switch result {
            case .success(let res):
                res?.response?.groups?.first?.items?.forEach({print($0.venue?.name)})
            case .failure(let error):
                print(error)
            }
        }
    }

}

