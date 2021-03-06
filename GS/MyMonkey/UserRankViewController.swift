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

    @IBOutlet var cityButton: UIButton!
    @IBOutlet var countryButton: UIButton!
    @IBOutlet var totalLabel: UILabel!

    var datas = [JSON]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        navigationItem.title = "所有语言"
        let url = "https://api.github.com/search/users?q=location:china&sort=followers&page=2"
        Alamofire.request(url).validate().responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let josn = JSON(value)
                self.datas = josn["items"].arrayValue
                self.totalLabel.text = "total:\(josn["total_count"].int!)"
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! UserRankTableViewCell

        // Configure the cell...
        cell.numberLabel.text = "\(indexPath.row + 1)"
        cell.loginLabel.text = datas[indexPath.row]["login"].string
        
        let imageURL = URL(string: datas[indexPath.row]["avatar_url"].string!)
        cell.imageView?.kf.indicatorType = .activity
        cell.imageView?.kf.setImage(with: imageURL)
        cell.imageView?.layer.cornerRadius = 5

        return cell
    }
    
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
