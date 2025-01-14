//
//  Card.swift
//  magic-ios
//
//  Created by bruno.luebke.moreira on 07/08/22.
//

import Foundation

public struct Card: Equatable, Decodable {
    public init() {}

    public var name: String?
//    public var names: [String]?
//    public var manaCost: String?
//    public var cmc: Int?
//    public var colors: [String]?
//    public var colorIdentity: [String]?
    public var type: String?
//    public var supertypes: [CardSupertype]?
//    public var types: [CardType]?
//    public var subtypes: [CardSubtype]?
//    public var rarity: String?
//    public var set: String?
    public var setName: String?
//    public var text: String?
//    public var artist: String?
//    public var number: String?
//    public var power: String?
//    public var toughness: String?
//    public var layout: String?
//    public var multiverseid: String?
    public var imageUrl: String?
//    public var rulings: [[String:String]]?
//    public var foreignNames: [ForeignName]?
//    public var printings: [String]?
//    public var originalText: String?
//    public var originalType: String?
    public var id: String?
//    public var flavor: String?
//    public var loyalty: String?
//    public var gameFormat: String?
//    public var releaseDate: String?
//    public var legalities: [Legality]?

    public static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.id == rhs.id
    }
}

public struct ForeignName: Decodable {
    public var name: String
    public var language: String
    public var multiverseid: Int?
}

public struct Legality: Decodable {
    public var format: String
    public var legality: String
}
