//
//  Card.swift
//  iOS Mini Project
//
//  Created by Muhammad Afif Fadhlurrahman on 03/12/24.
//
import UIKit

class MenuCard: UIView {
    var widthCard: CGFloat!
    var heightCard: CGFloat!
    
    private let vstack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.backgroundColor = .systemGray5
        //stack.alignment = .leading
        return stack
    } ()
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "Hello World"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    let label2: UILabel = {
        let label = UILabel()
        label.text = "Hello World2"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    let image: UIImageView = {
        let image = UIImage(systemName: "photo")!
        let view = UIImageView(image: image)
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    } ()
    
    // Custom initializer
    init(widthCard: CGFloat, heightCard: CGFloat) {
        self.widthCard = widthCard
        self.heightCard = heightCard
        super.init(frame: .zero)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        // Add image and label to stack view
        self.vstack.addArrangedSubview(image)
        self.vstack.addArrangedSubview(label)
        self.vstack.addArrangedSubview(label2)
        
        // Add stack view to the main view
        self.addSubview(vstack)
       
        // Set up constraints
        NSLayoutConstraint.activate([
            image.heightAnchor.constraint(equalToConstant: self.heightCard ?? 50),
            image.widthAnchor.constraint(equalToConstant: self.widthCard ?? 50),
            
            vstack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            vstack.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
        ])
    }
}

