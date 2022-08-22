//
//  CardDetailsView.swift
//  magic-ios
//
//  Created by  on /07/22.
//

import UIKit

class CardDetailsView: UIView {

    var viewModel: CardDetailsViewModel

    private let backgroundImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "background")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private lazy var carouselCollectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection.showsHorizontalScrollIndicator = false
        collection.dataSource = self
        collection.delegate = self
        collection.backgroundColor = .clear
        collection.backgroundColor = .clear
        collection.register(CardDetailsCell.self, forCellWithReuseIdentifier: CardDetailsCell.cellId)

        let carouselLayout = UICollectionViewFlowLayout()
        carouselLayout.scrollDirection = .horizontal
        carouselLayout.sectionInset = .init(top: 0, left: 55, bottom: 0, right: 55)
        carouselLayout.minimumLineSpacing = 0

        collection.collectionViewLayout = carouselLayout

        return collection
    }()

    init(viewModel: CardDetailsViewModel) {
        self.viewModel = viewModel
        super.init(frame: UIScreen.main.bounds)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func viewDidAppear() {
        if let initialIndex = viewModel.initialCardIndex {
            carouselCollectionView.scrollToItem(at: IndexPath(item: initialIndex, section: 0), at: .centeredHorizontally, animated: true)
        }
    }

    func setupViews() {
        configureViews()
        setupViewHierarchy()
        setupConstraints()
    }

    private func configureViews() {
        backgroundColor = .darkGray
    }

    private func setupViewHierarchy() {
        addSubview(backgroundImage)
        addSubview(carouselCollectionView)
    }

    private func setupConstraints() {
        backgroundImage.snp.makeConstraints { make in
            make.top.bottom.trailing.leading.equalToSuperview()
        }

        carouselCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(92)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
    }
}

extension CardDetailsView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.cards.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardDetailsCell.cellId, for: indexPath) as? CardDetailsCell else { return UICollectionViewCell() }

        cell.configure(card: viewModel.cards[indexPath.row])

        return cell
    }

}

extension CardDetailsView: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: self.frame.width - 110, height: self.frame.height - 300)
    }
}
