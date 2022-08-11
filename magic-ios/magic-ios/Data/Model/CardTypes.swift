//
//  CardTypes.swift
//  magic-ios
//
//  Created by bruno.luebke.moreira on 07/08/22.
//

import Foundation

public enum CardType: String, Codable {
    case artifact = "Artifact"
    case conspiracy = "Conspiracy"
    case creature = "Creature"
    case dragon = "Dragon"
    case elemental = "Elemental"
    case enchantment = "Enchantment"
    case goblin = "Goblin"
    case hero = "Hero"
    case instant = "Instant"
    case jaguar = "Jaguar"
    case knights = "Knights"
    case land = "Land"
    case phenomenon = "Phenomenon"
    case plane = "Plane"
    case planeswalker = "Planeswalker"
    case scheme = "Scheme"
    case sorcery = "Sorcery"
    case summon = "Summon"
    case tribal = "Tribal"
    case vanguard = "Vanguard"
    case wolf = "Wolf"
    case youll = "You’ll"
}

public enum CardSubtype: String, Codable {
    case advisor = "Advisor"
    case ajani = "Ajani"
    case alara = "Alara"
    case ally = "Ally"
    case angel = "Angel"
    case antelop = "Antelope"
    case ape = "Ape"
    case arcane = "Arcane"
}

public enum CardSupertype: String, Codable {
    case basic = "Basic"
    case legendary = "Legendary"
    case ongoing = "Ongoing"
    case snow = "Snow"
    case world = "World"
}
