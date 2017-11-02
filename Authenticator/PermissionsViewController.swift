//
//  PermissionsViewController.swift
//  Authenticator
//
//  Created by Raj Rao on 9/14/17.
//  Copyright © 2017 Salesforce. All rights reserved.
//

import UIKit
import SalesforceSDKCore
import Kingfisher
class PermissionsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,SFSDKUserSelectionView{
 
    @IBOutlet weak var tableView: UITableView!
    let cellIdentifier = "mycell"
    
    var userList: [SFUserAccount] = []
    var userSelectionDelegate :SFSDKUserSelectionViewDelegate?
    
    var spAppOptions: [AnyHashable : Any]!
    @IBOutlet weak var infoTextView: UITextView!
    
    @IBAction func addUserAction(_ sender: Any) {
       userSelectionDelegate?.createNewUser(self.spAppOptions)
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        userSelectionDelegate?.cancel(self.spAppOptions)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let loginHost = spAppOptions["login_host"]
        if let host  = loginHost {
            userList = SFUserAccountManager.sharedInstance().userAccounts(forDomain: host as! String) as! [SFUserAccount];
        } else {
            userList = SFUserAccountManager.sharedInstance().allUserAccounts()!
        }
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = 80
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0, green: 0.439, blue: 0.824, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        
        self.title = "Login as"
        var appName:String = ""
        if (spAppOptions.index(forKey:"app_name") != nil) {
            appName = spAppOptions["app_name"] as! String
        }
        self.infoTextView.attributedText = self.getAttributedText(appName: appName)
        self.infoTextView.textAlignment = .center
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
        
        let result = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)  as! UserTableViewCell
        result.currentUserImage.isHidden = true;
        result.user = userList[indexPath.row]
        result.userFullName.text = userList[indexPath.row].fullName
        result.email.text = userList[indexPath.row].userName
       
        let image = UIImage(named: (userList[indexPath.row].idData?.firstName?.lowercased())!)
        
        if let img = image  {
           result.userPicture.image = img
        } else {
            result.userPicture.image = UIImage(named: "placeholder")
        }
       
        return result;
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        userSelectionDelegate?.selectedUser(userList[indexPath.row],spAppContext: self.spAppOptions)
    }
    
    func getAttributedText( appName:String ) ->  NSMutableAttributedString {
        let info = "Select user for \n";
    
        let plainAttribute = [NSForegroundColorAttributeName: UIColor.black, NSFontAttributeName: UIFont.systemFont(ofSize: 15)]
    
        let highlightAttribute = [NSForegroundColorAttributeName: UIColor.salesforceBlue(), NSFontAttributeName: UIFont.systemFont(ofSize: 18)]
     
        let partOne = NSMutableAttributedString(string: info, attributes: plainAttribute)
        let partTwo = NSMutableAttributedString(string: appName, attributes: highlightAttribute)
        
        
        
//         let partThree = NSMutableAttributedString(string: " app.", attributes: plainAttribute)
    
        let combination = NSMutableAttributedString()
    
        combination.append(partOne)
        combination.append(partTwo)
        //combination.append(partThree)
        return combination
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


