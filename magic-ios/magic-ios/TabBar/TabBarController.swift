//
//  TabBarController.swift
//  magic-ios
//
//  Created by matheus.coutinho on 02/08/22.
//

import UIKit
import MTGSDKSwift

class TabBarController: UITabBarController {
    
    private let expansionsList: ExpansionCardsViewController = {
        let viewModel = ExpansionCardsViewModel(parameter: CardSearchParameter(parameterType: .colors, value: "green"))
        let viewController = ExpansionCardsViewController(viewModel: viewModel)
        let tabBarItem = UITabBarItem(title: "Expansões", image: nil, selectedImage: nil)
        tabBarItem.badgeColor = .white
        viewController.tabBarItem = tabBarItem
        return viewController
    }()
    
    private let favoritesList: FavoritesCardViewController = {
        let viewModel = FavoritesCardsViewModel(magic: Magic())
        let view = FavoritesCardViewController(viewModel: viewModel)
        view.tabBarItem = UITabBarItem(title: "Favoritos", image: nil, selectedImage: nil)
        return view
    }()
    
//    private let appearance: UITabBarAppearance = {
//        let appearance = UITabBarAppearance()
//    }()

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
