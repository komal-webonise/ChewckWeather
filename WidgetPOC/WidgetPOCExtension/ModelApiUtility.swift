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
        let URL = "http://api.openweathermap.org/data/2.5/weather"
        let parameters = [
            "q" : city,
            "appid":"82d42d1bbaa0bbec840a96ca44a1660d"]
        AlamofireUtilityInstance.getCallWithAlamofireUtility(url: URL,
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
