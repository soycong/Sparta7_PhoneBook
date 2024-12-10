//
//  PocketmonImageModel.swift
//  Sparta7_PhoneBook
//
//  Created by seohuibaek on 12/10/24.
//

struct PokemonImageModel: Codable {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let sprites: Sprites
}

struct Sprites: Codable {
    let front_default: String
}
