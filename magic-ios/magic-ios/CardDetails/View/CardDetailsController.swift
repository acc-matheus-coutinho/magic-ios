//
//  CardDetailsController.swift
//  magic-ios
//
//  Created by bruno.luebke.moreira on 16/08/22.
//

import Foundation
import UIKit

class CardDetailsController: UIViewController {

    var rootView: CardDetailsView

    init(viewModel: CardDetailsViewModel) {
        rootView = CardDetailsView(viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = rootView
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        rootView.viewDidAppear()
    }
}
