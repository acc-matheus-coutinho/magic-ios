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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
    
    public init(viewModel: ExpansionCardsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
