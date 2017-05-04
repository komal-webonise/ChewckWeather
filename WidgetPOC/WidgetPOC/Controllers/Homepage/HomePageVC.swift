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
    
    let ESTIMATED_ROW_HEIGHT: CGFloat = 100
    let TABLE_VIEW_HEADER_HEIGHT: CGFloat = 44
    
    //MARK: View cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
       
        initialUISetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
       loadFirstPhotoForPlace(placeID: selectedPlaceId)
       tableViewMainPage.reloadData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //initial ui setup
    func initialUISetup() {
        tableViewMainPage.estimatedRowHeight = ESTIMATED_ROW_HEIGHT
        tableViewMainPage.register(
            UINib(nibName: HomePageLandingImageTableViewCell.NIB_NAME, bundle: nil),
            forCellReuseIdentifier: HomePageLandingImageTableViewCell.NIB_NAME)
        tableViewMainPage.register(
            UINib(nibName: HomePageHeaderView.NIB_NAME, bundle: nil),
            forHeaderFooterViewReuseIdentifier: HomePageHeaderView.NIB_NAME)
        tableViewMainPage.delegate = self
        tableViewMainPage.dataSource = self
    }

}

//MARK: Tableview delegate methods
extension HomePageVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let homePageHeaderView = tableView.dequeueReusableHeaderFooterView(withIdentifier: HomePageHeaderView.NIB_NAME) as! HomePageHeaderView
        homePageHeaderView.buttonSearchCity.addTarget(self, action: #selector(buttonSearchCityTapped), for: .touchUpInside)
       
        //looks up for place name as per the place Id
        GooglePlaceUtility.lookUpPlaceNameUsing(placeId: selectedPlaceId) { (place) in
            homePageHeaderView.labelCityName.text = place
        }
        
        return homePageHeaderView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return TABLE_VIEW_HEADER_HEIGHT
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let homePageLandingImageTableViewCell = tableView.dequeueReusableCell(withIdentifier: HomePageLandingImageTableViewCell.NIB_NAME) as! HomePageLandingImageTableViewCell
        homePageLandingImageTableViewCell.labelAverageTemperature.text =
            homePageLandingImageTableViewCell.labelAverageTemperature.text! +
            SpecialCharacters.DEGREE_SIGN
        homePageLandingImageTableViewCell.backgroundColor = .clear
        
        //setupCell(searchPlaceTableViewCell: searchPlaceTableViewCell, indexPath: indexPath)
        
        return homePageLandingImageTableViewCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (self.view.frame.size.height - TABLE_VIEW_HEADER_HEIGHT )
    }
    
    /// Burron search for city location tapped
    func buttonSearchCityTapped() {
        let searchPlaceVC = StoryBoards.MAIN.instantiateViewController(withIdentifier: ViewControllersIds.SEARCH_PLACE_VC) as! SearchPlaceVC
        self.present(searchPlaceVC, animated: false, completion: nil)
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
    
    //loads meta data of photos for the place
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
