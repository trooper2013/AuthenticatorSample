//
//  UserTableViewCell.swift
//  Authenticator
//
//  Created by Raj Rao on 9/11/17.
//  Copyright © 2017 Salesforce. All rights reserved.
//

import UIKit
import SalesforceSDKCore
import SwipeCellKit
import Kingfisher
protocol UserTableViewCellDelegate {
    func logoutUser(user: SFUserAccount)
}

class UserTableViewCell: SwipeTableViewCell {
    
    var tableDelegate : UserTableViewCellDelegate?
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var userFullName: UILabel!
    var user: SFUserAccount?
    
    @IBOutlet weak var currentUserImage: UIImageView!
    @IBOutlet weak var userPicture: UIImageView!
    @IBAction func logoutUserAction(_ sender: Any) {
        tableDelegate?.logoutUser(user: self.user!)
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
