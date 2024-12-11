//
//  ContactAddViewController.swift
//  Sparta7_PhoneBook
//
//  Created by seohuibaek on 12/10/24.
//
import UIKit
import CoreData

class ContactAddViewController: UIViewController {
    private let contactAddView = ContactAddView()
    
    var container: NSPersistentContainer!
    
    var pokemon: PokemonImageModel?
    var pokemonImageURL: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = contactAddView
        
        navigationItem.title = "Information"
        
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveButtonTapped))
        
        navigationItem.rightBarButtonItem = saveButton
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.container = appDelegate.persistentContainer
        
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
    
    func createData(name: String, phoneNumber: String) {
        guard let entity = NSEntityDescription.entity(forEntityName: PhoneBook.className, in: self.container.viewContext) else { return }
        let newPhoneBook = NSManagedObject(entity: entity, insertInto: self.container.viewContext)
        newPhoneBook.setValue(name, forKey: PhoneBook.Key.name)
        newPhoneBook.setValue(phoneNumber, forKey: PhoneBook.Key.number)
        
        do {
            try self.container.viewContext.save()
            print("문맥 저장 성공")
        } catch {
            print("문맥 저장 실패")
        }
    }
    
    func readAllData() {
        do {
            let phoneBooks = try self.container.viewContext.fetch(PhoneBook.fetchRequest())
            
            for phoneBook in phoneBooks as [NSManagedObject] {
                if let name = phoneBook.value(forKey: PhoneBook.Key.name) as? String,
                   let phoneNumber = phoneBook.value(forKey: PhoneBook.Key.number) {
                    print("name: \(name), phoneNumber: \(phoneNumber)")
                }
            }
        } catch {
            print("데이터 읽기 실패")
        }
    }
    
    @objc private func saveButtonTapped() {
        guard let name = contactAddView.nameTextView.text,
              let phoneNumber = contactAddView.numberTextView.text else {
            print("이름 또는 전화번호가 비어 있습니다.")
            return
        }
        createData(name: name, phoneNumber: phoneNumber)
        readAllData()
    }
    
    @objc func randomChangeButtonTapped(_ sender: UIButton) {
        makeRandomPokemonImage()
        setProfileImage()
    }
}
