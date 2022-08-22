//
//  CardDetailsModel.swift
//  magic-ios
//
//  Created by  on /07/22.
//

import Foundation

extension Card {
    var isFavorite: Bool { CoreDataStack.coreDataStack?.checkCardInFavorites(self) ?? false }
}
