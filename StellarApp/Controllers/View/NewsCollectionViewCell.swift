//
//  NewsCollectionViewCell.swift
//  StellarApp
//
//  Created by Ramu on 4/11/19.
//  Copyright © 2019 TingxinLi. All rights reserved.
//

import UIKit

class NewsCollectionViewCell: UICollectionViewCell {
    
    public lazy var articleImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "placeholder-image"))
        image.clipsToBounds = true
        return image
    }()
    
    public lazy var articleLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .black
        return label
    }()
    
    public lazy var articleDescription: UILabel = {
        let description = UILabel()
        description.numberOfLines = 0
        description.minimumScaleFactor = 0.50
        description.font = UIFont.boldSystemFont(ofSize: 20)
        description.textColor = .black
        description.backgroundColor = .clear
        return description
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSolarImage()
        setupLabel()
        setupDescription()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSolarImage() {
        addSubview(articleImage)
        articleImage.translatesAutoresizingMaskIntoConstraints = false
        articleImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        articleImage.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.0).isActive = true
        articleImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -100).isActive = true
    }
    
    private func setupLabel() {
        addSubview(articleLabel)
        articleLabel.translatesAutoresizingMaskIntoConstraints = false
        articleLabel.topAnchor.constraint(equalTo: articleImage.bottomAnchor, constant: 2).isActive = true
        articleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 9).isActive = true
        articleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -9).isActive = true
    }
    
    private func setupDescription() {
        addSubview(articleDescription)
        articleDescription.translatesAutoresizingMaskIntoConstraints = false
        articleDescription.topAnchor.constraint(equalTo: articleLabel.bottomAnchor, constant: 2).isActive = true
        articleDescription.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 9).isActive = true
        articleDescription.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -9).isActive = true
        articleDescription.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
    }

}
