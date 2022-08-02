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

final class ExpansionCardsViewModel {
    
    // MARK: - Variables
    
    var expansionCards: [Card] = []
    private var sectionExpansionCards: [[Card]] = []
    private var types: [String] = []
    
    let magic = Magic()
    
    // MARK: - Parametros
    
    var parameters: [CardSearchParameter] = []
    
    let cmc = CardSearchParameter(parameterType: .name, value: "Bogardan Firefiend")
    let color = CardSearchParameter(parameterType: .colors, value: "red")
    let setCode = CardSearchParameter(parameterType: .set, value: "KTK")
    
    // MARK: - Delegate
    
    weak var delegate: CardsRequests?
    
    // MARK: - Init
    
    init(parameters: [CardSearchParameter], setName: String) {
        let setCode = CardSearchParameter(parameterType: .set, value: setName)
        self.parameters.append(setCode)
        self.parameters.append(contentsOf: parameters)
    }
    
    // MARK: - Methods
    
    func getCards() {

        magic.fetchCards(parameters) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let cards):
                self.expansionCards = cards
                print(cards)
                self.sectionExpansionCards = self.filterCardsByType(cards: cards)
                self.delegate?.getCards()
            case .error(_):
                self.delegate?.getCardsError()
            }
        }
    }
    
    public func cardsCount(index: Int) -> Int {
        sectionExpansionCards[index].count
    }
    
    public func typesCount() -> Int {
        types.count
    }
    
    public func sectionExpansionCard(indexSection: Int, indexItem : Int) -> Card {
        sectionExpansionCards[indexSection][indexItem]
    }
    
    public func typesString(index: Int) -> String {
        types[index]
    }
    
    private func filterCardsByType(cards: [Card]) -> [[Card]]  {
        
        let types = cards.map { card in
            return card.type ?? "No Type"
        }
        
        let uniqueTypes = Set(types).sorted()
        self.types = uniqueTypes
        
        let sections: [[Card]] = uniqueTypes.map { type in
            return cards.filter { $0.type == type }
        }
        print(sections)
        return sections
    }
    
    public func filterCardsWith(word: String?) {
        if let word = word {
            let filteredCards = expansionCards.filter { card in
                return card.name?.contains(word) ?? false
            }
            sectionExpansionCards = filterCardsByType(cards: filteredCards)
        } else {
            sectionExpansionCards = filterCardsByType(cards: self.expansionCards)
        }

        delegate?.getCards()
    }
}
