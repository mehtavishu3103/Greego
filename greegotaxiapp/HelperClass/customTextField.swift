//
//  customTextField.swift
//  Cantina
//
//  Created by Incipientinfo-IOS1 on 2/3/18.
//  Copyright © 2018 AppToDate. All rights reserved.
//

import UIKit

@IBDesignable
class customTextField: UITextField {
   
        @IBInspectable var inset: CGFloat = 0
        
        override func textRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.insetBy(dx: inset, dy: 0)
        }
        
        override func editingRect(forBounds bounds: CGRect) -> CGRect {
            return textRect(forBounds: bounds)
        }
        

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
