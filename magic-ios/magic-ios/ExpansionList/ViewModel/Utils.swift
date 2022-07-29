//
//  Utils.swift
//  magic-ios
//
//  Created by e.de.farias.batista on 28/07/22.
//

import Foundation

protocol ViewCode {
    func buildHierarchy()
    func setupConstraint()
    func setupConfiguration()
}

extension ViewCode {
    func setupView() {
        buildHierarchy()
        setupConstraint()
        setupConfiguration()
    }
}
