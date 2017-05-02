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
    required convenience init?(map: Map) {
        self.init()
    }
    
    // Mappable
    func mapping(map: Map) {
        coord <- map["coord"]
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
    dynamic var lat:Double = 0.0
    dynamic var lon: Double = 0.0
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    // Mappable
    func mapping(map: Map) {
        lat <- map["lat"]
        lon <- map["lon"]
    }
}

