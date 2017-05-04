//
//  Constants.swift
//  WidgetPOC
//

import Foundation
import UIKit

typealias StoryBoards = Constants.StoryBoards
typealias ViewControllersIds = Constants.ViewControllersIds
typealias SpecialCharacters = Constants.SpecialCharacters

class Constants {
    
    struct ViewControllersIds {
        static let SEARCH_PLACE_VC = "SearchPlaceVC"
    }
    
    struct StoryBoards {
        static let MAIN = UIStoryboard(name: "Main", bundle: nil)
    }
    
    struct SpecialCharacters {
        static let DEGREE_SIGN = "°"
    }
}
