//
//  AlamofireUtility.swift
//  WidgetPOC
//

import Foundation
import Alamofire

var AlamofireUtilityInstance : AlamofireUtility { return AlamofireUtility() }

class AlamofireUtility {
    
    /// These method is used to make a get call for the api
    ///
    /// - Parameters:
    ///   - url: url of the api
    ///   - requestParams: parameters to be passed along with url
    ///   - success: success block
    ///   - failure: failure block
    func getCallWithAlamofireUtility(url: String,
                                     requestParams: Any? = [:],
                                     success: @escaping ((_ response: Any?)->()),
                                     failure: @escaping (_ error: NSError?)->()) {
        
        Alamofire.request(url, method: .get, parameters: requestParams as? [String:Any]).validate().responseJSON { (response) in
            if let error = response.result.error {
                failure(error as NSError)
            } else {
                success(response.result.value as Any?)
            }
            
        }
    }
}
