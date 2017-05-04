//
//  ViewController.swift
//  WidgetPOC
//
//  Created by komal lunkad on 24/04/17.
//  Copyright © 2017 komal lunkad. All rights reserved.
//

import UIKit
import GooglePlaces

class ViewController: UIViewController {

    @IBOutlet weak var textFieldData: UITextField!
    
    let GOOGLE_PLACES_KEY = "AIzaSyA6A5dFcuT8wPGugEEPe0aUBet0g2ulmjg"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonSubmitTapped(_ sender: Any) {
//        let data = textFieldData.text
//        let defaults = UserDefaults(suiteName: "group.WidgetPOCGroup")
//        defaults?.set(data, forKey: "data")
//        defaults?.synchronize()
        //UserDefaults.standard.setValue(data, forKey: "data")
        
        let acController = GMSAutocompleteViewController()
        let filter = GMSAutocompleteFilter()
        filter.type = .city
        acController.autocompleteFilter = filter
        acController.delegate = self
        present(acController, animated: true, completion: nil)
    }

}


extension ViewController: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        print("Place name: \(place.name)")
        print("Place address: \(place.formattedAddress)")
        print("Place attributions: \(place.attributions)")
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: \(error)")
        dismiss(animated: true, completion: nil)
    }
    
    // User cancelled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        print("Autocomplete was cancelled.")
        dismiss(animated: true, completion: nil)
    }
}
