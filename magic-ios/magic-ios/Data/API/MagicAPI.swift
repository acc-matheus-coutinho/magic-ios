//
//  MagicAPI.swift
//  magic-ios
//
//  Created by bruno.luebke.moreira on 07/08/22.
//

import Alamofire

public protocol MagicAPIProtocol {
    func fetchSets(with parameters: [SetSearchParameter]?, completion: @escaping (AFDataResponse<SetsResponse>) -> Void)
    func fetchCards(with parameters: [CardSearchParameter]?, completion: @escaping (AFDataResponse<CardsResponse>) -> Void)
    func fetchTypes(completion: @escaping (AFDataResponse<CardTypesResponse>) -> Void)
    func fetchSubtypes(completion: @escaping (AFDataResponse<CardSubtypesResponse>) -> Void)
    func fetchSupertypes(completion: @escaping (AFDataResponse<CardSupertypesResponse>) -> Void)
}

final public class MagicAPI: MagicAPIProtocol {

    public func fetchSets(with parameters: [SetSearchParameter]? = nil, completion: @escaping (AFDataResponse<SetsResponse>) -> Void) {
        AF.request(MagicRouter.sets(parameters)).responseDecodable(of: SetsResponse.self, completionHandler: completion)
    }

    public func fetchCards(with parameters: [CardSearchParameter]? = nil, completion: @escaping (AFDataResponse<CardsResponse>) -> Void) {
        
        AF.request(MagicRouter.cards(parameters)).responseDecodable(of: CardsResponse.self, completionHandler: completion)
    }

    public func fetchTypes(completion: @escaping (AFDataResponse<CardTypesResponse>) -> Void) {
        AF.request(MagicRouter.types).responseDecodable(of: CardTypesResponse.self, completionHandler: completion)
    }

    public func fetchSubtypes(completion: @escaping (AFDataResponse<CardSubtypesResponse>) -> Void) {
        AF.request(MagicRouter.subtypes).responseDecodable(of: CardSubtypesResponse.self, completionHandler: completion)
    }

    public func fetchSupertypes(completion: @escaping (AFDataResponse<CardSupertypesResponse>) -> Void) {
        AF.request(MagicRouter.supertypes).responseDecodable(of: CardSupertypesResponse.self, completionHandler: completion)
    }
}
