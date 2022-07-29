//
//  ExpansionListModel.swift
//  magic-ios
//
//  Created by  on /07/22.
//

import UIKit
import SnapKit

class CustomView: UIView {
    lazy var component = ComponentView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomView: ViewCode {
    func buildHierarchy() {
        addSubview(component)
    }
    
    func setupConstraint() {
        component.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(20)
            make.centerX.equalToSuperview()
        }
        
//        component.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
//        component.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    func setupConfiguration() {
        self.backgroundColor = .gray
    }
}
