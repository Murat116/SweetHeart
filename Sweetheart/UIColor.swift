//
//  UIColor.swift
//  Sweetheart
//
//  Created by anmin on 30.01.2021.
//

import UIKit

public func SCColor(named name: String) -> UIColor {
    return UIColor(named: name, in: Bundle.main, compatibleWith: nil)!
}

extension UIColor {
    convenience init(r: Int, g:Int, b:Int, a:CGFloat = 1 ) {
        self.init(red:   CGFloat( r )   / 255,
                  green: CGFloat( g ) / 255,
                  blue:  CGFloat( b )  / 255,
                  alpha: a )
    }
    
    static func rgba(_ r: Int,_ g:Int,_ b:Int,_ a:CGFloat = 1 ) -> UIColor{
        return UIColor.init(red:   CGFloat( r )   / 255,
                  green: CGFloat( g ) / 255,
                  blue:  CGFloat( b )  / 255,
                  alpha: a )
    }
}
