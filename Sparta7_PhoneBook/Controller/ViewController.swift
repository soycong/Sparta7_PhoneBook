//
//  ViewController.swift
//  Sparta7_PhoneBook
//
//  Created by seohuibaek on 12/10/24.
//

import UIKit
import Alamofire
import CoreData

class ViewController: UIViewController {
    private let mainTableView = MainTableView()
    let phoneBookManager = PhoneBookDataManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = mainTableView
        
        configureNavigationBar()
        
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    
    func configureNavigationBar() {
        navigationItem.title = "Pokemon"
        
        let addButton = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }
    
    func loadData() {
        let phoneBooks = phoneBookManager.readData()
        mainTableView.updateData(phoneBooks)
    }
    
    @objc private func addButtonTapped() {
        // 이 부분 수정하기
        let contactAddViewController = ContactAddViewController()
        //contactAddViewController.makeRandomPokemonImage()
        //contactAddViewController.makeRandomPokemonImageAndSetProfile()

        navigationController?.pushViewController(contactAddViewController, animated: true)
    }
}

//@available(iOS 17.0, *)
//#Preview {
//    ContactAddViewController()
//}
