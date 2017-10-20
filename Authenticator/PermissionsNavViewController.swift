//
//  PermissionsNavViewController.swift
//  Authenticator
//
//  Created by Raj Rao on 9/14/17.
//  Copyright © 2017 Salesforce. All rights reserved.
//

import UIKit
import SalesforceSDKCore

class PermissionsNavViewController: UINavigationController,SFSDKUserSelectionView {
   


    var permissionsController: PermissionsViewController
    
    var userSelectionDelegate :SFSDKUserSelectionViewDelegate?
    {
        set
        {
            permissionsController.userSelectionDelegate = newValue
        }
        get {
            return permissionsController.userSelectionDelegate
        }
    }
     var spAppOptions: [AnyHashable : Any]!
     {
        set
        {
            permissionsController.spAppOptions = newValue
        }
        get {
            return permissionsController.spAppOptions
        }
    }
    
    
//    var appName: String?
//    {
//        set
//        {
//            permissionsController.appName = newValue
//        }
//        get {
//            return permissionsController.appName
//        }
//    }
//    var appDescription: String?
//    {
//        set
//        {
//            permissionsController.appDescription = newValue
//        }
//        get {
//            return permissionsController.appDescription
//        }
//        
//    }
//    var appIdentifier: String?
//    {
//        set
//        {
//            permissionsController.appIdentifier = newValue
//        }
//        get {
//            return permissionsController.appIdentifier
//        }
//        
//    }
//    var callingAppCurrentUser: String?
//    {
//        set
//        {
//            permissionsController.callingAppCurrentUser = newValue
//        }
//        get {
//            return permissionsController.callingAppCurrentUser
//        }
//
//        
//    }
    
    init(){
        permissionsController  = PermissionsViewController(nibName: "PermissionsViewController", bundle: nil)
        super.init(nibName: nil, bundle: nil)
        
       // super.init(rootViewController: permissionsController)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.pushViewController(permissionsController, animated: true)
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
