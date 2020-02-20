//
//  Style.swift
//  The Fork Test
//
//  Created by Giorgio Romano on 20/02/2020.
//  Copyright © 2020 Giorgio Romano. All rights reserved.
//

import UIKit

struct Style {
    
    static let theForkGreenColor = UIColor(red: 0.306, green: 0.537, blue: 0.227, alpha: 1.0)
    
    struct Restaurants {
        static let tintColor = UIColor.white
        static let barTintColor = theForkGreenColor
        static let backgroundColor = theForkGreenColor
        static let prefersLargeTitle = true
        
        @available(iOS 13.0, *)
        static var navBarAppearance: UINavigationBarAppearance {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.backgroundColor = Restaurants.backgroundColor
            return navBarAppearance
        }
    }
}
