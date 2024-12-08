//
//  CustomCell.swift
//  iOS Mini Project
//
//  Created by Muhammad Afif Fadhlurrahman on 03/12/24.
//

import UIKit

class CustomCell: UITableViewCell {

    static let identifier = "CustomCell"
    
    private let myImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.image = UIImage(systemName: "questionmark")
        iv.tintColor = .label
        return iv
    }()
    
    private let myLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .label
        lbl.textAlignment = .left
        lbl.font = .systemFont(ofSize: 24, weight: .medium)
        lbl.text = "ERROr"
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with image: UIImage, and label: String){
        self.myImageView.image = image
        self.myLabel.text = label
    }
    
    private func setupUI() {
        self.contentView.addSubview(myImageView)
        self.contentView.addSubview(myLabel)
        
        myImageView.translatesAutoresizingMaskIntoConstraints = false
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            myImageView.topAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.topAnchor),
            myImageView.bottomAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.bottomAnchor),
            myImageView.leadingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.leadingAnchor),
            
            myImageView.widthAnchor.constraint(equalToConstant: 90),
            
            myLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 60),
            myLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            myLabel.topAnchor.constraint(equalTo: self.myImageView.bottomAnchor),
            myLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
        ])
    }
}
