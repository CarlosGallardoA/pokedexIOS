//
//  PokeDetail.swift
//  ProjectMVVM
//
//  Created by Carlos Enrique Gallardo Ambrosio on 23/05/22.
//

import Foundation

struct PokeDetail: Codable {
    let name: String
    let weight: Int
    let sprites: Sprites
    let types: [Types]
    
}
struct Sprites: Codable {
    let other: Other
}
struct Other: Codable {
    let officialArtwork: Official
    
    //Crear alias a modelo
    enum CodingKeys: String, CodingKey {
        case officialArtwork = "official-artwork"
    }
}
struct Official: Codable {
    let front_default: String
}
struct Types: Codable {
    let slot: Int
    let type: TypePoke
}
struct TypePoke: Codable {
    let name: String
    let url: String
}


