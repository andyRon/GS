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

class UserDetailViewController: SwipeMenuViewController {
    
    var login:String?
    var userInfo: JSON?
    var following: JSON?
    
    var datas: [String] = ["Repositiories", "Following", "Follower"]
    
    var options = SwipeMenuViewOptions()
    var dataCount: Int = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
//        tableView.register(UINib.init(nibName: "FollowingOrFollowerCell", bundle: nil), forCellReuseIdentifier: "FollowingOrFollowerCell")
//        tableView.register(FollowingOrFollowerCell.self, forCellReuseIdentifier: "FollowingOrFollowerCell")
        
        let topView = Bundle.main.loadNibNamed("UserDetailTopView", owner: self, options: [:])?.last as! UserDetailTopView
        topView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 200)
        view.addSubview(topView)
        
        
        
        navigationItem.title = login
        var url = "https://api.github.com/users/\(login!)"
        Alamofire.request(url).validate().responseJSON { (response) in
            switch response.result {
            case .success(let value):
                self.userInfo = JSON(value)
                print(self.userInfo)
                let imageURL = URL(string: (self.userInfo?["avatar_url"].string!)!)
                topView.avatarView.kf.setImage(with: imageURL)
                topView.loginLabel.text = self.userInfo?["login"].string
                topView.nameLabel.text = self.userInfo?["name"].string
                topView.companyLabel.text = self.userInfo?["company"].string
                topView.createdLabel.text = self.userInfo?["created"].string
                topView.blogLabel.text = self.userInfo?["blog"].string
                topView.locationLabel.text = self.userInfo?["location"].string
//                self.tableView.reloadData()
            case .failure(let error):
                print(error)
                
            }
        }
        url = "https://api.github.com/users/\(login!)/following"
        Alamofire.request(url).validate().responseJSON { (response) in
            switch response.result {
            case .success(let value):
                self.following = JSON(value)
//                print(self.following)
            case .failure(let error):
                print(error)
                
            }
        }
        
        print(topView.frame.size.height)
        let downViewY:CGFloat =  200.0 + 10.0
        
        
        swipeMenuView = SwipeMenuView(frame: CGRect(x: 0, y: downViewY, width: view.frame.size.width, height: view.frame.size.height - downViewY))
        swipeMenuView.dataSource = self
        swipeMenuView.delegate = self
        view.addSubview(swipeMenuView)
        
    }

    
    // MARK: - SwipeMenuViewDelegate
    
    override func swipeMenuView(_ swipeMenuView: SwipeMenuView, viewWillSetupAt currentIndex: Int) {
//        print("will setup SwipeMenuView")
    }
    
    override func swipeMenuView(_ swipeMenuView: SwipeMenuView, viewDidSetupAt currentIndex: Int) {
//        print("did setup SwipeMenuView")
    }
    
    override func swipeMenuView(_ swipeMenuView: SwipeMenuView, willChangeIndexFrom fromIndex: Int, to toIndex: Int) {
//        print("will change from section\(fromIndex + 1)  to section\(toIndex + 1)")
    }
    
    override func swipeMenuView(_ swipeMenuView: SwipeMenuView, didChangeIndexFrom fromIndex: Int, to toIndex: Int) {
//        print("did change from section\(fromIndex + 1)  to section\(toIndex + 1)")
    }
    
    
    // MARK - SwipeMenuViewDataSource
    
    open override func numberOfPages(in swipeMenuView: SwipeMenuView) -> Int {
        return dataCount
    }
    
    override func swipeMenuView(_ swipeMenuView: SwipeMenuView, titleForPageAt index: Int) -> String {
        return datas[index]
    }
    
    override func swipeMenuView(_ swipeMenuView: SwipeMenuView, viewControllerForPageAt index: Int) -> UIViewController {
        let vc = ContentViewController()
        vc.content = datas[index]
        return vc
    }

    

}
