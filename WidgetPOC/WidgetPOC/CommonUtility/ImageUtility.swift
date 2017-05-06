//
//  ImageUtility.swift
//  WidgetPOC
//

import Foundation
import SDWebImage

extension UIImage{
    
    func alpha(_ value:CGFloat)->UIImage
    {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
        
    }
    
    func filledImage(fillColor: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, UIScreen.main.scale)
        
        let context = UIGraphicsGetCurrentContext()!
        fillColor.setFill()
        
        context.translateBy(x: 0, y: self.size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        
        context.setBlendMode(CGBlendMode.colorBurn)
        
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        context.draw(self.cgImage!, in: rect)
        
        context.setBlendMode(CGBlendMode.sourceIn)
        context.addRect(rect)
        context.drawPath(using: CGPathDrawingMode.fill)
        
        let coloredImg : UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return coloredImg
    }
}

class ImageUtility {
    
    /// Sets asynchronous image at imageview
    ///
    /// - Parameters:
    ///   - imageView: imageView where image is to be set
    ///   - imageUrl: url to be set for image
    ///   - defaultImage: placeholder image
    ///   - completionBlock: completion block
    static func setAsyncImage(imageView: UIImageView,
                              imageUrl: String,
                              defaultImage: String,
                              completionBlock: SDExternalCompletionBlock?) {
        
        //set image view activity indicator
        imageView.sd_setShowActivityIndicatorView(true)
        imageView.sd_setIndicatorStyle(.gray)
        
        let partnerImage = NSURL(string: imageUrl)
        let placeholderImage = UIImage(named: defaultImage)
        
        imageView.sd_setImage(with: partnerImage as URL?,
                              placeholderImage: placeholderImage,
                              options: [],
                              completed: completionBlock!)
        
    }
}


extension UIImageView
{
    func addBlurEffect()
    {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        self.addSubview(blurEffectView)
    }
}
