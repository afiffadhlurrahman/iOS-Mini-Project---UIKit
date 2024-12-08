//
//  MealsListViewModel.swift
//  iOS Mini Project
//
//  Created by Muhammad Afif Fadhlurrahman on 04/12/24.
//

import Foundation

class MealListViewModel {
    private(set) var meals: [MealDataModel] = []
    
    func updateMeals(_ newMeals: [MealDataModel]) {
        self.meals = newMeals
    }
    
    func getMeals(searchQuery: String) async throws -> [Meal] {
        let urlString = "https://www.themealdb.com/api/json/v1/1/search.php?s=\(searchQuery)"
        guard let url = URL(string: urlString) else {
            throw MealsError.invalidServerResponse
        }

        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw MealsError.invalidServerResponse
        }

        let temp = try JSONDecoder().decode(MealContainer.self, from: data)
        return temp.meals
    }
}


struct MealDataModel {
    private let meal: Meal
    
    init(meal: Meal) {
        self.meal = meal
    }
    
    var mealName: String {
        meal.mealName
    }
    
    var mealThumb: URL?{
        URL(string: meal.mealThumb)
    }
    
    var category: String {
        meal.category
    }
    
    var area: String {
        meal.area
    }
    
    var instruction: String {
        meal.instruction
    }
    
    var mealYoutube: URL? {
        URL(string: meal.youtube)
    }
    
    var measure1: String? {
        meal.measure1
    }

    var ingredient1: String? {
        meal.ingredient1
    }

    var measure2: String? {
        meal.measure2
    }

    var ingredient2: String? {
        meal.ingredient2
    }

    var measure3: String? {
        meal.measure3
    }

    var ingredient3: String? {
        meal.ingredient3
    }

    var measure4: String? {
        meal.measure4
    }

    var ingredient4: String? {
        meal.ingredient4
    }

    var measure5: String? {
        meal.measure5
    }

    var ingredient5: String? {
        meal.ingredient5
    }

    var measure6: String? {
        meal.measure6
    }

    var ingredient6: String? {
        meal.ingredient6
    }

    var measure7: String? {
        meal.measure7
    }

    var ingredient7: String? {
        meal.ingredient7
    }

    var measure8: String? {
        meal.measure8
    }

    var ingredient8: String? {
        meal.ingredient8
    }

    var measure9: String? {
        meal.measure9
    }

    var ingredient9: String? {
        meal.ingredient9
    }

    var measure10: String? {
        meal.measure10
    }

    var ingredient10: String? {
        meal.ingredient10
    }

    var measure11: String? {
        meal.measure11
    }

    var ingredient11: String? {
        meal.ingredient11
    }

    var measure12: String? {
        meal.measure12
    }

    var ingredient12: String? {
        meal.ingredient12
    }

    var measure13: String? {
        meal.measure13
    }

    var ingredient13: String? {
        meal.ingredient13
    }

    var measure14: String? {
        meal.measure14
    }

    var ingredient14: String? {
        meal.ingredient14
    }

    var measure15: String? {
        meal.measure15
    }

    var ingredient15: String? {
        meal.ingredient15
    }

    var measure16: String? {
        meal.measure16
    }

    var ingredient16: String? {
        meal.ingredient16
    }

    var measure17: String? {
        meal.measure17
    }

    var ingredient17: String? {
        meal.ingredient17
    }

    var measure18: String? {
        meal.measure18
    }

    var ingredient18: String? {
        meal.ingredient18
    }

    var measure19: String? {
        meal.measure19
    }

    var ingredient19: String? {
        meal.ingredient19
    }

    var measure20: String? {
        meal.measure20
    }

    var ingredient20: String? {
        meal.ingredient20
    }
}
