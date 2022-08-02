//
//  AlertsError.swift
//  magic-ios
//
//  Created by bruno.vieira.souza on 01/08/22.
//

import UIKit

struct AlertRequestFail {
    
    var title: String
    var message: String
    
    init(title: String, message: String) {
        self.title = title
        self.message = message
    }
    
    func alert() -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(cancelAction)
        
        return alert
    }
    
}
