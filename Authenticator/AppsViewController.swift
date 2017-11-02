//
//  AppsViewController.swift
//  Authenticator
//
//  Created by Raj Rao on 9/11/17.
//  Copyright © 2017 Salesforce. All rights reserved.
//

import UIKit
import SalesforceSDKCore
class AppsViewController: UIViewController {

    @IBOutlet weak var appOneButton: UIButton!

    @IBOutlet weak var appTwoButton: UIButton!
    
    @IBAction func toolBarAction(_ sender: Any) {
       let controller =  self.navigationController as! MainViewController
       controller.popOverAction(sender as! UIBarButtonItem)
    }
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBAction func appOneButtonAction(_ sender: Any) {
        launchSPApp(appUrl: readAppOneUrl())
    }
    
    @IBAction func appTwoButtonAction(_ sender: Any) {
        launchSPApp(appUrl: readAppTwoUrl())
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.messageLabel.text = "The Following apps will be launched in the context of user [" + (SFUserAccountManager.sharedInstance().currentUser?.fullName)!+"]";

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func launchSPApp(appUrl :String) {
        let userAccount = SFUserAccountManager.sharedInstance().currentUser
        let userHint =  (userAccount?.accountIdentity.userId)! + ":" + (userAccount?.accountIdentity.orgId)!
        let urlString = appUrl + "://oauth2/v1.0/idpinit?user_hint=" + userHint + "&login_host=" + (userAccount?.credentials.domain)!
        let url = URL(string: urlString)
        SFApplicationHelper.open(url!)
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
