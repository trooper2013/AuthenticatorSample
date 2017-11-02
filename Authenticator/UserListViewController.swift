//
//  UserListViewController.swift
//  Authenticator
//
//  Created by Raj Rao on 9/10/17.
//  Copyright © 2017 Salesforce. All rights reserved.
//

import UIKit
import SalesforceSDKCore
import SwipeCellKit
import Kingfisher
class UserListViewController: UITableViewController,UserTableViewCellDelegate, SwipeTableViewCellDelegate {
    
    struct LoginHostAccount {
        var hostName: String
        var userAccount: SFUserAccount
    }
    
    let cellIdentifier = "mycell"
    var groups : Dictionary<String, Array<LoginHostAccount>>?
    var groupIds : [String] = []
   
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @IBAction func toolbarItemAction(_ sender: Any) {
        let controller =  self.navigationController as! MainViewController
        controller.popOverAction(sender as! UIBarButtonItem)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleUserDidLogin(notification:)), name:NSNotification.Name(rawValue: kSFNotificationUserDidLogIn) , object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleUserDidLogout(notification:)), name:NSNotification.Name(rawValue: kSFNotificationUserDidLogout) , object: nil)
        
        self.tableView.rowHeight = 80
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "UserTableViewCell", bundle: bundle)
        self.tableView.register(nib, forCellReuseIdentifier: cellIdentifier)
        self.tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "headerfooterview")
        self.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    func reloadData(){
        let userAccountLists = SFUserAccountManager.sharedInstance().allUserAccounts()!
        var userAccounts: [LoginHostAccount] = []
        groups?.removeAll()
        groupIds.removeAll()
        userAccountLists.forEach { (account) in
            userAccounts.append(LoginHostAccount(hostName: account.credentials.domain!, userAccount: account))
        }
        self.groups = userAccounts.groupBy{$0.hostName}
        self.groups?.keys.forEach({ (groupName) in
            groupIds.append(groupName)
        })
        //userAccounts = SFUserAccountManager.sharedInstance().allUserAccounts()!
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return groupIds.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let userAccounts = self.groups![groupIds[section]]
        return  userAccounts!.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let result = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! UserTableViewCell
        
        let userAccounts = self.groups![groupIds[indexPath.section]]
        
        if( SFUserAccountManager.sharedInstance().currentUser?
            .accountIdentity.isEqual(userAccounts![indexPath.row].userAccount.accountIdentity))! {
            result.currentUserImage.isHidden = false;
        } else {
            result.currentUserImage.isHidden = true;
        }
        result.tableDelegate = self
        result.delegate = self;
        result.user = userAccounts?[indexPath.row].userAccount
        result.userFullName.text = userAccounts?[indexPath.row].userAccount.fullName
        result.email.text = userAccounts?[indexPath.row].userAccount.userName
        let imageName = userAccounts?[indexPath.row].userAccount.idData?.firstName?.lowercased()
        result.userPicture.image = UIImage(named: imageName!)
       
        let image = UIImage(named: imageName!)
        
        if let img = image  {
            result.userPicture.image = img
        } else {
            result.userPicture.image = UIImage(named: "placeholder")
        }
        
        
        return result
    }
    
    func logoutUser(user: SFUserAccount) {
        SFUserAccountManager.sharedInstance().logoutUser(user)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        var action:SwipeAction?
        let userAccounts = self.groups![groupIds[indexPath.section]]
       
        if (orientation == .right) {
            action = SwipeAction(style: .destructive, title: "Logout") { action, indexPath in
                self.logoutUser(user: (userAccounts?[indexPath.row].userAccount)!)
                self.reloadData()
                // handle action by updating model with deletion
            }
            // customize the action appearance
            action?.image = UIImage(named: "Logout")
        } else {
            action = SwipeAction(style: .default, title: "Make Current") { action, indexPath in
                SFUserAccountManager.sharedInstance().switch(toUser: userAccounts?[indexPath.row].userAccount);
                self.reloadData()
            }
            action?.backgroundColor = UIColor(red: 94/255, green: 232/255, blue: 9/255, alpha: 1.0)
            // customize the action appearance
            action?.image = UIImage(named: "Current")
        }
        return [action!]
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerLabel  = groupIds[section]
        let headerFooterView = UITableViewHeaderFooterView(reuseIdentifier: "headerfooterview")
        headerFooterView.textLabel?.text = headerLabel
        headerFooterView.textLabel?.textColor = UIColor.black
        return headerFooterView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func handleUserDidLogout( notification : Notification ) {
        self.reloadData()
    }
    
    func handleUserDidLogin( notification : Notification ) {
        self.reloadData()
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
