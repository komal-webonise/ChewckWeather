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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
