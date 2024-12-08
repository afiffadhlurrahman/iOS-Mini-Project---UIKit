//
//  Food.swift
//  iOS Mini Project
//
//  Created by Muhammad Afif Fadhlurrahman on 04/12/24.
//

import Foundation

struct Meal: Decodable {
    let mealName: String        // Meal Name, ex: `Chicken Handi`
    let mealThumb: String       // Meal Image, ex: `https://www.themealdb.com/images/media/meals/wyxwsp1486979827.jpg`
    let category: String        // Meal Category  ex: `Chicken`
    let area: String            // Meal Area ex: `Indian`
    let instruction: String     // Meal Instruction ex: `Take a large pot or wok, big enough to cook all the chicken...`
    let youtube: String
    let measure1: String?        // Meal Measure ex: `1.2 kg`
    let ingredient1: String?     // Meal Ingredient ex: `Chicken`
    let measure2: String?
    let ingredient2: String?
    let measure3: String?
    let ingredient3: String?
    let measure4: String?
    let ingredient4: String?
    let measure5: String?
    let ingredient5: String?
    let measure6: String?
    let ingredient6: String?
    let measure7: String?
    let ingredient7: String?
    let measure8: String?
    let ingredient8: String?
    let measure9: String?
    let ingredient9: String?
    let measure10: String?
    let ingredient10: String?
    let measure11: String?
    let ingredient11: String?
    let measure12: String?
    let ingredient12: String?
    let measure13: String?
    let ingredient13: String?
    let measure14: String?
    let ingredient14: String?
    let measure15: String?
    let ingredient15: String?
    let measure16: String?
    let ingredient16: String?
    let measure17: String?
    let ingredient17: String?
    let measure18: String?
    let ingredient18: String?
    let measure19: String?
    let ingredient19: String?
    let measure20: String?
    let ingredient20: String?

    enum CodingKeys: String, CodingKey {
        case mealName = "strMeal"
        case mealThumb = "strMealThumb"
        case category = "strCategory"
        case area = "strArea"
        case instruction = "strInstructions"
        case youtube = "strYoutube"
        case measure1 = "strMeasure1"
        case ingredient1 = "strIngredient1"
        case measure2 = "strMeasure2"
        case ingredient2 = "strIngredient2"
        case measure3 = "strMeasure3"
        case ingredient3 = "strIngredient3"
        case measure4 = "strMeasure4"
        case ingredient4 = "strIngredient4"
        case measure5 = "strMeasure5"
        case ingredient5 = "strIngredient5"
        case measure6 = "strMeasure6"
        case ingredient6 = "strIngredient6"
        case measure7 = "strMeasure7"
        case ingredient7 = "strIngredient7"
        case measure8 = "strMeasure8"
        case ingredient8 = "strIngredient8"
        case measure9 = "strMeasure9"
        case ingredient9 = "strIngredient9"
        case measure10 = "strMeasure10"
        case ingredient10 = "strIngredient10"
        case measure11 = "strMeasure11"
        case ingredient11 = "strIngredient11"
        case measure12 = "strMeasure12"
        case ingredient12 = "strIngredient12"
        case measure13 = "strMeasure13"
        case ingredient13 = "strIngredient13"
        case measure14 = "strMeasure14"
        case ingredient14 = "strIngredient14"
        case measure15 = "strMeasure15"
        case ingredient15 = "strIngredient15"
        case measure16 = "strMeasure16"
        case ingredient16 = "strIngredient16"
        case measure17 = "strMeasure17"
        case ingredient17 = "strIngredient17"
        case measure18 = "strMeasure18"
        case ingredient18 = "strIngredient18"
        case measure19 = "strMeasure19"
        case ingredient19 = "strIngredient19"
        case measure20 = "strMeasure20"
        case ingredient20 = "strIngredient20"
    }
}
