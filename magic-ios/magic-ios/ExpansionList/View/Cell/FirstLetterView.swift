//
//  FirstLetterView.swift
//  magic-ios
//
//  Created by matheus.coutinho on 15/08/22.
//

import UIKit

class FirstLetterSectionView: UITableViewHeaderFooterView {
    
    static let identifier = "UITableViewHeaderFooterView"
    
    private let expansionTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupViewConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func configure(text: String) {
        expansionTitleLabel.text = text
    }
}

extension FirstLetterSectionView: BaseViewConfiguration {
    
    func buildViewHierarchy() {
        self.addSubview(expansionTitleLabel)
        contentView.backgroundColor = .white
    }
    
    func setupConstraints() {
        expansionTitleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.leading.trailing.equalTo(self.safeAreaLayoutGuide).offset(20)
        }
    }
}
