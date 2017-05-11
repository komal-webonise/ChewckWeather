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
        var placeName = Constants.EMPTY_STRING
         
        let placeClient = GMSPlacesClient()
        
        //Filters city name
        let filter = GMSAutocompleteFilter()
        filter.type = .city
        
        //looks up for place name using place id
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
            completionBlock(place.name)
        })
    }
}
