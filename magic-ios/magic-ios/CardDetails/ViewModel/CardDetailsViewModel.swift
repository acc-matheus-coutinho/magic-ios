//
//  CardDetailsViewModel.swift
//  magic-ios
//
//  Created by  on /07/22.
//

import Foundation

class CardDetailsViewModel {

    var cards: [Card]
    var initialCard: Card?
    var initialCardIndex: Int? {
        guard let initialCard = self.initialCard else {
            return nil
        }
        return self.cards.firstIndex(of: initialCard)
    }

    init(cards: [Card], initialCard: Card? = nil) {
        self.cards = cards
        self.initialCard = initialCard
    }
}
