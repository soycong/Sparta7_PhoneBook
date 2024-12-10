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
    var pokemonImageURL: String?
    
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
            
            pokemonImageURL = pokemon.sprites.front_default
        }
        
        setProfileImage()
        
//        let BackButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveButtonTapped))
//        navigationItem.rightBarButtonItem = saveButton
    }
    
    func setProfileImage() {
        guard let imageURLString = pokemonImageURL,
              let profileImageURL = URL(string: imageURLString) else {
            print("유효하지 않은 이미지 URL입니다.")
            contactAddView.profileImageView.image = UIImage(named: "ProfileImage") // 기본 이미지
            return
        }

        DispatchQueue.global(qos: .background).async { [weak self] in
            if let imageData = try? Data(contentsOf: profileImageURL),
               let downloadedImage = UIImage(data: imageData) {
                DispatchQueue.main.async {
                    self?.contactAddView.profileImageView.image = downloadedImage
                }
            } else {
                DispatchQueue.main.async {
                    print("이미지를 로드하는 데 실패했습니다.")
                    self?.contactAddView.profileImageView.image = UIImage(named: "ProfileImage") // 기본 이미지
                }
            }
        }
    }
    
    func makeRandomPokemonImage() {
        var randomNumber = Int.random(in: (1...1000))
        
        PokemonImageService.fetchPokemonData(pokemonID: randomNumber) { [weak self] (result: Result<PokemonImageModel, Error>) in
            switch result {
            case .success(let pokemon):
                self?.pokemonImageURL = pokemon.sprites.front_default
//                let contactAddViewController = ContactAddViewController()
//                contactAddViewController.pokemon = pokemon // 전달
                //self?.navigationController?.pushViewController(contactAddViewController, animated: true)
                
//                DispatchQueue.main.async {
//                    self?.contactAddView.profileImageView.reloadData()
//                }
                
            case .failure(let error):
                print("Error fetching Pokémon data: \(error.localizedDescription)")
            }
        }
    }
    
    @objc private func saveButtonTapped() {
    }
    
    @objc func randomChangeButtonTapped(_ sender: UIButton) {
        makeRandomPokemonImage()
        setProfileImage()
    }
}
