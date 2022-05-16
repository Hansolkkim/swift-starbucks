//
//  HomeViewController.swift
//  StarbucksClone
//
//  Created by 김한솔 on 2022/05/13.
//

import UIKit

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = UIView(frame: view.bounds)
        self.view.backgroundColor = .white
    }
    
    static func create() -> UINavigationController {
        let home = ViewControllerComponents(viewController: HomeViewController(), title: "Home", icon: UIImage(systemName: "house") ?? UIImage())
        let pay = ViewControllerComponents(viewController: HomeViewController(), title: "Pay", icon: UIImage(systemName: "creditcard") ?? UIImage())
        let order = ViewControllerComponents(viewController: HomeViewController(), title: "Order", icon: UIImage(systemName: "cup.and.saucer") ?? UIImage())
        let favorite = ViewControllerComponents(viewController: HomeViewController(), title: "Favorite", icon: UIImage(systemName: "star") ?? UIImage())
        
        let viewControllers: [ViewControllerComponents] = [home, pay, order, favorite]
        let navigationController = UINavigationController()
        let tabBarController = UITabBarController()
        
        for (index, component) in viewControllers.enumerated(){
            tabBarController.addChild(component.viewController)
            component.viewController.tabBarItem = UITabBarItem(title: component.title, image: component.icon, tag: index)
        }
        
        navigationController.modalPresentationStyle = .fullScreen
        navigationController.pushViewController(tabBarController, animated: true)
        return navigationController
    }
}
