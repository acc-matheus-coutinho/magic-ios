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
    func filterCardsSuccess()
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
        
        magic.fetchCards([], configuration: .init(pageSize: 100, pageTotal: 10)) {
            result in
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
        
//        magic.fetchCards([]) { result in
//            switch result {
//            case .success(let cards):
//                cards.forEach { card in
//                    print(card.name, card.imageUrl)
//                }
//                self.favoriteCards = cards
//                self.favoriteCardsBySection = self.filterCardsByType(cards: cards)
//                self.delegate?.getCardsSuccess()
//
//            case .error(let error):
//                print(error.localizedDescription)
//                self.delegate?.getCardsError()
//            }
//        }
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
//        sections.forEach { cards in
//            cards.forEach { card in
//                print(card.name, card.imageUrl)
//            }
//        }
        
        return sections
    }
}
