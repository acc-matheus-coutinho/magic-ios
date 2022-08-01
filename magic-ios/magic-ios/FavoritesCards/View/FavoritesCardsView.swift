//
//  FavoritesCardsView.swift
//  magic-ios
//
//  Created by  on /07/22.
//

import UIKit
import SnapKit
import MTGSDKSwift

class FavoritesCardViewController: UIViewController {
    
    // MARK: - Private variables
    
    var viewModel: FavoritesCardsViewModel
    
    // MARK: - UI Elements
    
    private let backgroundImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "background")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.barStyle = UIBarStyle.black
        searchController.searchBar.barTintColor = .white
        searchController.searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string:"Search for favorites", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white] )
        searchController.searchBar.searchTextField.tintColor = .white
        searchController.searchBar.searchTextField.borderStyle = .line
        searchController.searchBar.tintColor = .white
        searchController.searchBar.searchTextField.tokenBackgroundColor = .white
        searchController.searchBar.searchTextField.backgroundColor = .clear
        return searchController
    }()
    

    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    public init(viewModel: FavoritesCardsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cyclep
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupConstraints()
        setupCollectionView()
        bindViewModel()
    }
    
    // MARK: - Helpers
    
    private func setupView() {
        view.backgroundColor = .darkGray
        self.navigationItem.searchController = searchController
        
        view.addSubview(backgroundImage)
        
        view.addSubview(collectionView)
    }
    
    private func setupConstraints() {
        backgroundImage.snp.makeConstraints { make in
            make.leading.top.trailing.bottom.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview()
        }
    }
    
    private func setupCollectionView() {
        collectionView.register(CardCollectionViewCell.self, forCellWithReuseIdentifier: CardCollectionViewCell.identifier)
        collectionView.register(TitleCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TitleCollectionReusableView.identifier)
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    func bindViewModel() {
        self.viewModel.delegate = self
        viewModel.getFavoriteCards()
    }
}

extension FavoritesCardViewController: FavoriteCardsManager {
    func getCardsSuccess() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func getCardsError() {
    }
}

extension FavoritesCardViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = viewModel.favoriteCardsBySection[indexPath.section][indexPath.item]
        print(item.name)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TitleCollectionReusableView.identifier, for: indexPath) as? TitleCollectionReusableView{
            sectionHeader.configure(text: viewModel.cardTypes[indexPath.section])
            return sectionHeader
        }
        return UICollectionReusableView()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 50)
    }
}

extension FavoritesCardViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.cardTypes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.favoriteCardsBySection[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCollectionViewCell.identifier, for: indexPath) as? CardCollectionViewCell else
        { return UICollectionViewCell() }
        
        cell.configure(with: viewModel.favoriteCardsBySection[indexPath.section][indexPath.item])
        return cell
    }
    
}

extension FavoritesCardViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.size.width
        
        return CGSize(width: 0.25 * width, height: 0.35 * width)
    }
}

