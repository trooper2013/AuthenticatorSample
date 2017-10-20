//
//  PermissionsViewController.swift
//  Authenticator
//
//  Created by Raj Rao on 9/14/17.
//  Copyright © 2017 Salesforce. All rights reserved.
//

import UIKit
import SalesforceSDKCore
class PermissionsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,SFSDKUserSelectionView{
//    @IBOutlet weak var requestMessageLabel: UILabel!
//
//    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var tableView: UITableView!
    let cellIdentifier = "mycell"
    
    var userList: [SFUserAccount] = []
    var userSelectionDelegate :SFSDKUserSelectionViewDelegate?
    
    var spAppOptions: [AnyHashable : Any]!
//    var appName: String?
//    var appDescription: String?
//    var appIdentifier: String?
//    var callingAppCurrentUser: String?
    
    @IBAction func addUserAction(_ sender: Any) {
       userSelectionDelegate?.createNewUser(self.spAppOptions)
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        userSelectionDelegate?.cancel(self.spAppOptions)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userList = SFUserAccountManager.sharedInstance().allUserAccounts()!
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = 80
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0, green: 0.439, blue: 0.824, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        
        self.title = "Select User"
//        let appName:String = spAppOptions["app_name"] as! String
//        self.requestMessageLabel.text = appName.removingPercentEncoding! + " is requesting access."
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "UserTableViewCell", bundle: bundle)
        self.tableView.register(nib, forCellReuseIdentifier: cellIdentifier)
    
        self.view.addSubview(self.tableView)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (self.userList.count)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let result = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! UserTableViewCell
        
        result.currentLabel.isHidden = true;
        result.logoutButton.isHidden = true;
        //result.delegate = self
        result.user = userList[indexPath.row]
        result.userFullName.text = userList[indexPath.row].fullName
        result.email.text = userList[indexPath.row].email
        result.domain.text = userList[indexPath.row].apiUrl.absoluteString
//        let cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
//        
//        
//        let result = cell ?? UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
//        
//        result.textLabel?.text = userList?[indexPath.row].fullName
//        result.detailTextLabel?.text = userList?[indexPath.row*2].email
        return result;
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        userSelectionDelegate?.selectedUser(userList[indexPath.row],spAppContext: self.spAppOptions)
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
