//
//  HomepageViewController.swift
//  iOS Mini Project
//
//  Created by Muhammad Afif Fadhlurrahman on 03/12/24.
//

import UIKit

class HomepageViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    //private let foods = ["Chicken 1", "Chicken 2", "Chicken 3", "Chicken 4",]
    //private var foodsTableView: UITableView!
    private let images: [UIImage] = [
        UIImage(systemName: "figure.walk.motion")!,
        UIImage(systemName: "figure.walk.motion")!,
        UIImage(systemName: "figure.walk.motion")!,
        UIImage(systemName: "figure.walk.motion")!,
    ]
    
//    override func loadView() {
//        super.loadView()
//        view.backgroundColor = .systemBackground
//        title = "Choose Your Menu"
//        navigationController?.navigationBar.prefersLargeTitles = true
        
//        let barHeight: CGFloat = view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
//        let displayWidth: CGFloat = self.view.frame.width
//        let displayHeight: CGFloat = self.view.frame.height
//        
//        foodsTableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
//        foodsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
//        foodsTableView.dataSource = self
//        foodsTableView.delegate = self
//        self.view.addSubview(foodsTableView)

//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    // MARK: Setup UI
    private func setupUI() {
        self.view.backgroundColor = .blue
        self.title = "Choose Your Menu"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
        
        //self.view.addSubview(MenuCard())
    }
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.allowsSelection = true
        tableView.register(CustomCell.self, forCellReuseIdentifier: CustomCell.identifier)
        return tableView
    }()
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("Num: \(indexPath.row)")
//        print("Value: \(foods[indexPath.row])")
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return foods.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
//        cell.textLabel!.text = "\(foods[indexPath.row])"
//        return cell
//    }
}

extension HomepageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier, for: indexPath) as? CustomCell else {
            fatalError("The Table View is cannot dequeue a custom cell.")
        }
        //cell.textLabel?.text = indexPath.row.description
        let image = self.images[indexPath.row]
        cell.configure(with: image, and: indexPath.row.description)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.bounds.height * 0.3
    }
    
    
//    func tableView(_ tableView: UITableView, widthForRowAt indexPath: IndexPath) -> CGFloat {
//        return view.bounds.width * 1
//    }
}
