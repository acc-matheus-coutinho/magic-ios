//
//  FavoritesCardsViewModel.swift
//  magic-ios
//
//  Created by  on /07/22.
//

import UIKit
import MTGSDKSwift

public protocol FavoriteCardsManager: AnyObject {
    func getCardsSuccess()
    func getCardsError()
}

class FavoritesCardsViewModel {
    
    var favoriteCards: [Card] = []
    var favoriteCardsBySection: [[Card]] = []
    
    var cardTypes: [String] = []
    
    let magic: Magic!
    
    weak var delegate: FavoriteCardsManager?
    
    init(magic: Magic) {
        self.magic = magic
    }
    
    public func getFavoriteCards() {
        magic.fetchCards([]) { result in
            switch result {
            case .success(let cards):
                self.favoriteCards = cards
                self.favoriteCardsBySection = self.filterCardsByType(cards: cards)
                self.delegate?.getCardsSuccess()
                
            case .error(let error):
                print(error.localizedDescription)
                self.delegate?.getCardsError()
            }
        }
    }
    
    private func filterCardsByType(cards: [Card]) -> [[Card]]  {
        let types = cards.map { card in
            return card.type ?? "No Type"
        }
        
        let uniqueTypes = Set(types).sorted()
        
        self.cardTypes = uniqueTypes
        
        let sections: [[Card]] = uniqueTypes.map { type in
            return cards.filter { $0.type == type }
            
        }
        
        sections.forEach { cards in
            cards.forEach { card in
                print(card.id)
                print(card.imageUrl)
            }
        }
        
        return sections

    }
}
