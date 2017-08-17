//
//  UserDetailViewController.swift
//  MyMonkey
//
//  Created by andyron on 2017/8/17.
//  Copyright © 2017年 andyron. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher
import SwiftyJSON

class UserDetailViewController: UIViewController {

    @IBOutlet var avatarView: UIImageView!
    @IBOutlet var loginLabel: UILabel!
    
    var login:String?
    var userInfo: JSON?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = login
        let url = "https://api.github.com/users/\(login!)"
        Alamofire.request(url).validate().responseJSON { (response) in
            switch response.result {
            case .success(let value):
                self.userInfo = JSON(value)
                print(self.userInfo)
                let imageURL = URL(string: (self.userInfo?["avatar_url"].string!)!)
                self.avatarView.kf.setImage(with: imageURL)
                self.loginLabel.text = self.userInfo?["login"].string
//                self.tableView.reloadData()
            case .failure(let error):
                print(error)
                
            }
        }
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
