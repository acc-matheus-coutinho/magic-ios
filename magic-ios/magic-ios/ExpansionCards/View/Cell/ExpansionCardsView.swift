//
//  ExpansionCardsView.swift
//  magic-ios
//
//  Created by  on /07/22.
//

import UIKit
import Kingfisher

class ExpansionCardViewCell: UICollectionViewCell {
    
    static let identifier = "ExpansionCardViewCell"
    
    private let cardImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "magicCardBack")
        image.tintColor = .white
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private let loadingView: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.color = .white
        activity.translatesAutoresizingMaskIntoConstraints = false
        return activity
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with card: Card) {
        cardImage.isHidden = true
        contentView.addSubview(loadingView)
        loadingView.startAnimating()

        if let urlString = card.imageUrl?.replacingOccurrences(of: "http://", with: "https://") {
            let placeHolder = UIImage(named: "magicCardBack")
            cardImage.kf.setImage(with: URL(string: urlString), placeholder: placeHolder, options: .none) { _ in
                self.loadingView.stopAnimating()
                self.cardImage.isHidden = false
                self.loadingView.removeFromSuperview()
            }
        } else {
            self.loadingView.stopAnimating()
            self.cardImage.isHidden = false
            self.loadingView.removeFromSuperview()
        }
    }
}

extension ExpansionCardViewCell: BaseViewConfiguration {
    func buildViewHierarchy() {
        contentView.addSubview(loadingView)
        contentView.addSubview(cardImage)
    }
    
    func setupConstraints() {
        cardImage.snp.makeConstraints { make in
            make.leading.top.trailing.bottom.equalToSuperview()
        }
        
        loadingView.snp.makeConstraints { make in
            make.leading.top.trailing.bottom.equalToSuperview()
        }
    }
}
