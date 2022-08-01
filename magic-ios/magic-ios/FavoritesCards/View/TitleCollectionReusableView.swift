//
//  TitleCollectionReusableView.swift
//  magic-ios
//
//  Created by matheus.coutinho on 29/07/22.
//

import UIKit

class TitleCollectionReusableView: UICollectionReusableView {
    
    static let identifier = "TitleCollectionReusableView"
    
    private let expansionTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Khans of Tarkir"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        buildViewHierarchy()
        configConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildViewHierarchy() {
        self.addSubview(expansionTitleLabel)
    }
    
    private func configConstraints() {
        expansionTitleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.leading.trailing.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    public func configure(text: String) {
        expansionTitleLabel.text = text
    }
}
