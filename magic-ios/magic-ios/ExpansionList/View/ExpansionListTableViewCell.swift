//
//  ExpansionListTableViewCell.swift
//  magic-ios
//
//  Created by e.de.farias.batista on 02/08/22.
//

import UIKit

class ExpansionListTableViewCell: UITableViewCell {
    
    
    static let identifier = "TitleCollectionReusableView"
    
    private let expansionTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Expansion"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
       
        self.backgroundColor = .clear
       
        self.selectionStyle = .none
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
