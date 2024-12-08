//
//  CustomCollectionViewCell.swift
//  iOS Mini Project
//
//  Created by Muhammad Afif Fadhlurrahman on 05/12/24.
//
import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    static let identifier = "CustomCollectionViewCell"
    var url: String?

    private let myImageView: UIImageView = UIImageView()
    private let mealName: UILabel = UILabel()
    private let mealAreaLabel: UILabel = UILabel()
    private lazy var mealAreaView: UIView = createLabelAreaView()
    
    public func configure(with imageURL: URL?, mealName: String, mealArea: String){
        guard let imageURL else {
            return
        }
        self.myImageView.load(url: imageURL)
        self.mealName.text = mealName
        self.mealAreaLabel.text = mealArea
        self.mealAreaLabel.font = UIFont.systemFont(ofSize: 14)
        self.setupUI()
    }
    
    public func setupUI(){
        self.backgroundColor = UIColor.systemGray6
        self.layer.borderColor = UIColor.systemGray4.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 10
        
        self.myImageView.layer.cornerRadius = 10
        self.myImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.myImageView.layer.masksToBounds = true
        
        self.addSubview(myImageView)
        self.addSubview(mealName)
        self.addSubview(mealAreaView)
        
        myImageView.translatesAutoresizingMaskIntoConstraints = false
        mealName.translatesAutoresizingMaskIntoConstraints = false
        mealAreaView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            myImageView.topAnchor.constraint(equalTo: self.topAnchor),
            myImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            myImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            mealName.topAnchor.constraint(equalTo: self.myImageView.bottomAnchor, constant: 10),
            mealName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            mealName.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            mealName.heightAnchor.constraint(greaterThanOrEqualToConstant: 20),
            
            mealAreaView.topAnchor.constraint(equalTo: self.mealName.bottomAnchor, constant: 8),
            mealAreaView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            mealAreaView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            mealAreaView.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor)
        ])
        
        mealName.font = .boldSystemFont(ofSize: 16)
        mealName.numberOfLines = 0
        mealName.lineBreakMode = .byWordWrapping
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.myImageView.image = nil
        self.mealName.text = nil
    }
}

private extension CustomCollectionViewCell {
    func createLabelAreaView() -> UIView {
        let areaView: UIView = UIView()
        areaView.layer.cornerRadius = 7.0
        areaView.backgroundColor = .lightGray
        areaView.addSubview(mealAreaLabel)
        
        mealAreaLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mealAreaLabel.topAnchor.constraint(equalTo: areaView.topAnchor),
            mealAreaLabel.bottomAnchor.constraint(equalTo: areaView.bottomAnchor),
            mealAreaLabel.leadingAnchor.constraint(equalTo: areaView.leadingAnchor, constant: 10),
            mealAreaLabel.trailingAnchor.constraint(equalTo: areaView.trailingAnchor, constant: -10),
        ])
        
        return areaView
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
