//
//  UIImageView+Extensions.swift
//  magic-ios
//
//  Created by bruno.vieira.souza on 01/08/22.
//

import UIKit

extension UIImageView {
    func loadFrom(URLAddress: String, completion: @escaping () -> Void) {
        guard let url = URL(string: URLAddress) else {
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imageData) {
                    self?.image = loadedImage
                    return completion()
                }
            }
        }
    }
}
