//
//  ExpansionCardsViewController.swift
//  magic-ios
//
//  Created by bruno.vieira.souza on 31/07/22.
//

import UIKit
import SnapKit

class ExpansionCardsViewController: UIViewController {
    
    let viewModel: ExpansionCardsViewModel
    
    //MARK: - UX
    private let background: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "background")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.barStyle = UIBarStyle.black
        searchController.searchBar.barTintColor = .white
        searchController.searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string:"Search cards", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white] )
        searchController.searchBar.searchTextField.tintColor = .white
        searchController.searchBar.searchTextField.borderStyle = .line
        searchController.searchBar.tintColor = .white
        searchController.searchBar.searchTextField.tokenBackgroundColor = .white
        searchController.searchBar.searchTextField.backgroundColor = .clear
        return searchController
    }()
    
    
    //MARK: - Life Cicle
    public init(viewModel: ExpansionCardsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleNavBar()
        setupViewConfiguration()
        setupCollectionView()
        viewModel.delegate = self
        viewModel.getCards()
        
        self.navigationItem.searchController = searchController
        searchController.delegate = self
        searchController.searchBar.delegate = self
    }
    
    private func setupCollectionView() {
        collectionView.register(ExpansionCardViewCell.self,
                                forCellWithReuseIdentifier: ExpansionCardViewCell.identifier)
        collectionView.register(DescriptionSectionCardsView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: DescriptionSectionCardsView.identifier)
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    private func titleNavBar() {
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.title = "Cards"
    }
}

    //MARK: - Delegate
extension ExpansionCardsViewController: CardsRequests {
    
    func getCards() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func getCardsError() {
        DispatchQueue.main.async {
            let alerta = AlertRequestFail(title: "Erro", message: "Tente outra vez").alert()
            self.present(alerta, animated: true)
        }
    }
}

    //MARK: - Constraints
extension ExpansionCardsViewController: BaseViewConfiguration {
    
    func buildViewHierarchy() {
        view.addSubview(background)
        view.addSubview(collectionView)
    }
    
    func setupConstraints() {
        background.snp.makeConstraints { make in
            make.leading.top.trailing.bottom.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview()
        }
    }
}

    //MARK: - DataSource
extension ExpansionCardsViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return  viewModel.typesCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.cardsCount(index: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExpansionCardViewCell.identifier,
                                                            for: indexPath) as? ExpansionCardViewCell else
                                                            { return UICollectionViewCell() }
        
        let configure = viewModel.sectionExpansionCard(indexSection: indexPath.section, indexItem: indexPath.item)
        
        cell.configure(with: configure)
        
        return cell
    }
}

    //MARK: - Collection Delegate
extension ExpansionCardsViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let selectedCard = viewModel.sectionExpansionCard(indexSection: indexPath.section, indexItem: indexPath.item)

        let controller = CardDetailsController(viewModel: CardDetailsViewModel(cards: viewModel.expansionCards, initialCard: selectedCard))
        self.navigationController?.pushViewController(controller, animated: true)

//        let item = viewModel.sectionExpansionCard(indexSection: indexPath.section, indexItem: indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let description = DescriptionSectionCardsView.identifier
        
        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: description, for: indexPath) as? DescriptionSectionCardsView {
            sectionHeader.configure(text: viewModel.typesString(index: indexPath.section))
            
            return sectionHeader
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: view.frame.width, height: 50)
    }
}

extension ExpansionCardsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.size.width
        
        return CGSize(width: 0.25 * width, height: 0.35 * width)
    }
}

extension ExpansionCardsViewController: UISearchControllerDelegate, UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            viewModel.filterCardsWith(word: nil)
        } else {
            viewModel.filterCardsWith(word: searchText)
        }
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else {
            viewModel.filterCardsWith(word: nil)
            return
        }
        
        if searchText == "" {
            viewModel.filterCardsWith(word: nil)
        } else {
            viewModel.filterCardsWith(word: searchText)
        }
    }
}
