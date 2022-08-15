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
    
    var expansionListCards: [Card] = []
    var expansionListBySection: [Set<String>]  = []
    
    var cardNames: [String] = []
    
    let magic: MagicAPIProtocol!
    
    weak var delegate: ExpansionListManager?
    
    init(magic: MagicAPIProtocol) {
        self.magic = magic
    }
    
    public func getExpansionList() {
        let parameters: [CardSearchParameter] = [
//            .init(.name, value: "nome"),
            .init(.setName, value: "KTK")
        ]
        
        magic.fetchCards(with: parameters) { response in
            switch response.result {
            case .success(let data):
                print(data)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
//        magic.fetchSets([]) { result in
//            switch result {
//                case .success(let sets):
//                    print(sets)
//                case .error(let error):
//                    print(error)
//            }
//        }
//
//        magic.fetchCards([], configuration: .init(pageSize: 300, pageTotal: 5)) { result in
//            switch result {
//                case .success(let cards):
//                    self.expansionListCards = cards
//                    self.expansionListBySection = self.filterSectionsByWord(cards: cards)
//                    self.delegate?.getCardsSuccess()
//
//                case .error(let error):
//                    print(error.localizedDescription)
//                    self.delegate?.getCardsError()
//            }
//        }
    }
    
//    private func filterSectionsByWord(cards: [Card]) -> [Set<String>]  {
//            let types = cards.map { card in
//                return card.setName ?? "No Type"
//            }
//            let uniqueTypes = Set(types).sorted()
//            self.cardNames = uniqueTypes
//            let sections: [Set<String>] = uniqueTypes.map { type in
//                let expansions = cards.filter { $0.setName == type }.map { card in
//                    return card.setName ?? ""
//                }
//                return Set(expansions)
//            }
//            return sections
//    }
}
