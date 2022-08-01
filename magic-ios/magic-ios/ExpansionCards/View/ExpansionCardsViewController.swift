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
        //layout.scrollDirection = .vertical

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
        bindViewModel()
    }
    
    private func setupCollectionView() {
        collectionView.register(ExpansionCardViewCell.self, forCellWithReuseIdentifier: ExpansionCardViewCell.identifier)
        collectionView.register(DescriptionSectionCardsView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: DescriptionSectionCardsView.identifier)
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    func bindViewModel() {
        self.viewModel.delegate = self
        viewModel.getCards()
    }
}

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
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview()
        }
    }
    
    func configureView() {
       //view.backgroundColor = .clear
    }
}

extension ExpansionCardsViewController: CardsRequests {
    
    func getCards() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func getCardsError() {
    }
}

extension ExpansionCardsViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return  viewModel.types.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return viewModel.sectionExpansionCards[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExpansionCardViewCell.identifier, for: indexPath) as? ExpansionCardViewCell else
        { return UICollectionViewCell() }
        
        cell.configure(with: viewModel.sectionExpansionCards[indexPath.section][indexPath.item])
        return cell
    }
}

extension ExpansionCardsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let item = viewModel.sectionExpansionCards[indexPath.section][indexPath.item]
            print(item.name)
        }
        
        func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

            if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: DescriptionSectionCardsView.identifier, for: indexPath) as? DescriptionSectionCardsView{
                sectionHeader.configure(text: viewModel.types[indexPath.section])
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
