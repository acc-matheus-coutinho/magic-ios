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
    
    let cmc = CardSearchParameter(parameterType: .set, value: "KTK")
    let color = CardSearchParameter(parameterType: .colors, value: "red")
    let setCode = CardSearchParameter(parameterType: .set, value: "KTK")
    
    // MARK: - Delegate
    
    weak var delegate: CardsRequests?
    
    // MARK: - Init
    
    init() {
        
    }
    
    // MARK: - Methods
    
    func getCards() {
        magic.fetchCards([color], configuration: .init(pageSize: 100, pageTotal: 10)) { result in
            switch result {
            case .success(let cards):
                self.expansionCards = cards
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
        return sections
    }
}
