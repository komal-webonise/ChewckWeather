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
        button.layer.cornerRadius = ButtonBorderAttributes.CORNER_RADIUS
        button.layer.borderWidth = ButtonBorderAttributes.BORDER_WIDTH
        button.layer.borderColor = UIColor.black.cgColor
    }
}
