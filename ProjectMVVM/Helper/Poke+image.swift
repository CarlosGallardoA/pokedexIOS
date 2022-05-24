//
//  Poke+image.swift
//  ProjectMVVM
//
//  Created by Carlos Enrique Gallardo Ambrosio on 23/05/22.
//

import Foundation
import UIKit

class HelperImage {
    static func setImage(id: String) -> UIImage? {
        return convertImageFromURL(url: getUrlImage(id: id))
    }
    static func setImageFromUrl(url: String) -> UIImage? {
        return convertImageFromURL(url: url)
    }
    static func convertImageFromURL(url: String) -> UIImage? {
        let data = try? Data(contentsOf: HelperString.getURLFromString(url: url)!)
        if let imageData = data {
            let image = UIImage(data: imageData)
            return image
        }
        return nil
    }
    static func getUrlImage(id: String) -> String {
        return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png"
    }
}
