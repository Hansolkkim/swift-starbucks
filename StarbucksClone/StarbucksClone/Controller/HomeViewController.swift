//
//  HomeViewController.swift
//  StarbucksClone
//
//  Created by 김한솔 on 2022/05/13.
//

import UIKit

final class HomeViewController: UIViewController, DependencySettable {
    typealias DependencyType = HomeDependency

    var dependency: DependencyType? {
        didSet {
            self.homeManagable = dependency?.manager
        }
    }
    private lazy var homeView = HomeView(frame: view.frame)
    private let dataSource = RecommendCollectionDataSource()
    private let homeScrollDelegate = HomeScrollViewDelegate()
    private let eventDataSource = HomeEventCollectionDataSource()
    private var homeManagable: HomeManagable?

    init() {
        super.init(nibName: nil, bundle: nil)
        DependencyInjector.inject(to: self)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        DependencyInjector.inject(to: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = homeView
        setNavigationCustomTitle()
        homeManagable?.setDelegate(delegate: self)
        homeView.setRecommendCollectionDatasource(dataSource: dataSource)
        homeView.setHomeEventCollectionDataSource(dataSource: eventDataSource)
        homeManagable?.getHomeComponentsData()
        homeScrollDelegate.delegate = self
        homeView.scrollView.delegate = homeScrollDelegate
        homeView.action = self
    }

    func setDependency(_ dependency: HomeDependency) {
        self.dependency = dependency
    }

    private func setNavigationCustomTitle(){
        guard let navigationBarFrame = navigationController?.navigationBar.frame else { return }
        let titleView = WhatsNewTitleView(frame: navigationBarFrame)
        self.navigationController?.navigationBar.addSubview(titleView)
        self.navigationController?.navigationBar.barTintColor = .white
    }
    
    private func setRecommendCollectionData(product: ProductDescription){
        dataSource.recommends.append(product)
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.homeView.recommandCollectionView.insertItems(at: [IndexPath(item: self.dataSource.recommends.count - 1, section: 0)])
        }
    }

    private func setHomeEventCollectionData(event: HomeEventDescription) {
        eventDataSource.events.append(event)
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.homeView.homeEventCollectionView.insertItems(at: [IndexPath(item: self.eventDataSource.events.count - 1, section: 0)])
        }
    }
}

extension HomeViewController: HomeUseCaseDelegate {
    func updateUserNickname(_ nickName: String) {
        homeView.setNickNameLabel(title: nickName)
    }
    
    func updateBeverage(product: ProductDescription) {
        setRecommendCollectionData(product: product)
    }
    
    func updateHomeComponents(_ components: HomeComponents) {
        
    }
    
    func updateMainEventImageData(data: Data) {
        homeView.updateImageView(data: data)
    }

    func updateEvent(_ event: HomeEventDescription) {
        setHomeEventCollectionData(event: event)
    }
}

extension HomeViewController: HomeScrollActionDeleagte {
    func scrollMoveUp() {
        UIView.animate(withDuration: 0.3) {
            self.homeView.unfoldingDelivaryView()
            self.homeView.layoutIfNeeded()
        }
    }
    
    func scrollMoveDown() {
        UIView.animate(withDuration: 0.3) {
            self.homeView.foldingDelivaryView()
            self.homeView.layoutIfNeeded()
        }
    }
}

extension HomeViewController {
    static func create() -> UINavigationController {
        let home = ViewControllerComponents(viewController: HomeViewController(), title: "Home", icon: UIImage(systemName: "house.fill") ?? UIImage())
        let pay = ViewControllerComponents(viewController: HomeViewController(), title: "Pay", icon: UIImage(systemName: "creditcard.fill") ?? UIImage())
        let order = ViewControllerComponents(viewController: HomeViewController(), title: "Order", icon: UIImage(systemName: "cup.and.saucer.fill") ?? UIImage())
        let favorite = ViewControllerComponents(viewController: HomeViewController(), title: "Favorite", icon: UIImage(systemName: "star.fill") ?? UIImage())
        
        let viewControllers: [ViewControllerComponents] = [home, pay, order, favorite]
        let navigationController = UINavigationController()
        let tabBarController = UITabBarController()
        
        for (index, component) in viewControllers.enumerated(){
            tabBarController.addChild(component.viewController)
            component.viewController.tabBarItem = UITabBarItem(title: component.title, image: component.icon, tag: index)
        }
        tabBarController.view.tintColor = .starbuckstButtonGreen
        navigationController.modalPresentationStyle = .overFullScreen
        navigationController.pushViewController(tabBarController, animated: true)
        return navigationController
    }
}

extension HomeViewController: HomeViewAction {
    func userDidInput(_ input: HomeView.UserAction) {
        if input == .whatsNewButtonTapped {
            present(WhatsNewViewController(), animated: true, completion: nil)
        }
    }
}
