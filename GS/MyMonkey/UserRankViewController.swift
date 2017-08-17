//
//  UserRankViewController.swift
//  MyMonkey
//
//  Created by andyron on 2017/8/17.
//  Copyright © 2017年 andyron. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class UserRankViewController: UITableViewController {

    var datas = [JSON]()
    override func viewDidLoad() {
        super.viewDidLoad()

//        let g = GithubAPI()
//        g.searchUsers(q: "location:china")
//        self.datas = g.users
//        tableView.reloadData()
        
        navigationItem.title = "所有语言"
        let url = "https://api.github.com/search/users?q=location:china&sort=followers&page=2"
        Alamofire.request(url).validate().responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let josn = JSON(value)
                self.datas = josn["items"].arrayValue
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
                
            }
        }
        
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return datas.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = datas[indexPath.row]["login"].string
        
        let imageURL = URL(string: datas[indexPath.row]["avatar_url"].string!)
        cell.imageView?.kf.setImage(with: imageURL)

        return cell
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showUserDetail", let indexPath = tableView.indexPathForSelectedRow {
            let destinationViewController = segue.destination as! UserDetailViewController
            destinationViewController.login = datas[indexPath.row]["login"].string
        }
        
    }
    

}
