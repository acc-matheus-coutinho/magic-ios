//
//  ExpansionCardsViewModel.swift
//  magic-ios
//
//  Created by  on /07/22.
//

import UIKit
import MTGSDKSwift

public protocol CardsRequests: AnyObject {
        func getCards()
        func getCardsError()
    }
    
class ExpansionCardsViewModel {
    
    // MARK: - Variables
    var expansionCards: [Card] = []
    var sectionExpansionCards: [[Card]] = []
    var types: [String] = []
    let magic: Magic
    
    // MARK: - Delegates
    weak var delegate: CardsRequests?
    
    
    // MARK: - Init
    init(magic: Magic) {
        self.magic = magic
    }
    
    public func getCards() {
        magic.fetchCards([]) { result in
            switch result {
            case .success(let cards):
                self.expansionCards = cards
            case .error(let error):
                self.delegate?.getCardsError()
            }
        }
    }
}
