//
//  CustomTextField.swift
//  ChatScreen
//
//  Created by Hakan Silek on 2.12.2020.
//

import UIKit

class CustomTextField : UITextField{
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10,dy: 0)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
}
