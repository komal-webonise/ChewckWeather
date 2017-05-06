//
//  HomePageLandingImageTableViewCell.swift
//  WidgetPOC
//

import UIKit

class HomePageLandingImageTableViewCell: UITableViewCell {

    @IBOutlet weak var imageViewBackground: UIImageView!
    @IBOutlet weak var labelMaxTemperature: UILabel!
    @IBOutlet weak var labelMinTemperature: UILabel!
    @IBOutlet weak var labelAverageTemperature: UILabel!
    
    static let NIB_NAME = "HomePageLandingImageTableViewCell"
    let TEMPERATURE_CONVERTER = 273.15
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    /// Setup the cell label values
    ///
    /// - Parameter weatherModel: weather model from which the values are to be represented
    func setup(weatherModel: WeatherModel) {
        labelMaxTemperature.text = String(Int(weatherModel.main.tempMax - TEMPERATURE_CONVERTER)) + SpecialCharacters.DEGREE_SIGN
        labelMinTemperature.text = String(Int(weatherModel.main.tempMin  - TEMPERATURE_CONVERTER)) + SpecialCharacters.DEGREE_SIGN
        labelAverageTemperature.text = String(Int(weatherModel.main.temp - TEMPERATURE_CONVERTER)) + SpecialCharacters.DEGREE_SIGN
    }
}
