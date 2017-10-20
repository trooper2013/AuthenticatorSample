//
//  ActionsPopoverTableViewController.swift
//  Authenticator
//
//  Created by Raj Rao on 9/10/17.
//  Copyright © 2017 Salesforce. All rights reserved.
//

import UIKit

protocol ActionsPopoverTableViewDelegate {
    
    func switchUserSelected(sender: ActionsPopoverTableViewController)
    
    func logoutUserSelected(sender: ActionsPopoverTableViewController)
    
}

class ActionsPopoverTableViewController: UITableViewController {
    
    let cellIdentifier = "ACELL"
    let actions = ["Switch User","Bring up user switching screen",
                   "Logout","Logout Current User", "Logout All Users","Logout All Users"]
    
    
    var delegate: ActionsPopoverTableViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return actions.count/2
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)

        
        let result = cell ?? UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
        
        result.textLabel?.text = actions[indexPath.row*2]
        result.detailTextLabel?.text = actions[indexPath.row*2+1]
        
        return result;
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            self.delegate?.switchUserSelected(sender: self)
            break
        case 1:
            self.delegate?.logoutUserSelected(sender: self)
            break
        case 2:
            self.delegate?.logoutUserSelected(sender: self)
            break
        default:
            print("Selected table");
        }
        
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
