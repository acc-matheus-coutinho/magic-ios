//
//  DescriptionSectionCardsView.swift
//  magic-ios
//
//  Created by bruno.vieira.souza on 31/07/22.
//

import UIKit

class DescriptionSectionCardsView: UICollectionReusableView {
    
    static let identifier = "DescriptionSectionCardsView"
    
    private let expansionTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func configure(text: String) {
        expansionTitleLabel.text = text
    }
}

extension DescriptionSectionCardsView: BaseViewConfiguration {
    
    func buildViewHierarchy() {
        self.addSubview(expansionTitleLabel)
    }
    
    func setupConstraints() {
        expansionTitleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.leading.trailing.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
