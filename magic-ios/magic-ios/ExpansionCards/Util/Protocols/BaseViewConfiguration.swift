//
//  BaseViewConfiguration.swift
//  magic-ios
//
//  Created by bruno.vieira.souza on 31/07/22.
//

import Foundation

public protocol BaseViewConfiguration {
    func buildViewHierarchy()
    func setupConstraints()
    func configureView()
}

public extension BaseViewConfiguration {
    func setupViewConfiguration() {
        self.buildViewHierarchy()
        self.setupConstraints()
        self.configureView()
    }
    
    func configureView() {
        // Default implementation
    }
}
