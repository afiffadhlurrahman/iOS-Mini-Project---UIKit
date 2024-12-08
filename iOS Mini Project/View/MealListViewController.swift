//
//  MealListViewController1.swift
//  iOS Mini Project
//
//  Created by Muhammad Afif Fadhlurrahman on 05/12/24.
//

import UIKit

class MealListViewController: UIViewController {
    private let viewModel = MealListViewModel()
    private var collectionView: UICollectionView!
    private var areaFilterView: UICollectionView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        Task {
            do {
                // Fetch meals and areas
                try await viewModel.getMeals(searchQuery: "")
                
                // Reload both the meals list and filter list
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    self.areaFilterView.reloadData()
                }
            } catch {
                print("Error fetching meals: \(error)")
            }
        }
    }
    
    // MARK: - UI Configuration
    
    private func configureUI() {
        setupAreaFilterView()
        setupCollectionView()
    }
    
    private func setupAreaFilterView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        areaFilterView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        areaFilterView.register(AreaFilterCell.self, forCellWithReuseIdentifier: AreaFilterCell.identifier)
        areaFilterView.dataSource = self
        areaFilterView.delegate = self
        view.addSubview(areaFilterView)
        
        // Layout Constraints for area filter
        areaFilterView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            areaFilterView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            areaFilterView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            areaFilterView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            areaFilterView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        
        // Layout Constraints for the main meal list
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: areaFilterView.bottomAnchor, constant: 10),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

// MARK: - UICollectionView DataSource and Delegate for Area Filters

extension MealListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == areaFilterView ? viewModel.availableAreas.count : viewModel.filteredMeals.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == areaFilterView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AreaFilterCell.identifier, for: indexPath) as! AreaFilterCell
            let area = viewModel.availableAreas[indexPath.row]
            let isSelected = viewModel.selectedAreas.contains(area)
            cell.configure(with: area, isSelected: isSelected)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as! CustomCollectionViewCell
            let meal = viewModel.filteredMeals[indexPath.row]
            cell.configure(with: meal.mealThumb, mealName: meal.mealName, mealArea: meal.area)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == areaFilterView {
            let selectedArea = viewModel.availableAreas[indexPath.row]
            viewModel.toggleAreaSelection(selectedArea)
            collectionView.reloadData() // Reload filter view to show selection
            self.collectionView.reloadData() // Reload meal list to apply filtering
        }
    }
}

// MARK: - UICollectionViewFlowLayout

extension MealListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == areaFilterView {
            return CGSize(width: 100, height: 40)
        } else {
            return CGSize(width: view.frame.width * 0.42, height: view.frame.height * 0.3)
        }
    }
}
