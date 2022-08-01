//
//  ExpansionListViewModel.swift
//  magic-ios
//
//  Created by  on /07/22.
//

import UIKit
import SnapKit

class ComponentView: UIView {

    lazy var imageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .orange
        view.layer.cornerRadius = 10
        return view

    }()
    
    lazy var labelView: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        view.text = "Hello Word!"
        return view
    }()
    
    lazy var view: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .blue
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ComponentView: ViewCode {
    func buildHierarchy() {
        addSubview(labelView)
        addSubview(imageView)
        imageView.addSubview(view)
//        addSubview(view)
    }

    func setupConstraint() {
        labelView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.right.equalTo(imageView.snp.right)
            make.left.equalTo(imageView.snp.left)
            make.bottom.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.height.width.equalTo(100.0)
            make.top.left.right.equalToSuperview()
        }
        
        view.snp.makeConstraints { make in
//            make.height.width.equalTo(30.0)
//            make.top.left.equalTo(imageView).offset(10)
//            make.right.bottom.equalTo(imageView).offset(-10)
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func setupConfiguration() {
        //
    }
}
