//
//  ImageUtility.swift
//  WidgetPOC
//

import Foundation
import SDWebImage

extension UIImageView {
    
    /// Adds blur effect over an imageview
    func addBlurEffect() {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        let viewBlurEffect = UIVisualEffectView(effect: blurEffect)
        viewBlurEffect.frame = self.bounds
        
        viewBlurEffect.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        self.addSubview(viewBlurEffect)
    }
    
    /// Removes blur effect over an image view
    func removeBlurEffect() {
        for subView in self.subviews {
            if subView is UIVisualEffectView {
                subView.removeFromSuperview()
            }
        }
    }
}
