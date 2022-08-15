//
//  CardSet.swift
//  magic-ios
//
//  Created by bruno.luebke.moreira on 07/08/22.
//

import Foundation

public struct CardSet: Decodable {
    public init() {}

//    public var code: String?
    public var name: String?
//    public var block: String?
//    public var type: String?
//    public var border: String?
//    public var releaseDate: String?
//    public var magicCardsInfoCode: String?
// For now we wont decode booster because its an Array<Any>
//    public var booster: [Any]?
}
