//
//  MyTabBarController.swift
//  HomeWork 11
//
//  Created by Влад Бокин on 01.10.2021.
//

import UIKit

class MyTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBar.unselectedItemTintColor = .gray
        self.tabBar.tintColor = .orange


    }

  

}
