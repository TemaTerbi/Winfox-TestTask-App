//
//  TabBarViewController.swift
//  WinfoxTestTaskApp
//
//  Created by TeRb1 on 26.08.2022.
//

import UIKit
import SnapKit

final class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createTabBar()
    }
    
    private func createTabBar() {
        let listVc = HomeScreenViewController()
        let mapVc = MapViewController()
        let exitVc = ExitViewController()
        
        //title for tabbar
        listVc.title = "Список заведений"
        mapVc.title = "Карта"
        exitVc.title = "Выйти"
        
        //image for tabbar
        listVc.tabBarItem.image = UIImage(systemName: "list.bullet.rectangle.portrait")
        listVc.tabBarItem.selectedImage = UIImage(systemName: "list.bullet.rectangle.portrait.fill")
        
        mapVc.tabBarItem.image = UIImage(systemName: "map")
        mapVc.tabBarItem.selectedImage = UIImage(systemName: "map.fill")
        
        exitVc.tabBarItem.image = UIImage(systemName: "delete.left")
        exitVc.tabBarItem.selectedImage = UIImage(systemName: "delete.left.fill")
        
        let viewControllers = [
            mapVc,
            listVc,
            exitVc
        ]
        
        self.setViewControllers(viewControllers, animated: true)
        
        tabBar.tintColor = .systemIndigo
        tabBar.backgroundColor = .white
        tabBar.unselectedItemTintColor = .systemGray3
    }
}
