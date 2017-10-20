//
//  UserTableViewCell.swift
//  Authenticator
//
//  Created by Raj Rao on 9/11/17.
//  Copyright © 2017 Salesforce. All rights reserved.
//

import UIKit
import SalesforceSDKCore

protocol UserTableViewCellDelegate {
    func logoutUser(user: SFUserAccount)
}

class UserTableViewCell: UITableViewCell {
    
    var delegate : UserTableViewCellDelegate?
    
    @IBOutlet weak var currentLabel: UILabel!
    @IBOutlet weak var domain: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var userFullName: UILabel!
   
    @IBOutlet weak var logoutButton: UIButton!
    
    var user: SFUserAccount?
    
    @IBAction func logoutUserAction(_ sender: Any) {
        delegate?.logoutUser(user: self.user!)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
}
