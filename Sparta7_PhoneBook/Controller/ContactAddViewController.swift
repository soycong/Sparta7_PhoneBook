//
//  ContactAddViewController.swift
//  Sparta7_PhoneBook
//
//  Created by seohuibaek on 12/10/24.
//
import UIKit

class ContactAddViewController: UIViewController {
    private let contactAddView = ContactAddView()
    var pokemon: PokemonImageModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = contactAddView
        
        navigationItem.title = "Information"
        
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveButtonTapped))
        
        navigationItem.rightBarButtonItem = saveButton
        
        
        if let pokemon = pokemon {
            print("Received Pokémon Data:")
            print("ID: \(pokemon.id)")
            print("Name: \(pokemon.name)")
            print("Height: \(pokemon.height)")
            print("Weight: \(pokemon.weight)")
            print("Sprite URL: \(pokemon.sprites.front_default)")
        }
        
//        let BackButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveButtonTapped))
//        navigationItem.rightBarButtonItem = saveButton
    }
    
    @objc private func saveButtonTapped() {
    }
}
