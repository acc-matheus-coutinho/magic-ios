//
//  ExpansionCardsViewController.swift
//  magic-ios
//
//  Created by bruno.vieira.souza on 31/07/22.
//

import UIKit
import MTGSDKSwift
import SnapKit

class ExpansionCardsViewController: UIViewController {
    
    var viewModel: ExpansionCardsViewModel
    
    
    //MARK: - UX
    
    private let background: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "background")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    //MARK: - Life Cicle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public init(viewModel: ExpansionCardsViewModel) {
        
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupViewConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ExpansionCardsViewController: BaseViewConfiguration {
    func buildViewHierarchy() {
        view.addSubview(background)
    }
    
    func setupConstraints() {
        background.snp.makeConstraints { make in
            make.leading.top.trailing.bottom.equalToSuperview()
        }
        
        func configureView() {
            view.backgroundColor = .clear
        }
    }
}
