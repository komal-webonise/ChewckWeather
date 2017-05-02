//
//  ViewController.swift
//  WidgetPOC
//
//  Created by komal lunkad on 24/04/17.
//  Copyright © 2017 komal lunkad. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textFieldData: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonSubmitTapped(_ sender: Any) {
        let data = textFieldData.text
        let defaults = UserDefaults(suiteName: "group.WidgetPOCGroup")
        defaults?.set(data, forKey: "data")
        defaults?.synchronize()
        //UserDefaults.standard.setValue(data, forKey: "data")
    }

}

