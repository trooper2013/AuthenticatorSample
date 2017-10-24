//
//  MainViewController.swift
//  Authenticator
//
//  Created by Raj Rao on 9/9/17.
//  Copyright © 2017 Salesforce. All rights reserved.
//

import UIKit
import Parchment
import WYPopoverController
import SalesforceSDKCore
class MainViewController: UINavigationController {
    
    var popOverController:WYPopoverController?
    @IBOutlet weak var showPopoverButton: UIBarButtonItem!
    
    
    @IBAction func popOverAction(_ sender: Any) {
        let popOverContent = ActionsPopoverTableViewController(nibName: nil, bundle: nil)
        popOverContent.delegate = self
        popOverContent.preferredContentSize = CGSize(width: 260, height: 130)
        self.popOverController = WYPopoverController(contentViewController: popOverContent)
        self.popOverController?.presentPopover(from: showPopoverButton, permittedArrowDirections: .any, animated: true)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Load each of the view controllers you want to embed
        // from the storyboard.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let usersViewController = storyboard.instantiateViewController(withIdentifier: "Users")
        let appsViewController = storyboard.instantiateViewController(withIdentifier: "Apps")
        
        // Initialize a FixedPagingViewController and pass
        // in the view controllers.
        let pagingViewController = FixedPagingViewController(viewControllers: [
            usersViewController,
            appsViewController
            ])
        // Make sure you add the PagingViewController as a child view
        // controller and contrain it to the edges of the view.
        addChildViewController(pagingViewController)
        view.addSubview(pagingViewController.view)
        view.constrainToEdges(pagingViewController.view)
        pagingViewController.didMove(toParentViewController: self)
        
    }
    
    func showOtherActions(sender: UIBarButtonItem){
        
    }


}

extension MainViewController : ActionsPopoverTableViewDelegate {
    
    func logoutUserSelected(sender: ActionsPopoverTableViewController) {
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
           SFUserAccountManager.sharedInstance().logout()
        }
        
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showSwitchUserSheet() {
        let userManagementViewController = SFDefaultUserManagementViewController { (action: SFUserManagementAction) in
            self.dismiss(animated: true, completion: {
                
            })
        }
        self.present(userManagementViewController, animated: true) { 
            
        }
        
    }
    
}
