//
//  ViewController.swift
//  Sparta7_PhoneBook
//
//  Created by seohuibaek on 12/10/24.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    private let mainTableView = MainTableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = mainTableView
        
        navigationItem.title = "Pokemon"
        
        let addButton = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addButtonTapped))
        
        navigationItem.rightBarButtonItem = addButton
    }
    
    @objc private func addButtonTapped() {
        // 이 부분 수정하기
//        let contactAddViewController = ContactAddViewController()
//        navigationController?.pushViewController(contactAddViewController, animated: true)
        
        makeRandomPokemonImage()
    }
    
    func makeRandomPokemonImage() {
        var randomNumber = Int.random(in: (1...1000))
        
        PokemonImageService.fetchPokemonData(pokemonID: randomNumber) { [weak self] (result: Result<PokemonImageModel, Error>) in
            switch result {
            case .success(let pokemon):
                let contactAddViewController = ContactAddViewController()
                contactAddViewController.pokemon = pokemon // 전달
                self?.navigationController?.pushViewController(contactAddViewController, animated: true)
                
            case .failure(let error):
                print("Error fetching Pokémon data: \(error.localizedDescription)")
            }
        }
    }
}

//@available(iOS 17.0, *)
//#Preview {
//    ContactAddViewController()
//}
