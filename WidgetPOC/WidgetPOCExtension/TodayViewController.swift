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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults(suiteName: Constants.GROUP_SUITE_NAME)
        print(defaults?.value(forKey: UserDefaultsKeys.PLACE) ?? DefaultValues.DEFAULT_PLACE)
        
        weatherViewModel.webServiceCallForWeatherModel {
            self.labelCityTemperature.text = String(Int(self.weatherViewModel.weatherModel.main.temp - self.TEMPERATURE_CONVERTER)) + SpecialCharacters.DEGREE_SIGN
        }
        
        //looks up for place name as per the place I
        let place  = defaults?.value(forKey: UserDefaultsKeys.PLACE) as? String ?? DefaultValues.DEFAULT_PLACE
        labelCity.text = place
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
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
