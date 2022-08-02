//
//  TabBarController.swift
//  magic-ios
//
//  Created by matheus.coutinho on 02/08/22.
//

import UIKit
import MTGSDKSwift

class TabBarController: UITabBarController {
    
    private let expansionsList: UINavigationController = {
        let viewModel = ExpansionCardsViewModel(parameters: [], setName: "KTK")
        let viewController = ExpansionCardsViewController(viewModel: viewModel)
        
        let appearance = UITabBarItemAppearance()
        
        let tabBarItem = UITabBarItem(title: "Expansões", image: nil, selectedImage: nil)
        tabBarItem.badgeColor = .white
        tabBarItem.setTitleTextAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16, weight: .bold)], for: .normal)
        
        let navigation = UINavigationController(rootViewController: viewController)
        navigation.tabBarItem = tabBarItem
        return navigation
    }()
    
    private let favoritesList: UINavigationController = {
        let viewModel = FavoritesCardsViewModel(magic: Magic())
        let view = FavoritesCardViewController(viewModel: viewModel)
        
        let tabBarItem = UITabBarItem(title: "Favoritos", image: nil, selectedImage: nil)
        tabBarItem.setTitleTextAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16, weight: .bold)], for: .normal)

        let navigation = UINavigationController(rootViewController: view)
        navigation.tabBarItem = tabBarItem
        return navigation
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configTabBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.viewControllers = [expansionsList, favoritesList]
    }
    
    private func configTabBar() {
        self.delegate = self
        self.tabBar.barTintColor = .white
        self.tabBar.tintColor = .white
        self.tabBar.backgroundColor = .black.withAlphaComponent(0.5)
        
        self.tabBar.addTopBorder(with: .white, andWidth: 2)
    }
}

extension TabBarController: UITabBarControllerDelegate {
    
}
