//
//  ExpansionListViewModel.swift
//  magic-ios
//
//  Created by  on /07/22.
//
//


import UIKit
import MTGSDKSwift

public protocol ExpansionListManager: AnyObject {
    func getCardsSuccess()
    func getCardsError()
}

class ExpansionListViewModel {
    
    var expansionListCards: [Card] = []
    var expansionListBySection: [[Card]] = []
    
    var cardNames: [String] = []
    
    let magic: Magic!
    
    weak var delegate: ExpansionListManager?
    
    init(magic: Magic) {
        self.magic = magic
    }
    
    public func getExpansionList() {
        magic.fetchCards([]) { result in
            switch result {
                case .success(let cards):
                    self.expansionListCards = cards
                    self.expansionListBySection = self.filterCardsByName(cards: cards)
                    self.delegate?.getCardsSuccess()
                    
                case .error(let error):
                    print(error.localizedDescription)
                    self.delegate?.getCardsError()
            }
        }
    }
    
    private func filterCardsByName(cards: [Card]) -> [[Card]]  {
        // Todas as primeiras letras que recebemos
        let firstLetters = cards.map { $0.setName?.first?.uppercased() ?? "" }
        // Retirando duplicatas
        let uniqueLetters = Set(firstLetters).sorted()
        
        self.cardNames = uniqueLetters
        // Separando por seções
        let sections: [[Card]] = uniqueLetters.map { letter in
            return cards
                .filter { $0.setName?.first?.uppercased() == letter }
        }
        
        return sections
    }
}
