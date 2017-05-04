//
//  GooglePlaceUtility.swift
//  WidgetPOC
//

import Foundation
import GooglePlaces

class GooglePlaceUtility {
    
    /// Look up for place name using place Id
    ///
    /// - Parameter placeId: place id for the place
    /// - Returns: returns place name
    static func lookUpPlaceNameUsing(placeId: String, completionBlock: @escaping((_ placeFound: String) -> ())) {
        var placeName = ""
        
        let placeClient = GMSPlacesClient()
        let filter = GMSAutocompleteFilter()
        filter.type = .city
        placeClient.lookUpPlaceID(placeId, callback: { (place, error) -> Void in
            if let error = error {
                print("lookup place id query error: \(error.localizedDescription)")
                return
            }
            
            guard let place = place else {
                print("No place details for \(placeId)")
                return
            }
            placeName = place.name
            print("Place name \(place.name)")
            completionBlock(place.name)
        })
        //return placeName
    }
}
