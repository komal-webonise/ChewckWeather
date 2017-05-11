//
//  WeatherDetailsTableViewCell.swift
//  WidgetPOC
//

import UIKit

class WeatherDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var labelPressure: UILabel!
    @IBOutlet weak var labelHumidity: UILabel!
    @IBOutlet weak var labelWindSpeed: UILabel!
    @IBOutlet weak var labelWindDegree: UILabel!
    
    static let NIB_NAME = "WeatherDetailsTableViewCell"
    
    /// Setup the cell label values
    ///
    /// - Parameter weatherModel: weather model from which the values are to be represented
    func setup(weatherModel: WeatherModel) {
        labelHumidity.text = String(weatherModel.main.humidity) + SpecialCharacters.WHITESPACE
                             + SpecialCharacters.PERCENT
        labelPressure.text = String(weatherModel.main.pressure) + SpecialCharacters.WHITESPACE          + SpecialCharacters.PRESSURE_UNIT
        labelWindSpeed.text = SpecialCharacters.WIND_SPEED_INITIAL +
                              String(weatherModel.wind.speed) +
                              SpecialCharacters.WHITESPACE +
                              SpecialCharacters.WIND_SPEED_UNIT
        labelWindDegree.text = String(weatherModel.wind.deg) +
                               SpecialCharacters.DEGREE_SIGN
    }
}
