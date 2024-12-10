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
        
        setProfileImage()
        
//        let BackButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveButtonTapped))
//        navigationItem.rightBarButtonItem = saveButton
    }
    
    func setProfileImage() {
        guard let imageURLString = pokemon?.sprites.front_default,
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
    
    @objc private func saveButtonTapped() {
    }
}
