//
//  PocketmonImageService.swift
//  Sparta7_PhoneBook
//
//  Created by seohuibaek on 12/10/24.
//
import Alamofire

class PokemonImageService {
    static func fetchPokemonData(completion: @escaping (Result<PokemonImageModel, Error>) -> Void) {
        let urlString = "https://pokeapi.co/api/v2/pokemon/\(Int.random(in: (1...1000)))"
        
        AF.request(urlString).responseDecodable(of: PokemonImageModel.self) { response in
            switch response.result {
            case .success(let pokemon):
                completion(.success(pokemon))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

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
