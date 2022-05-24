//
//  Poke+String.swift
//  ProjectMVVM
//
//  Created by Carlos Enrique Gallardo Ambrosio on 23/05/22.
//

import Foundation

class HelperString {
    static func getIdFromUrl(url: String) -> String {
        var arrayString = url.components(separatedBy: "/")
        arrayString = arrayString.filter({ $0 != "" })
        return arrayString.last!
    }
}
