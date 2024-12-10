//
//  ViewController.swift
//  Sparta7_PhoneBook
//
//  Created by seohuibaek on 12/10/24.
//

import UIKit

class ViewController: UIViewController {
    private let mainTableView = MainTableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view = mainTableView
    }
}

@available(iOS 17.0, *)
#Preview {
    ViewController()
}
