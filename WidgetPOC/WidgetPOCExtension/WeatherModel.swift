//
//  WeatherModel.swift
//  WidgetPOC
//

import Foundation
import Realm
import RealmSwift
import ObjectMapper

class WeatherModel : Object,Mappable  {
    dynamic var coord: Coord!
    dynamic var main: Main!
    dynamic var sys: Sys!
    dynamic var wind: Wind!
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    // Mappable
    func mapping(map: Map) {
        coord <- map[ApiKeys.COORD]
        main <- map[ApiKeys.MAIN]
        sys <- map[ApiKeys.SYS]
        wind <- map[ApiKeys.WIND]
    }
    
    /// Save weather model object
    ///
    /// - Parameter weatherModel: weatherModel object to be saved
    static func saveWeatherModel(weatherModel: WeatherModel) {
        let realm = try! Realm()
        try! realm.write {
            if let _ = WeatherModel.retrieveWeatherModel() {
                realm.delete(realm.objects(WeatherModel.self))
            }
            realm.add(weatherModel)
        }
    }
    
    /// Retrieve weather model object from db
    ///
    /// - Returns: returns the weather model object
    static func retrieveWeatherModel() -> WeatherModel? {
        let realm = try! Realm()
        
        if let weatherDetailsResult = realm.objects(WeatherModel.self) as Results<WeatherModel>?,
            (!weatherDetailsResult.isEmpty  && !weatherDetailsResult.isInvalidated && (weatherDetailsResult.first != nil)) {
            return weatherDetailsResult.first
        }
        return nil
    }
}

class Coord : Object,Mappable {
    dynamic var lat:Double = Constants.ZERO_VALUE
    dynamic var lon: Double = Constants.ZERO_VALUE
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    // Mappable
    func mapping(map: Map) {
        lat <- map[ApiKeys.LAT]
        lon <- map[ApiKeys.LON]
    }
}

class Main : Object,Mappable {
    dynamic var temp: Double = Constants.ZERO_VALUE
    dynamic var tempMin: Double = Constants.ZERO_VALUE
    dynamic var tempMax: Double = Constants.ZERO_VALUE
    dynamic var pressure: Double = Constants.ZERO_VALUE
    dynamic var humidity: Double = Constants.ZERO_VALUE

    required convenience init?(map: Map) {
        self.init()
    }
    
    // Mappable
    func mapping(map: Map) {
        temp <- map[ApiKeys.TEMP]
        tempMin <- map[ApiKeys.TEMP_MIN]
        tempMax <- map[ApiKeys.TEMP_MAX]
        pressure <- map[ApiKeys.PRESSURE]
        humidity <- map[ApiKeys.HUMIDITY]
    }
}

class Wind : Object,Mappable {
    dynamic var speed: Double = Constants.ZERO_VALUE
    dynamic var deg: Double = Constants.ZERO_VALUE
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    // Mappable
    func mapping(map: Map) {
        speed <- map[ApiKeys.SPEED]
        deg <- map[ApiKeys.DEG]
    }
}

class Sys : Object,Mappable {
    dynamic var sunrise: Double = Constants.ZERO_VALUE
    dynamic var sunset: Double = Constants.ZERO_VALUE
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    // Mappable
    func mapping(map: Map) {
        sunrise <- map[ApiKeys.SUNRISE]
        sunset <- map[ApiKeys.SUNSET]
    }
}
