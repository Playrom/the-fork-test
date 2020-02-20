//
//  UIImage.swift
//  The Fork Test
//
//  Created by Giorgio Romano on 20/02/2020.
//  Copyright © 2020 Giorgio Romano. All rights reserved.
//

import UIKit

extension UIImage {
    func imageForNavigationBar() -> UIImage? {
        UIGraphicsBeginImageContext(CGSize(width: 22, height: 22))
        self.draw(in: CGRect(x: 0, y: 0, width: 22, height: 22))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        return image
    }
}
