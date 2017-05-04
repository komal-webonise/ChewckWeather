//
//  HomePageVC.swift
//  WidgetPOC
//

import Foundation
import UIKit

class HomePageVC: UIViewController {
    
    @IBOutlet weak var tableViewMainPage: UITableView!
    
     let ESTIMATED_ROW_HEIGHT: CGFloat = 100
    
    //MARK: View cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
       
        initialUISetup()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //initial ui setup
    func initialUISetup() {
        //let imageView = UIImageView(image: UIImage(named: "background"))
        //tableViewMainPage.backgroundView = imageView
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
        return homePageHeaderView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
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
        return (self.view.frame.size.height - 44 )
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! SearchPlaceTableViewCell
        let selectedCity = cell.labelCity.text
        // print(selectedCity)
    }
    
    func setupCell(searchPlaceTableViewCell: SearchPlaceTableViewCell, indexPath: IndexPath) {
        //searchPlaceTableViewCell.labelCity.text =  arrayCityResults[indexPath.row]
    }
}
