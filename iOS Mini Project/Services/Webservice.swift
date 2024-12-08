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
    func getMeals(url: URL) async throws -> [Meal] {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw MealsError.invalidServerResponse
        }

        let temp = try JSONDecoder().decode(MealContainer.self, from: data)
        return temp.meals
    }
}
