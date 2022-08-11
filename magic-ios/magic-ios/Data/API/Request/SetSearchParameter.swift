//
//  SetSearchParameter.swift
//  magic-ios
//
//  Created by bruno.luebke.moreira on 07/08/22.
//

import Foundation

public final class SetSearchParameter: SearchParameter {

    public enum SetParameter: String, Codable {
        case name
        case block
    }

    public init(_ parameterType: SetParameter, value: String) {
        super.init()
        self.name = parameterType.rawValue
        self.value = value
    }
}



