//
//  ExpansionCardsViewController.swift
//  magic-ios
//
//  Created by bruno.vieira.souza on 31/07/22.
//

import UIKit
import MTGSDKSwift
import SnapKit

class ExpansionCardsViewController: UIViewController {
    
    var viewModel: ExpansionCardsViewModel
    
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
        setupViewConfiguration()
        setupCollectionView()
        viewModel.delegate = self
        viewModel.getCards()
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
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
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
        
        let item = viewModel.sectionExpansionCard(indexSection: indexPath.section, indexItem: indexPath.item)
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
