//
//  CardCollectionViewCell.swift
//  magic-ios
//
//  Created by matheus.coutinho on 29/07/22.
//

import UIKit
import MTGSDKSwift

class CardCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CardCollectionViewCell"
    
    private let cardImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "menucard.fill")
        image.tintColor = .white
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
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
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.addSubview(loadingView)
        contentView.addSubview(cardImage)
    }
    
    private func setupConstraints() {
        cardImage.snp.makeConstraints { make in
            make.leading.top.trailing.bottom.equalToSuperview()
        }
        
        loadingView.snp.makeConstraints { make in
            make.leading.top.trailing.bottom.equalToSuperview()
        }
    }
    
    public func configure(with card: Card) {
        cardImage.isHidden = true
        loadingView.startAnimating()
        
        if let urlString = card.imageUrl?.replacingOccurrences(of: "http://", with: "https://") {
            cardImage.loadFrom(URLAddress: urlString) {
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
