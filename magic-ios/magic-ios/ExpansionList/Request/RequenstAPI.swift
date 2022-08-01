//
//  RequenstAPI.swift
//  magic-ios
//
//  Created by e.de.farias.batista on 29/07/22.
//

import Foundation
import MTGSDKSwift



class RequestAPI {
//    let magic = Magic()
    let color = CardSearchParameter(parameterType: .colors, value: "black")
    let cmc = CardSearchParameter(parameterType: .cmc, value: "2")
    let setCode = CardSearchParameter(parameterType: .set, value: "AER")
    

    magic.fetchCards(withParameters: [color,cmc,setCode]) {
        cards, error in

        if let error = error {
            //handle your error
        }

        for c in cards! {
            print(c.name)
        }
    }
}
