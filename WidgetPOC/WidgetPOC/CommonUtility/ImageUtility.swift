//
//  ImageUtility.swift
//  WidgetPOC
//

import Foundation
import SDWebImage

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
