//
//  UserDefaultsManager.swift
//  NearBy-IOS
//
//  Created by Ahmed masoud on 7/18/20.
//  Copyright © 2020 Ahmed Masoud. All rights reserved.
//

import Foundation

class UserDefaultsManager {
    //MARK:- Singleton
    static let shared = UserDefaultsManager()
    
    private struct UserDefaultsKeys {
        static let appModeKey = "UDAppMode"
    }
    
    enum AppMode: String {
        case realTime = "realTime"
        case singleUpdate = "singleUpdate"
    }
    
    // MARK:- Properties
    var appModeKey: AppMode {
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: UserDefaultsKeys.appModeKey)
        }
        get {
            guard let mode = UserDefaults.standard.string(forKey: UserDefaultsKeys.appModeKey) else { return .realTime }
            return AppMode(rawValue: mode) ?? .realTime
        }
    }
}
