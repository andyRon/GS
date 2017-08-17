//
//  GithubAPI.swift
//  GS
//
//  Created by andyron on 2017/8/17.
//  Copyright © 2017年 andyron. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

enum Order: String {
    case asc = "asc"
    case desc = "desc"
}

enum Sort: String {
    case followers = "followers"
    case repositories = "repositories"
}

class GithubAPI: NSObject {
    
    var users = [UserModel]()
    
    
    let searchUsersUrl = "https://api.github.com/search/users"
    
    func searchUsers(q: String, sort: Sort = .followers, order: Order = .desc, page: Float = 1) {
        let url = "\(searchUsersUrl)?q=\(q)&sort=\(sort.rawValue)&order=\(order.rawValue)&page=\(page)"
            
//            searchUsersUrl + "?q=" + q + "&sort=" + sort.rawValue + "&order=" + order.rawValue + "&page=" + page
        Alamofire.request(url).validate().responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let items = json["items"] as JSON
                for (index,e):(String, JSON) in items {
                    print(e["id"])
                    let userModel = UserModel()
                    userModel.login = e["login"].string
                    userModel.id = e["id"].int
                    userModel.avatar_url = e["avatar_url"].string
                    userModel.gravatar_id = e["gravatar_id"].string!
                    self.users.append(userModel)
                }
                
            case .failure(let error):
                print(error)
                
            }
        }
        
        
        
    }
    
//    private func makeUrl()
}
