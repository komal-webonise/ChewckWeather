//
//  TodayViewController.swift
//  WidgetPOCExtension
//
//  Created by komal lunkad on 24/04/17.
//  Copyright © 2017 komal lunkad. All rights reserved.
//

import UIKit
import NotificationCenter
import Alamofire


class TodayViewController: UIViewController, NCWidgetProviding {
    //http://api.openweathermap.org/data/2.5/weather?q=pune&appid=82d42d1bbaa0bbec840a96ca44a1660d
    
    var weatherViewModel = WeatherViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults(suiteName: "group.WidgetPOCGroup")
        print(defaults?.value(forKey: "data") ?? "NA")
        
        weatherViewModel.webServiceCallForWeatherModel {
            print(self.weatherViewModel.weatherModel.coord?.lat ?? "no value")
        }
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
        
        completionHandler(NCUpdateResult.newData)
    }
    
    
    
    
}
