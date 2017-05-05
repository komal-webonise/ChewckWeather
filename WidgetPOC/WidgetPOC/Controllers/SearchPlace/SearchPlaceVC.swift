//
//  SearchPlaceVC.swift
//  WidgetPOC
//

import Foundation
import UIKit
import GoogleMaps
import GooglePlaces
import MapKit

//Selected place id
var selectedPlaceId: String {
    get {
        let defaults = UserDefaults(suiteName: "group.WidgetPOCGroup")
        return defaults?.value(forKey: "placeId") as! String? ?? "NA"
    }
    set(value) {}
}

class SearchPlaceVC: UIViewController {
    
    @IBOutlet weak var searchBarLocationName: UISearchBar!
    @IBOutlet weak var tableViewSearchResults: UITableView!
    
    var noOfRows = 1
    var arrayCityResults = [String]()
    var arrayCitiesPlaceId = [String]()
    var lastLocation: CLLocation?
    static var selectedPlaceId = ""
    
    let ESTIMATED_ROW_HEIGHT: CGFloat = 100
    let locationManager = CLLocationManager()
    
    //MARK: View cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBarLocationName.delegate = self
        initialUISetup()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: Action buttons
    @IBAction func buttonDetectMyLocationTapped(_ sender: Any) {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    /// Initial ui setup
    func initialUISetup() {
        tableViewSearchResults.estimatedRowHeight = ESTIMATED_ROW_HEIGHT
        tableViewSearchResults.delegate = self
        tableViewSearchResults.dataSource = self
    }
    
    /// Reloads tableview
    ///
    /// - Parameter array: array of cities
    func reloadDataWithArray(array: [String],arrayPlaceIds: [String]) {
        arrayCitiesPlaceId = arrayPlaceIds
        arrayCityResults = array
        tableViewSearchResults.reloadData()
    }
}

extension SearchPlaceVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let searchPlaceTableViewCell = tableView.dequeueReusableCell(withIdentifier: SearchPlaceTableViewCell.reuseIdentifier) as! SearchPlaceTableViewCell
        
        setupCell(searchPlaceTableViewCell: searchPlaceTableViewCell, indexPath: indexPath)
        
        return searchPlaceTableViewCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayCityResults.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // let cell = tableView.cellForRow(at: indexPath) as! SearchPlaceTableViewCell

       // SearchPlaceVC.selectedPlaceId = arrayCitiesPlaceId[indexPath.row]
        
        let defaults = UserDefaults(suiteName: "group.WidgetPOCGroup")
        defaults?.set(arrayCitiesPlaceId[indexPath.row], forKey: "placeId")
        defaults?.synchronize()
        
        self.dismiss(animated: false, completion: nil)
    }
    
    /// Setups the tableview of search table
    ///
    /// - Parameters:
    ///   - searchPlaceTableViewCell: search place tableview
    ///   - indexPath: indexpath of the tableview
    func setupCell(searchPlaceTableViewCell: SearchPlaceTableViewCell, indexPath: IndexPath) {
        searchPlaceTableViewCell.labelCity.text =  arrayCityResults[indexPath.row]
    }
}

//MARK: Search bar delegate
extension SearchPlaceVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let placeClient = GMSPlacesClient()
        let filter = GMSAutocompleteFilter()
        filter.type = .city
        self.arrayCitiesPlaceId.removeAll()
        
        //Call autocomplete query to search locations with the search text passed as parameter and displays only city names
        placeClient.autocompleteQuery(searchText, bounds: nil, filter: filter) { (results, error: Error? ) in
            self.arrayCityResults.removeAll()
            
            //Checks if the result is nil and removes all the elements in the city names and reloads table View
            if results == nil{
                print("blank")
                self.arrayCityResults.removeAll()
                self.arrayCitiesPlaceId.removeAll()
                self.tableViewSearchResults.reloadData()
                return
            }
            
            for result in results! {
                if let result = result as? GMSAutocompletePrediction {
                    
                    //appends all city name into the array of cities name
                    self.arrayCitiesPlaceId.append(result.placeID!)
                    self.arrayCityResults.append(result.attributedFullText.string)
                }
                
                //reloads tableView when new city name is found
                self.reloadDataWithArray(array: self.arrayCityResults, arrayPlaceIds: self.arrayCitiesPlaceId)
            }
        }
    }
    
}

//MARK: Location manager delegate
extension SearchPlaceVC: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
   func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.first != nil {
            print("location:: \(locations)")
        }
    guard let lastLocation = locations.first else { return }
    
    self.lastLocation = lastLocation
    
    let geoCoder = CLGeocoder()
    
    geoCoder.reverseGeocodeLocation(lastLocation) { (arrayPlacemarks, error) in
        if let arrayPlacemarks = arrayPlacemarks as [CLPlacemark]! {
            let placeMark: CLPlacemark = arrayPlacemarks[0]
            if let city = placeMark.addressDictionary?["City"] as? NSString {
                print(city)
            }
        }
    }
    //stop updating location
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: (error)")
    }
}
