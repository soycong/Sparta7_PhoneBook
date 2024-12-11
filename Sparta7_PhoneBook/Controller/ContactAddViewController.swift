//
//  ContactAddViewController.swift
//  Sparta7_PhoneBook
//
//  Created by seohuibaek on 12/10/24.
//
import UIKit
import CoreData
import Alamofire

class ContactAddViewController: UIViewController {
    private let contactAddView = ContactAddView()

    var pokemon: PokemonImageModel?
    var pokemonImageURL: String?

    let phoneBookManager = PhoneBookDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = contactAddView
        
        configureNavigationBar()
        makeRandomPokemonImage()

    }

    func configureNavigationBar() {
        navigationItem.title = "Information"
        
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveButtonTapped))
        navigationItem.rightBarButtonItem = saveButton
    }
    
    func setProfileImage(from urlString: String) {
        guard let url = URL(string: urlString) else {
            print("유효하지 않은 URL입니다.")
            return
        }
        
        AF.download(url).responseData { response in
            if let data = response.value, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.contactAddView.profileImageView.image = image
                }
            } else {
                DispatchQueue.main.async {
                    print("이미지 로드 실패")
                }
            }
        }
    }
    
    func makeRandomPokemonImage() {
        PokemonImageService.fetchPokemonData() { [weak self] (result: Result<PokemonImageModel, Error>) in
            switch result {
            case .success(let pokemon):
                self?.pokemonImageURL = pokemon.sprites.front_default
                self?.setProfileImage(from: self?.pokemonImageURL ?? "") // 이미지 설정
                
            case .failure(let error):
                print("Error fetching Pokémon data: \(error.localizedDescription)")
            }
        }
    }

    @objc private func saveButtonTapped() {
        guard let name = contactAddView.nameTextView.text,
              let phoneNumber = contactAddView.numberTextView.text,
              let profileImageURL = pokemonImageURL else {
            print("데이터가 비어 있습니다.")
            return
        }
        
        phoneBookManager.createData(name: name, phoneNumber: phoneNumber, profileImageURL: profileImageURL)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func randomChangeButtonTapped(_ sender: UIButton) {
        makeRandomPokemonImage()
    }
}
