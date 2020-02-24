//
//  UIColor.swift
//  The Fork Test
//
//  Created by Giorgio Romano on 24/02/2020.
//  Copyright © 2020 Giorgio Romano. All rights reserved.
//

import UIKit

extension UIColor {
    var redValue: CGFloat{ return CIColor(color: self).red }
    var greenValue: CGFloat{ return CIColor(color: self).green }
    var blueValue: CGFloat{ return CIColor(color: self).blue }
    var alphaValue: CGFloat{ return CIColor(color: self).alpha }
}
