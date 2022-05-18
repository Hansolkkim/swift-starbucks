//
//  HomeViewController.swift
//  StarbucksClone
//
//  Created by 김한솔 on 2022/05/13.
//

import UIKit

final class HomeViewController: UIViewController {
    
    private lazy var homeView = HomeView(frame: view.frame)
    private let dataSource = RecommendCollectionDataSource()
    private var homeManagable: HomeManagable? = HomeUseCase(homeComponentsDataGettable: HomeRepository(homeService: HomeService()))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = homeView
        setNavigationCustomTitle()
        homeView.setRecommendCollectionDatasource(dataSource: dataSource)
        setRecommendCollectionData()
        homeManagable?.getHomeComponentsData(completion: {result in
            print(result)
        })
    }
    
    private func setNavigationCustomTitle(){
        guard let navigationBarFrame = navigationController?.navigationBar.frame else { return }
        let titleView = WhatsNewTitleView(frame: navigationBarFrame)
        self.navigationController?.navigationBar.addSubview(titleView)
        self.navigationController?.navigationBar.barTintColor = .white
    }
    
    private func setRecommendCollectionData(){
        var products: [RecommendDTO?] = []
        for i in 0 ..< 10{
            let dto = RecommendDTO(title: "gucci \(i)", imageURL: "gucci")
            products.append(dto)
        }
        dataSource.recommends = [RecommendDTO?].init(repeating: nil, count: products.count)
        dataSource.recommends = products
        DispatchQueue.main.async { [weak self] in
            self?.homeView.recommandCollectionView.reloadData()
        }
    }
}

extension HomeViewController {
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
