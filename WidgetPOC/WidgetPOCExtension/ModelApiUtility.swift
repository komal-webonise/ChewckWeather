//
//  ModelApiUtility.swift
//  WidgetPOC
//

import Foundation
import ObjectMapper

let ModelApiUtilityInstance = ModelApiUtility()

class ModelApiUtility {
    
    /// Calls weather web service
    ///
    /// - Parameters:
    ///   - city: city
    ///   - completionHandlerWithWeatherModel: comletion handler block
    func callWeatherWebService(city: String,
                               completionHandlerWithWeatherModel: ((_ weatherModel: WeatherModel?) -> ())?) {
        let parameters = [
            ParameterValues.QUERY: city,
            ParameterValues.APP_ID: ParameterValues.APP_ID_VALUE]
        
        AlamofireUtilityInstance.getCallWithAlamofireUtility(url: Constants.URL,
                                    requestParams: parameters,
                                    success: { (response) in
            
                                        if let response = response as? [String: Any],
                                            let weatherModel = Mapper<WeatherModel>().map(JSON: response) {
                                            print(weatherModel)
                                            completionHandlerWithWeatherModel!(weatherModel)
                                        } else {
                                            completionHandlerWithWeatherModel!(nil)
                                        }
            
        }) { (error) in
            print(error ?? "error as default")
        }
    }

}
