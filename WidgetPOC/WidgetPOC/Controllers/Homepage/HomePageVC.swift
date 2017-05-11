//
//  HomePageVC.swift
//  WidgetPOC
//

import Foundation
import UIKit
import GooglePlaces

class HomePageVC: UIViewController {
    
    @IBOutlet weak var tableViewMainPage: UITableView!
    @IBOutlet weak var imageViewBackground: UIImageView!
    @IBOutlet weak var labelCityTime: UILabel!
    @IBOutlet weak var labelPlace: UILabel!
    
    var weatherViewModel = WeatherViewModel()
    
    let ESTIMATED_ROW_HEIGHT: CGFloat = 100
    let TABLE_VIEW_HEADER_HEIGHT: CGFloat = 44
    let NO_OF_ROWS = 4
    
    enum HomePageCells: Int {
        case landingImage = 0
        case weatherDetails
        case sunTimings
        case coordinates
    }
    
    //MARK: View cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
       
        initialUISetup()

        loadFirstPhotoForPlace(placeID: selectedPlaceId)
        tableViewMainPage.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
       loadFirstPhotoForPlace(placeID: selectedPlaceId)
       setCityNameInUserDefaults()
    
        //looks up for place name as per the place Id
        GooglePlaceUtility.lookUpPlaceNameUsing(placeId: selectedPlaceId) { (place) in
            self.labelPlace.text = place
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    ///initial ui setup
    func initialUISetup() {
        registerNibs()
        tableViewMainPage.estimatedRowHeight = ESTIMATED_ROW_HEIGHT
        self.callWeatherWebservice()
    }
    
    /// Registers nibs for the table view
    func registerNibs() {
        tableViewMainPage.register(
            UINib(nibName: HomePageLandingImageTableViewCell.NIB_NAME, bundle: nil),
            forCellReuseIdentifier: HomePageLandingImageTableViewCell.NIB_NAME)
        tableViewMainPage.register(
            UINib(nibName: WeatherDetailsTableViewCell.NIB_NAME, bundle: nil),
            forCellReuseIdentifier: WeatherDetailsTableViewCell.NIB_NAME)
        tableViewMainPage.register(
            UINib(nibName: CoordinatesTableViewCell.NIB_NAME, bundle: nil),
            forCellReuseIdentifier: CoordinatesTableViewCell.NIB_NAME)
    }
    
    /// Sets city name in user defaults
    func setCityNameInUserDefaults() {
        GooglePlaceUtility.lookUpPlaceNameUsing(placeId: selectedPlaceId) { (place) in
            let data = place
            let defaults = UserDefaults(suiteName: Constants.GROUP_SUITE_NAME)
            defaults?.set(data, forKey: UserDefaultsKeys.PLACE)
            defaults?.synchronize()
            self.callWeatherWebservice()
        }
    }
    
    /// Calls webservice for weather model
    func callWeatherWebservice() {
        self.weatherViewModel.webServiceCallForWeatherModel {
            self.tableViewMainPage.delegate = self
            self.tableViewMainPage.dataSource = self
            self.tableViewMainPage.reloadData()
            self.labelCityTime.text = self.getTimeOfCity()
        }
    }

    //MARK: Action button
    @IBAction func buttonSearchLocationTapped(_ sender: Any) {
        let searchPlaceVC = StoryBoards.MAIN.instantiateViewController(withIdentifier: ViewControllersIds.SEARCH_PLACE_VC) as! SearchPlaceVC
        self.present(searchPlaceVC, animated: false, completion: nil)
    }
    
    /// Gets sunset display time with timeZone got from coordinates
    ///
    /// - Returns: returns sunset
    func getTimeOfCity() -> String {
        let timeZone = Date.getTimeZoneByCoordinate(
            lattitude: weatherViewModel.weatherModel.coord.lat,
            longitude: weatherViewModel.weatherModel.coord.lon)
        
        //Get current time display according to time zone
        let date = Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormatters.DATE_FORMAT_HH_MM
        dateFormatter.timeZone = timeZone
        
        let time = dateFormatter.string(from: date)
        return time
    }
}

//MARK: Tableview delegate methods
extension HomePageVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
            case HomePageCells.landingImage.rawValue :
                return setupLandingImageCell(tableView: tableView, indexpath: indexPath)
            case HomePageCells.weatherDetails.rawValue :
                return setupWeatherDetailsCell(tableView: tableView, indexpath: indexPath)
            case HomePageCells.sunTimings.rawValue :
                return setupCoordinatesCell(tableView: tableView, indexpath: indexPath)
            case HomePageCells.coordinates.rawValue :
                return setupCoordinatesCell(tableView: tableView, indexpath: indexPath)
            default:
                return setupLandingImageCell(tableView: tableView, indexpath: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NO_OF_ROWS
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  indexPath.row == HomePageCells.landingImage.rawValue ?
        (self.view.frame.size.height - TABLE_VIEW_HEADER_HEIGHT ) :
        UITableViewAutomaticDimension
    }
    
    /// Setups cell for home page landing image
    ///
    /// - Parameters:
    ///   - tableView: tableview on which cell is to be setup
    ///   - indexpath: index path of cell
    /// - Returns: returns cell with cell set
    func setupLandingImageCell(tableView: UITableView, indexpath: IndexPath) -> HomePageLandingImageTableViewCell {
        let homePageLandingImageTableViewCell = tableViewMainPage.dequeueReusableCell(withIdentifier: HomePageLandingImageTableViewCell.NIB_NAME) as! HomePageLandingImageTableViewCell
        homePageLandingImageTableViewCell.backgroundColor = .clear
        homePageLandingImageTableViewCell.setup(weatherModel: weatherViewModel.weatherModel)
        
        return homePageLandingImageTableViewCell
    }
    
    /// Setups cell for weather details
    ///
    /// - Parameters:
    ///   - tableView: tableview on which cell is to be setup
    ///   - indexpath: index path of cell
    /// - Returns: returns cell with cell set
    func setupWeatherDetailsCell(tableView: UITableView, indexpath: IndexPath) -> WeatherDetailsTableViewCell {
        let weatherDetailsTableViewCell = tableViewMainPage.dequeueReusableCell(withIdentifier: WeatherDetailsTableViewCell.NIB_NAME) as! WeatherDetailsTableViewCell
        weatherDetailsTableViewCell.setup(weatherModel: weatherViewModel.weatherModel)
        weatherDetailsTableViewCell.backgroundColor = .clear
        
        return weatherDetailsTableViewCell
    }
    
    /// Setups cell for displaying coordinates or suntimings
    ///
    /// - Parameters:
    ///   - tableView: tableview on which cell is to be setup
    ///   - indexpath: index path of cell
    /// - Returns: returns cell with cell set
    func setupCoordinatesCell(tableView: UITableView, indexpath: IndexPath) -> CoordinatesTableViewCell {
        let coordinatesTableViewCell = tableViewMainPage.dequeueReusableCell(withIdentifier: CoordinatesTableViewCell.NIB_NAME) as! CoordinatesTableViewCell
        indexpath.row == HomePageCells.sunTimings.rawValue ?
            coordinatesTableViewCell.setup(weatherModel: weatherViewModel.weatherModel, isSunTimings: true) :
            coordinatesTableViewCell.setup(weatherModel: weatherViewModel.weatherModel, isSunTimings: false)
        coordinatesTableViewCell.backgroundColor = .clear
        
        return coordinatesTableViewCell
    }
}

//Google photo finder according to place name
extension HomePageVC {
    
    /// Loads first photo for the particular selected place
    ///
    /// - Parameter placeID: placeID of particular place
    func loadFirstPhotoForPlace(placeID: String) {
        GMSPlacesClient.shared().lookUpPhotos(forPlaceID: placeID) { (photos, error) -> Void in
            if let error = error {
                // TODO: handle the error.
                print("Error: \(error.localizedDescription)")
            } else {
                if let firstPhoto = photos?.results.first {
                    self.loadImageForMetadata(photoMetadata: firstPhoto)
                }
            }
        }
    }
    
    /// loads meta data of photos for the place
    ///
    /// - Parameter photoMetadata: meta data of place image
    func loadImageForMetadata(photoMetadata: GMSPlacePhotoMetadata) {
        GMSPlacesClient.shared().loadPlacePhoto(photoMetadata, callback: {
            (photo, error) -> Void in
            if let error = error {
                // TODO: handle the error.
                print("Error: \(error.localizedDescription)")
            } else {
                self.imageViewBackground.image = photo
            }
        })
    }
}
