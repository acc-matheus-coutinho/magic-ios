//
//  FavoritesCardsViewModel.swift
//  magic-ios
//
//  Created by  on /07/22.
//

import UIKit

public protocol FavoriteCardsManager: AnyObject {
    func getCardsSuccess()
    func getCardsError()
    func filterCardsSuccess()
}

class FavoritesCardsViewModel {
    
    var favoriteCards: [Card] = []
    var favoriteCardsBySection: [[Card]] = []
    var expansionList: [Set<String>] = []
    
    var cardTypes: [String] = []
    
    let magic: MagicAPIProtocol!
    
    weak var delegate: FavoriteCardsManager?
    
    init(magic: MagicAPIProtocol) {
        self.magic = magic
    }
    
    public func getFavoriteCards() {
        
    }
    
    public func filterCardsWith(word: String?) {
        if let word = word {
            let filteredCards = favoriteCards.filter { card in
                return card.name?.contains(word) ?? false
            }
            favoriteCardsBySection = filterCardsByType(cards: filteredCards)
        } else {
            favoriteCardsBySection = filterCardsByType(cards: self.favoriteCards)
        }

        delegate?.filterCardsSuccess()
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
        return sections
    }
    
    private func filterSectionsByWord(cards: [Card]) -> [Set<String>]  {
        let types = cards.map { card in
            return card.setName ?? "No Type"
        }
        
        let uniqueTypes = Set(types).sorted()
        
        self.cardTypes = uniqueTypes
        
        let sections: [Set<String>] = uniqueTypes.map { type in
            let expansions = cards.filter { $0.type == type }.map { card in
                return card.setName ?? ""
            }
            return Set(expansions)
        }
        return sections
    }
}
