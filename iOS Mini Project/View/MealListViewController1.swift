//
//  MealListViewController1.swift
//  iOS Mini Project
//
//  Created by Muhammad Afif Fadhlurrahman on 05/12/24.
//

import Foundation
import UIKit

class MealListViewController1: UIViewController {
    private let vm = MealListViewModel()
    private var filteredMeals: [MealDataModel] = []
    private var isSearchActive: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
        Task {
            await populateMeals()
        }
        collectionView.dataSource = self
        collectionView.delegate = self
    }
      
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.backgroundColor = .systemBackground
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        
        return collectionView
    }()
    
    private func configureUI(){
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Meals"
        
        // Set up search bar
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Meals"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
    
        self.view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
                
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
//            collectionView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func populateMeals() async {
        await vm.populateMeals(url: Constants.Urls.allMeals!)
        DispatchQueue.main.async { [weak self] in
            self?.filteredMeals = self?.vm.meals ?? []
            self?.collectionView.reloadData()
        }
    }
    
    // Filter the meals based on the search text
    private func filterMeals(for searchText: String) {
        if searchText.isEmpty {
            filteredMeals = vm.meals
        } else {
            filteredMeals = vm.meals.filter { meal in
                return meal.mealName.lowercased().contains(searchText.lowercased())
            }
        }
        collectionView.reloadData()
    }
}

extension MealListViewController1: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        filterMeals(for: searchText)
    }
}


extension MealListViewController1: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return self.vm.meals.count
        return self.filteredMeals.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as?
                CustomCollectionViewCell else {
            fatalError("Failed to dequeue.")
        }
        
        // let selectedMeal = self.vm.meals[indexPath.row]
        let selectedMeal = self.filteredMeals[indexPath.row]

        cell.configure(with: selectedMeal.mealThumb, mealName: selectedMeal.mealName, mealArea: selectedMeal.area)
        return cell
    }
    
    // TODO: CREATE FUNC WHEN TAPPED IT WILL GO TO THE NEXT PAGE.
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedMeal = self.vm.meals[indexPath.row]
        
        // Initialize DetailMenuViewController
        let detailVC = DetailMenuViewController()
        
        // Pass the data to the detail view controller
        detailVC.mealThumb = selectedMeal.mealThumb?.absoluteString
        detailVC.mealName = selectedMeal.mealName
        detailVC.mealArea = selectedMeal.area
        detailVC.mealYoutube = selectedMeal.mealYoutube?.absoluteString
        detailVC.mealInstruction = selectedMeal.instruction
        
        // Create arrays for measurements and ingredients, only including non-nil values
        let measurements: [String?] = [
            selectedMeal.measure1,
            selectedMeal.measure2,
            selectedMeal.measure3,
            selectedMeal.measure4,
            selectedMeal.measure5,
            selectedMeal.measure6,
            selectedMeal.measure7,
            selectedMeal.measure8,
            selectedMeal.measure9,
            selectedMeal.measure10,
            selectedMeal.measure11,
            selectedMeal.measure12,
            selectedMeal.measure13,
            selectedMeal.measure14,
            selectedMeal.measure15,
            selectedMeal.measure16,
            selectedMeal.measure17,
            selectedMeal.measure18,
            selectedMeal.measure19,
            selectedMeal.measure20
        ]
        
        let ingredients: [String?] = [
            selectedMeal.ingredient1,
            selectedMeal.ingredient2,
            selectedMeal.ingredient3,
            selectedMeal.ingredient4,
            selectedMeal.ingredient5,
            selectedMeal.ingredient6,
            selectedMeal.ingredient7,
            selectedMeal.ingredient8,
            selectedMeal.ingredient9,
            selectedMeal.ingredient10,
            selectedMeal.ingredient11,
            selectedMeal.ingredient12,
            selectedMeal.ingredient13,
            selectedMeal.ingredient14,
            selectedMeal.ingredient15,
            selectedMeal.ingredient16,
            selectedMeal.ingredient17,
            selectedMeal.ingredient18,
            selectedMeal.ingredient19,
            selectedMeal.ingredient20
        ]
        
        // Remove nil values from both measurements and ingredients arrays
        let filteredMeasurements = measurements.compactMap { $0 }
        let filteredIngredients = ingredients.compactMap { $0 }
        
        // Ensure both arrays have the same length (if not, handle them accordingly)
        let combinedIngredients = combineIngredients(measurements: filteredMeasurements, ingredients: filteredIngredients)
        detailVC.mealIngredients = combinedIngredients
        
        
        // Push DetailMenuViewController onto the navigation stack
        navigationController?.pushViewController(detailVC, animated: true)
    }

    private func combineIngredients(measurements: [String?], ingredients: [String?]) -> [String] {
        var combinedIngredients = [String]()
        
        // Ensure we combine up to the shorter array length
        let count = min(measurements.count, ingredients.count)
        
        for index in 0..<count {
            // Only combine if both measurement and ingredient are non-nil and non-empty
            guard let measurement = measurements[index], !measurement.isEmpty,
                  let ingredient = ingredients[index], !ingredient.isEmpty else {
                continue // Skip if either is nil or empty
            }
            
            // Combine measurement and ingredient into a formatted string
            combinedIngredients.append("\(measurement) of \(ingredient)")
        }
        
        return combinedIngredients
    }

}

extension MealListViewController1: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let sizeWidth = (self.view.frame.width * 0.4)
        let sizeHeight = (self.view.frame.height * 0.25)
        return CGSize(width: sizeWidth, height: sizeHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
    }
}

