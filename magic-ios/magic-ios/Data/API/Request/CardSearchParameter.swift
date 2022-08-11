//
//  CardSearchParameter.swift
//  magic-ios
//
//  Created by bruno.luebke.moreira on 07/08/22.
//

import Foundation

public final class CardSearchParameter: SearchParameter {

    public enum CardParameter: String, Codable {
        case name
        case layout
        case cmc
        case colors
        case colorIdentity
        case type
        case supertypes
        case types
        case subtypes
        case rarity
        case setCode
        case setName
        case text
        case flavor
        case artist
        case number
        case power
        case toughness
        case loyalty
        case language
        case gameFormat
        case legality
        case orderBy
        case random
        case contains
        case id
        case multiverseid
    }

    public init(_ parameterType: CardParameter, value: String) {
        super.init()
        self.name = parameterType.rawValue
        self.value = value
    }
}


