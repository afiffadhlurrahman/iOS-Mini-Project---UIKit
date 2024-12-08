//
//  AreaFilterCell.swift
//  iOS Mini Project
//
//  Created by Muhammad Afif Fadhlurrahman on 09/12/24.
//

import UIKit

class AreaFilterCell: UICollectionViewCell {
    static let identifier = "AreaFilterCell"
    
    private let areaLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(areaLabel)
        setupConstraints()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            areaLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            areaLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
    
    private func setupUI() {
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.white.cgColor
        contentView.backgroundColor = .systemBlue
    }
    
    func configure(with area: String, isSelected: Bool) {
        areaLabel.text = area
        contentView.backgroundColor = isSelected ? .systemGreen : .systemBlue
    }
}
