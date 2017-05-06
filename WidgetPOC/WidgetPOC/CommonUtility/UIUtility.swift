//
//  UIUtility.swift
//  WidgetPOC
//

import Foundation
import UIKit

class UIUtility {
    
    /// Adds rounded border to button from all sides
    ///
    /// - Parameter button: button to which border is to be added
    static func addBorderToButton(button: UIButton) {
        button.backgroundColor = .clear
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
    }
}
