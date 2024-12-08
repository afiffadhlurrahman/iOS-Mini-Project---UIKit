//
//  ViewController.swift
//  iOS Mini Project
//
//  Created by Muhammad Afif Fadhlurrahman on 03/12/24.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let menuCard = MenuCard(widthCard: view.bounds.size.width * 0.5, heightCard: view.bounds.size.height * 0.3)
        view.backgroundColor = .white
        view.addSubview(menuCard)
        
        menuCard.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            menuCard.topAnchor.constraint(equalTo: self.view.topAnchor),
            menuCard.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            menuCard.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            menuCard.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
    }



}
