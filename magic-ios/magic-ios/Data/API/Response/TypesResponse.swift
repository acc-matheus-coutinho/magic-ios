//
//  TypesResponse.swift
//  magic-ios
//
//  Created by bruno.luebke.moreira on 11/08/22.
//

import Foundation

public struct CardTypesResponse: Decodable {
    public var types: [CardType]
}

public struct CardSubtypesResponse: Decodable {
    public var subtypes: [CardSubtype]
}

public struct CardSupertypesResponse: Decodable {
    public var supertypes: [CardSupertype]
}
