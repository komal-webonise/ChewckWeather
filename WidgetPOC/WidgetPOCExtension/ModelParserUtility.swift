//
//  ModelParserUtility.swift
//  WidgetPOC
//

import Foundation

import ObjectMapper

class ModelParserUtility {
    /**
     this is generic method for parsing mappable models
     
     - parameter modelResponse: model json object as AnyObject
     - parameter modelClass:    pass the class type here
     
     - returns: return model with populated values after parsing
     */
    static func parseModel<Model: Mappable>(modelResponse: Any,
                           modelClass: Model.Type) ->  Model? {
        
        let mapper = Mapper<Model>()
        let modelObject = mapper.map(JSONObject: modelResponse)
        return modelObject
    }
    
    /**
     this is generic method for parsing mappable models
     
     - parameter modelResponse: model json object as AnyObject
     - parameter modelClass:    pass the class type here
     
     - returns: return model with populated values after parsing
     */
    static func parseModelWithArrayWithNoKey<Model: Mappable>(modelResponse: [[String: Any]],
                                             modelClass: Model.Type) ->  [Model]? {
        
        let mapper = Mapper<Model>()
        let modelObject = mapper.mapArray(JSONArray: modelResponse)
        return modelObject
    }
}

