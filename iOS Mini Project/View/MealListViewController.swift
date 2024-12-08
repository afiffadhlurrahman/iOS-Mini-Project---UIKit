//
//  MealListViewController1.swift
//  iOS Mini Project
//
//  Created by Muhammad Afif Fadhlurrahman on 05/12/24.
//

import Foundation
import UIKit

class MealListViewController: UIViewController {
    private let viewModel = MealListViewModel()
    private var filteredMeals: [MealDataModel] = []
    
    // Search state management
    private var isSearchActive: Bool = false
    
    // MARK: - UI Elements
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        Task { await populateMeals() }
    }
    
    // MARK: - UI Configuration
    
    private func configureUI() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Choose Your Menu"
        setupSearchBar()
        setupCollectionView()
    }
    
    private func setupSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Meals"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    // MARK: - Data Fetching
    
    private func populateMeals() async {
        await fetchMeals(searchQuery: "")
    }
    
    private func fetchMeals(searchQuery: String) async {
        do {
            let meals = try await Webservice().getMeals(searchQuery: searchQuery)
            self.filteredMeals = meals.map { MealDataModel(meal: $0) }
            DispatchQueue.main.async { self.collectionView.reloadData() }
        } catch {
            print("Error fetching meals: \(error)")
        }
    }
    
    // MARK: - Meal Filtering
    
    private func filterMeals(for searchText: String) {
        Task { await fetchMeals(searchQuery: searchText) }
    }
    
    private func combineIngredients(measurements: [String?], ingredients: [String?]) -> [String] {
        let count = min(measurements.count, ingredients.count)
        var combinedIngredients = [String]()
        
        for index in 0..<count {
            guard let measurement = measurements[index]?.trimmingCharacters(in: .whitespacesAndNewlines), !measurement.isEmpty,
                  let ingredient = ingredients[index]?.trimmingCharacters(in: .whitespacesAndNewlines), !ingredient.isEmpty else {
                continue
            }
            combinedIngredients.append("\(measurement) of \(ingredient)")
        }
        return combinedIngredients
    }
    
    // MARK: - Navigation
    
    private func navigateToDetail(meal: MealDataModel) {
        let detailVC = DetailMenuViewController()
        detailVC.mealThumb = meal.mealThumb?.absoluteString
        detailVC.mealName = meal.mealName
        detailVC.mealArea = meal.area
        detailVC.mealYoutube = meal.mealYoutube?.absoluteString
        detailVC.mealInstruction = meal.instruction
        
        let measurements = [
            meal.measure1, meal.measure2, meal.measure3, meal.measure4, meal.measure5,
            meal.measure6, meal.measure7, meal.measure8, meal.measure9, meal.measure10,
            meal.measure11, meal.measure12, meal.measure13, meal.measure14, meal.measure15,
            meal.measure16, meal.measure17, meal.measure18, meal.measure19, meal.measure20
        ].compactMap { $0 }
        
        let ingredients = [
            meal.ingredient1, meal.ingredient2, meal.ingredient3, meal.ingredient4, meal.ingredient5,
            meal.ingredient6, meal.ingredient7, meal.ingredient8, meal.ingredient9, meal.ingredient10,
            meal.ingredient11, meal.ingredient12, meal.ingredient13, meal.ingredient14, meal.ingredient15,
            meal.ingredient16, meal.ingredient17, meal.ingredient18, meal.ingredient19, meal.ingredient20
        ].compactMap { $0 }
        
        detailVC.mealIngredients = combineIngredients(measurements: measurements, ingredients: ingredients)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

// MARK: - UISearchResultsUpdating

extension MealListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        filterMeals(for: searchText)
    }
}

// MARK: - UICollectionViewDataSource

extension MealListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredMeals.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as? CustomCollectionViewCell else {
            fatalError("Failed to dequeue cell.")
        }
        
        let selectedMeal = filteredMeals[indexPath.row]
        cell.configure(with: selectedMeal.mealThumb, mealName: selectedMeal.mealName, mealArea: selectedMeal.area)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedMeal = filteredMeals[indexPath.row]
        navigateToDetail(meal: selectedMeal)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MealListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width * 0.42, height: view.frame.height * 0.3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
}
