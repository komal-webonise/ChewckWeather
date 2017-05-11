//
//  TodayViewController.swift
//  WidgetPOCExtension
//

import UIKit
import NotificationCenter
import Alamofire
import GooglePlaces

class TodayViewController: UIViewController, NCWidgetProviding {
    
    @IBOutlet weak var labelCityTemperature: UILabel!
    @IBOutlet weak var labelCity: UILabel!
    
    var weatherViewModel = WeatherViewModel()
    
    let TEMPERATURE_CONVERTER = 273.15
    
    //MARK: View Cycle Method
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults(suiteName: Constants.GROUP_SUITE_NAME)
        
        weatherViewModel.webServiceCallForWeatherModel {
            self.labelCityTemperature.text = String(Int(self.weatherViewModel.weatherModel.main.temp - self.TEMPERATURE_CONVERTER)) + SpecialCharacters.DEGREE_SIGN
        }
        
        //looks up for place name as per the place id in userdefaults
        let place  = defaults?.value(forKey: UserDefaultsKeys.PLACE) as? String ??          DefaultValues.DEFAULT_PLACE
        
        labelCity.text = place
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /// Perform any setup necessary in order to update the view.
    ///
    /// - Parameter completionHandler: completion handler to update the result
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        
        //looks up for place name as per the place Id
        let defaults = UserDefaults(suiteName: Constants.GROUP_SUITE_NAME)
        let place  = defaults?.value(forKey: UserDefaultsKeys.PLACE) as? String ?? DefaultValues.DEFAULT_PLACE
        
        labelCity.text = place
        
        weatherViewModel.webServiceCallForWeatherModel {
            self.labelCityTemperature.text = String(Int(self.weatherViewModel.weatherModel.main.temp - self.TEMPERATURE_CONVERTER)) + SpecialCharacters.DEGREE_SIGN
        }
        
        completionHandler(NCUpdateResult.newData)
    }
}
