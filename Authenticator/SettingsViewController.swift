//
//  SettingsViewController.swift
//  Authenticator
//
//  Created by Raj Rao on 9/11/17.
//  Copyright © 2017 Salesforce. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var appOneURLTextView: UITextView!

    @IBOutlet weak var appTwoURLTextView: UITextView!
    
    @IBAction func applyChanges(_ sender: Any) {
        writeStringToDefaults(key:app_one_key, value: appOneURLTextView.text)
        writeStringToDefaults(key:app_two_key, value: appTwoURLTextView.text)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appOneURLTextView.text = readAppOneUrl()
        appTwoURLTextView.text = readAppTwoUrl()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
