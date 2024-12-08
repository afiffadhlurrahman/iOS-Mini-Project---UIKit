//
//  DetailMenuViewController.swift
//  iOS Mini Project
//
//  Created by Muhammad Afif Fadhlurrahman on 08/12/24.
//

import UIKit

class DetailMenuViewController: UIViewController {
    
    var mealThumb: String?
    var mealName: String?
    var mealArea: String?
    var mealIngredients: [String] = [] 
    var mealIngredient1: String?
    var mealInstruction: String?
    var mealYoutube: String?

    private let scrollView = UIScrollView()
    private let contentView = UIView()

    private let imageView = UIImageView()
    private let nameLabel = UILabel()
    private let areaLabel = UILabel()
    private lazy var areaLabelView: UIView = createLabelAreaView()
    
    private let ingredientHeader = UILabel()
    private let ingredientsLabel = UILabel()
    
    private let instructionHeader = UILabel()
    private let instruction = UILabel()
    
    private let availableOnYoutube = UILabel()
    private let youtubeSymbolView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
        setupData()
    }
    
    private func configureUI() {
        self.title = mealName
        
        // Add the scrollView and contentView
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        // Add UI elements to the contentView
        contentView.addSubview(imageView)
        contentView.addSubview(areaLabelView)
        contentView.addSubview(ingredientHeader)
        contentView.addSubview(ingredientsLabel)
        contentView.addSubview(instructionHeader)
        contentView.addSubview(instruction)
        contentView.addSubview(availableOnYoutube)
        contentView.addSubview(youtubeSymbolView)
        
        // Enable scrolling
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        areaLabelView.translatesAutoresizingMaskIntoConstraints = false
        ingredientHeader.translatesAutoresizingMaskIntoConstraints = false
        ingredientsLabel.translatesAutoresizingMaskIntoConstraints = false
        instructionHeader.translatesAutoresizingMaskIntoConstraints = false
        instruction.translatesAutoresizingMaskIntoConstraints = false
        availableOnYoutube.translatesAutoresizingMaskIntoConstraints = false
        youtubeSymbolView.translatesAutoresizingMaskIntoConstraints = false
        
        ingredientsLabel.numberOfLines = 0
        ingredientsLabel.lineBreakMode = .byWordWrapping
        
        instruction.numberOfLines = 0
        instruction.lineBreakMode = .byWordWrapping
        
        // Set constraints for scrollView and contentView
        NSLayoutConstraint.activate([
            // Scroll view constraints
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // Content view constraints (inside the scroll view)
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            // UI Elements constraints
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 400),
            imageView.heightAnchor.constraint(equalToConstant: 400),
            
            areaLabelView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            areaLabelView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            ingredientHeader.topAnchor.constraint(equalTo: areaLabelView.bottomAnchor, constant: 10),
            ingredientHeader.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            ingredientsLabel.topAnchor.constraint(equalTo: ingredientHeader.bottomAnchor, constant: 10),
            ingredientsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            instructionHeader.topAnchor.constraint(equalTo: ingredientsLabel.bottomAnchor, constant: 20),
            instructionHeader.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            instruction.topAnchor.constraint(equalTo: instructionHeader.bottomAnchor, constant: 10),
            instruction.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            instruction.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            availableOnYoutube.topAnchor.constraint(equalTo: instruction.bottomAnchor, constant: 20),
            // availableOnYoutube.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            availableOnYoutube.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            youtubeSymbolView.topAnchor.constraint(equalTo: instruction.bottomAnchor, constant: 10),
            youtubeSymbolView.leadingAnchor.constraint(equalTo: availableOnYoutube.trailingAnchor, constant: 20),
            youtubeSymbolView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            youtubeSymbolView.widthAnchor.constraint(equalToConstant: 40),
            youtubeSymbolView.heightAnchor.constraint(equalToConstant: 40),
        ])
        
        // Set fonts
        ingredientHeader.font = .systemFont(ofSize: 18, weight: .bold)
        ingredientsLabel.font = .systemFont(ofSize: 14)
        instructionHeader.font = .systemFont(ofSize: 18, weight: .bold)
        instruction.font = .systemFont(ofSize: 14)
        availableOnYoutube.font = .systemFont(ofSize: 18, weight: .bold)
        
        // Add tap gesture to the YouTube symbol
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openYouTubeLink))
        youtubeSymbolView.isUserInteractionEnabled = true
        youtubeSymbolView.addGestureRecognizer(tapGesture)
    }
    
    private func setupData() {
        // Assign the data to UI elements
        if let mealThumb = mealThumb, let url = URL(string: mealThumb) {
            // Load image asynchronously (you can use libraries like SDWebImage)
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        self.imageView.image = UIImage(data: data)
                    }
                }
            }
        }
        
        areaLabel.text = mealArea
        ingredientHeader.text = "Ingredients"
        ingredientsLabel.text = mealIngredients.joined(separator: "\n")
        instructionHeader.text = "Instructions"
        instruction.text = mealInstruction
        availableOnYoutube.text = "Available on Youtube"
        youtubeSymbolView.image = UIImage(named: "youtube_symbol")
    }
    
    // Handle YouTube link tap
    @objc func openYouTubeLink() {
        if let youtubeLink = mealYoutube, let url = URL(string: youtubeLink) {
            UIApplication.shared.open(url)
        }
    }
}

private extension DetailMenuViewController {
    func createLabelAreaView() -> UIView {
        let areaView: UIView = UIView()
        areaView.layer.cornerRadius = 7.0
        areaView.backgroundColor = .lightGray
        areaView.addSubview(areaLabel)
        
        areaLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            areaLabel.topAnchor.constraint(equalTo: areaView.topAnchor, constant: 4),
            areaLabel.bottomAnchor.constraint(equalTo: areaView.bottomAnchor, constant: -4),
            areaLabel.leadingAnchor.constraint(equalTo: areaView.leadingAnchor, constant: 20),
            areaLabel.trailingAnchor.constraint(equalTo: areaView.trailingAnchor, constant: -20),
        ])
        
        return areaView
    }
}
