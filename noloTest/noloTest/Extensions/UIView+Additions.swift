//
//  UIView+Additions.swift
//  noloTest
//
//  Created by Aryan Sharma on 27/07/19.
//  Copyright © 2019 Aryan Sharma. All rights reserved.
//

import UIKit

extension UIView {
    func dropShadow(scale: Bool = true) {
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 6
    }
}
