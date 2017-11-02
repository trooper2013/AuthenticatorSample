//
//  MainViewController.swift
//  Authenticator
//
//  Created by Raj Rao on 9/9/17.
//  Copyright © 2017 Salesforce. All rights reserved.
//

import UIKit
import WYPopoverController
import SalesforceSDKCore
class MainViewController: UINavigationController {
    
    var popOverController:WYPopoverController?
    @IBOutlet weak var showPopoverButton: UIBarButtonItem!


    @IBAction func popOverAction(_ sender: UIBarButtonItem) {
        let popOverContent = ActionsPopoverTableViewController(nibName: nil, bundle: nil)
        popOverContent.delegate = self
        popOverContent.preferredContentSize = CGSize(width: 260, height: 90)
        self.popOverController = WYPopoverController(contentViewController: popOverContent)
        self.popOverController?.presentPopover(from: sender, permittedArrowDirections: .any, animated: true)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Load each of the view controllers you want to embed
        // from the storyboard.
//        let storyboard = UIStoryboard(name: "AuthenticatorMain", bundle: nil)
//        storyboard.instantiateInitialViewController()
    }
    
    func showOtherActions(sender: UIBarButtonItem){
        
    }


}

extension MainViewController : ActionsPopoverTableViewDelegate {

    func logoutAllUsersSelected(sender: ActionsPopoverTableViewController) {
        popOverController?.dismissPopover(animated: true)
        showLogoutActionSheet()
    }

    func switchUserSelected(sender: ActionsPopoverTableViewController) {
        popOverController?.dismissPopover(animated: true)
        showSwitchUserSheet()
    }

    func showLogoutActionSheet() {

        let alert = UIAlertController(title: "Logout", message: "Are you sure you want to log out?", preferredStyle: .alert)

        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) { (result : UIAlertAction) -> Void in
            print("Cancel")
        }

        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
           SFUserAccountManager.sharedInstance().logoutAllUsers()
        }

        alert.addAction(cancelAction)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showErrorActionSheet() {
        
        let alert = UIAlertController(title: "Error", message: "Error adding a User", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
            SFUserAccountManager.sharedInstance().logoutAllUsers()
        }
        
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }

    func showSwitchUserSheet() {
        SFUserAccountManager.sharedInstance().login(completion: { (authInfo, account) in
            
        }) { (authInfo, error) in
            
        }
    }

}

