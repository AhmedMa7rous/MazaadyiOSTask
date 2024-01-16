//
//  UIView+Extension.swift
//  MazaadyiOSTask
//
//  Created by Ahmed Mahrous on 14/01/2024.
//

import UIKit

extension UIView {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: "\(self)", bundle: nil)
    }
}
