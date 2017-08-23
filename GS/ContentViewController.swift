//
//  ContentViewController.swift
//  SwipeMenuViewControllerDemo
//
//  Created by andyron on 2017/8/23.
//  Copyright © 2017年 andyron. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {
    
    var contentLabel: UILabel! {
        didSet {
            contentLabel.textColor = .black
            contentLabel.textAlignment = .center
            contentLabel.font = UIFont.boldSystemFont(ofSize: 25)
            contentLabel.text = content
            view.addSubview(contentLabel)
            
            contentLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                contentLabel.topAnchor.constraint(equalTo: self.view.topAnchor),
                contentLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor),
                contentLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                contentLabel.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
                ])
        }
    }
    
    var content: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        contentLabel = UILabel(frame: CGRect(x: 0, y: view.center.y - 50, width: view.frame.width, height: 50))
    }
}
