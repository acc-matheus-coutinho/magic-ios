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
    
    // MARK: - Parametros
    let cmc = CardSearchParameter(parameterType: .set, value: "KTK")
    let color = CardSearchParameter(parameterType: .colors, value: "black")
    let setCode = CardSearchParameter(parameterType: .set, value: "AER")
    
    // MARK: - Delegates
    weak var delegate: CardsRequests?
    
    // MARK: - Init
    init(magic: Magic) {
        self.magic = magic
    }
    
    public func getCards() {
        magic.fetchCards([cmc]) { result in
            switch result {
            case .success(let cards):
                self.expansionCards = cards
                self.sectionExpansionCards = self.filterCardsByType(cards: cards)
                self.delegate?.getCards()
            case .error(let error):
                self.delegate?.getCardsError()
            }
        }
    }
    
    private func filterCardsByType(cards: [Card]) -> [[Card]]  {
        
        //Retorna os tipos dos cards do Array
        let types = cards.map { card in
            return card.type ?? "No Type"
        }
        //Colocar os Cards em Ordem Alfabetica
        let uniqueTypes = Set(types).sorted()
        
        //seta os valores na minha variavel Types
        self.types = uniqueTypes
        
        //Filtrando pelo tipo do Card
        let sections: [[Card]] = uniqueTypes.map { type in
            return cards.filter { $0.type == type }
        }
        return sections
    }
}
