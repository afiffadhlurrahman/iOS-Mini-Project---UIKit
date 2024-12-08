//
//  MealsViewController.swift
//  iOS Mini Project
//
//  Created by Muhammad Afif Fadhlurrahman on 04/12/24.
//

//import Foundation
//import UIKit
//
//class MealListViewController: UITableViewController {
//    private let vm = MealListViewModel()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        configureUI()
//        Task {
//            await populateMeals()
//        }
//    }
//    
//    private func configureUI(){
//        self.navigationController?.navigationBar.prefersLargeTitles = true
//        self.title = "Meals"
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MealCell")
//    }
//    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        vm.meals.count
//    }
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "MealCell", for: indexPath)
//        let meal = vm.meals[indexPath.row]
//        
//        var content = cell.defaultContentConfiguration()
//        content.text = meal.mealName
//        content.secondaryText = meal.area
//        cell.contentConfiguration = content
//        
//        return cell
//    }
//    
//    private func populateMeals() async {
//        await vm.populateMeals(url: Constants.Urls.allMeals!)
//        DispatchQueue.main.async { [weak self] in
//            self?.tableView.reloadData()
//        }
//    }
//}
