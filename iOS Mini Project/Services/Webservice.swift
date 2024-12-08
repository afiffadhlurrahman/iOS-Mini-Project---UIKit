//
//  Webservice.swift
//  iOS Mini Project
//
//  Created by Muhammad Afif Fadhlurrahman on 04/12/24.
//

import Foundation

enum MealsError: Error {
    case invalidServerResponse
}

class Webservice {
    func getMeals(searchQuery: String) async throws -> [Meal] {
        // Create the URL by appending the search query to the base URL
        guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/search.php?s=\(searchQuery)") else {
            throw MealsError.invalidServerResponse
        }

        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw MealsError.invalidServerResponse
        }

        let temp = try JSONDecoder().decode(MealContainer.self, from: data)
        return temp.meals
    }
}
