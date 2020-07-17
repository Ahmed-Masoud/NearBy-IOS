//
//  UIViewController+Create.swift
//  NearBy-IOS
//
//  Created by Ahmed masoud on 7/17/20.
//  Copyright © 2020 Ahmed Masoud. All rights reserved.
//

import Foundation
import  UIKit

extension UIViewController {
    class func create<T: UIViewController>(storyboard: StoryBoard, identifier: String) -> T {
        let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: identifier) as! T
    }
}
