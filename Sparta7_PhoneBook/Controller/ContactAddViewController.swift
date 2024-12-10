//
//  ContactAddViewController.swift
//  Sparta7_PhoneBook
//
//  Created by seohuibaek on 12/10/24.
//
import UIKit

class ContactAddViewController: UIViewController {
    private let contactAddView = ContactAddView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = contactAddView
        
        navigationItem.title = "Information"
        
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveButtonTapped))
        
        navigationItem.rightBarButtonItem = saveButton
        
//        let BackButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveButtonTapped))
//        
//        navigationItem.rightBarButtonItem = saveButton
    }
    
    @objc private func saveButtonTapped() {
    }
}
