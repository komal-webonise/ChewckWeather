//
//  WeatherViewModel.swift
//  WidgetPOC
//

import Foundation
class WeatherViewModel {
    var weatherModel: WeatherModel = WeatherModel.retrieveWeatherModel() ?? WeatherModel()
    
    /// web servvice call for weather model
    ///
    /// - Parameter completionBlock: completion block to be executed
    func webServiceCallForWeatherModel(completionBlock: @escaping (()->())) {
        //Access the userdefaults group which is shared between the application and today widget
        let defaults = UserDefaults(suiteName: "group.WidgetPOCGroup")
        
        //access the city variable from that group
        let city = defaults?.value(forKey: "data") ?? "Pune"
        
        ModelApiUtilityInstance.callWeatherWebService(city: city as! String) { (weatherModel) in
            self.weatherModel = weatherModel ?? WeatherModel()
            //saves the model
            WeatherModel.saveWeatherModel(weatherModel: self.weatherModel)
            completionBlock()
        }
    }
}
