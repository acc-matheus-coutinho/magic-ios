//
//  ExpansionCardsView.swift
//  magic-ios
//
//  Created by  on /07/22.
//

import UIKit
import MTGSDKSwift

class ExpansionCardViewCell: UICollectionViewCell {
    
    private let cardImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "menucard.fill")
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
