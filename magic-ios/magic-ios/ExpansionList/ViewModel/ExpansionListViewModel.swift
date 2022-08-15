//
//  ExpansionListViewModel.swift
//  magic-ios
//
//  Created by  on /07/22.
//
//


import UIKit

public protocol ExpansionListManager: AnyObject {
    func getCardsSuccess()
    func getCardsError()
}

class ExpansionListViewModel {
    
    var expansionListCards: [CardSet] = []
    var expansionListBySection: [Set<String>]  = []
    
    var cardNames: [String] = []
    
    let magic: MagicAPIProtocol!
    
    weak var delegate: ExpansionListManager?
    
    init(magic: MagicAPIProtocol) {
        self.magic = magic
    }
    
    public func getExpansionList() {
        let parameters: [SetSearchParameter] = []
        
        magic.fetchSets(with: parameters) { response in
            switch response.result {
            case .success(let data):
                self.expansionListCards = data.sets
                self.expansionListBySection = self.filterSectionsByWord(sets: data.sets)
                self.delegate?.getCardsSuccess()
                
            case .failure(let error):
                print(error.localizedDescription)
                self.delegate?.getCardsError()
            }
        }
    }
    
    private func filterSectionsByWord(sets: [CardSet]) -> [Set<String>]  {
        let names = sets.map { card in
            return "\(card.name?.prefix(1) ?? "0")"
        }
        let uniqueNames = Set(names).sorted()
        self.cardNames = uniqueNames
        let sections: [Set<String>] = uniqueNames.map { firstLetter in
            let expansions = sets.filter { cardSet in
                cardSet.name?.hasPrefix(firstLetter) ?? false
            }
            let expansionNames = expansions.map { cardSet in
                return cardSet.name ?? "No name"
            }
            return Set(expansionNames)
        }
        return sections
    }
}
