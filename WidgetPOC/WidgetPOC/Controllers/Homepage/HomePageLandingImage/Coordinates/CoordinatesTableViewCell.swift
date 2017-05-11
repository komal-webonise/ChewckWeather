//
//  CoordinatesTableViewCell.swift
//  WidgetPOC
//

import UIKit

class CoordinatesTableViewCell: UITableViewCell {

    @IBOutlet weak var labelHeader: UILabel!
    @IBOutlet weak var labelLatitude: UILabel!
    @IBOutlet weak var labelLongitude: UILabel!
    @IBOutlet weak var labelLatTitle: UILabel!
    @IBOutlet weak var labelLongTitle: UILabel!
    
    static let NIB_NAME = "CoordinatesTableViewCell"
    
    /// Setup the cell label values
    ///
    /// - Parameter weatherModel: weather model from which the values are to be represented
    func setup(weatherModel: WeatherModel, isSunTimings: Bool) {
        
        labelHeader.text = isSunTimings ? LabelTitles.SUN_TIMINGS : LabelTitles.COORDINATES
        labelLatTitle.text = isSunTimings ? LabelTitles.SUNRISE : LabelTitles.LATITUDE
        labelLongTitle.text = isSunTimings ? LabelTitles.SUNSET : LabelTitles.LONGITUDE
        labelLatitude.text = isSunTimings ?
                             getSunriseTime(weatherModel: weatherModel) :
                             String(weatherModel.coord.lat) + SpecialCharacters.DEGREE_SIGN
        labelLongitude.text = isSunTimings ?
                              getSunsetTime(weatherModel: weatherModel) :
                              String(weatherModel.coord.lon)  + SpecialCharacters.DEGREE_SIGN
    }
    
    /// Gets sunset display time with timeZone got from coordinates
    ///
    /// - Parameter weatherModel: weather model
    /// - Returns: returns sunset
    func getSunsetTime(weatherModel: WeatherModel) -> String {
        let timeZone = Date.getTimeZoneByCoordinate(
            lattitude: weatherModel.coord.lat,
            longitude: weatherModel.coord.lon)
        
        //Get sunset display time with timeZone got from coordinates
        let sunset =  Date(timeIntervalSince1970: weatherModel.system.sunset as TimeInterval).getTime(withTimeZone: timeZone)
        
        return sunset
    }
    
    /// Gets sunrise display time with timeZone got from coordinates
    ///
    /// - Parameter weatherModel: weather model
    /// - Returns: returns sunset
    func getSunriseTime(weatherModel: WeatherModel) -> String {
        let timeZone = Date.getTimeZoneByCoordinate(
            lattitude: weatherModel.coord.lat,
            longitude: weatherModel.coord.lon)
        
        //Get sunrise display time with timeZone got from coordinates
        let sunrise =  Date(timeIntervalSince1970: weatherModel.system.sunrise as TimeInterval).getTime(withTimeZone: timeZone)
        
        return sunrise
    }
}
