//
//  Constants.swift
//  WidgetPOC
//

import Foundation
import UIKit

typealias StoryBoards = Constants.StoryBoards
typealias ViewControllersIds = Constants.ViewControllersIds
typealias SpecialCharacters = Constants.SpecialCharacters
typealias ApiKeys = Constants.ApiKeys

class Constants {
    
    static let ZERO_VALUE = 0.0
    
    struct ViewControllersIds {
        static let SEARCH_PLACE_VC = "SearchPlaceVC"
    }
    
    struct StoryBoards {
        static let MAIN = UIStoryboard(name: "Main", bundle: nil)
    }
    
    struct SpecialCharacters {
        static let DEGREE_SIGN = "°"
    }
    
    struct ApiKeys {
        static let COORD = "coord"
        static let LAT = "lat"
        static let LON = "lon"
        static let MAIN = "main"
        static let TEMP = "temp"
        static let TEMP_MIN = "temp_min"
        static let TEMP_MAX = "temp_max"
        static let PRESSURE = "pressure"
        static let HUMIDITY = "humidity"
        static let WIND = "wind"
        static let SPEED = "speed"
        static let DEG = "deg"
        static let DESCRIPTION = "description"
        static let SYS = "sys"
        static let SUNRISE = "sunrise"
        static let SUNSET = "sunset"
    }
}
