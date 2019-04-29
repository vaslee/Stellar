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
        label.text = "SAMPLE"
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.95
        label.textColor = .white
        return label
    }()
    
    public lazy var articleDescription: UILabel = {
        let description = UILabel()
        description.numberOfLines = 0
        description.text = "This solar system is mercury"
        description.textColor = .white
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
        articleImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        articleImage.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        articleImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -28).isActive = true
        articleImage.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.38).isActive = true
        
    }
    
    private func setupLabel() {
        addSubview(articleLabel)
        articleLabel.translatesAutoresizingMaskIntoConstraints = false
        articleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 3).isActive = true
       articleLabel.leadingAnchor.constraint(equalTo: articleImage.trailingAnchor, constant: 30).isActive = true
        articleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        articleLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.18).isActive = true
        
    }
    
    private func setupDescription() {
        addSubview(articleDescription)
        articleDescription.translatesAutoresizingMaskIntoConstraints = false
        articleDescription.leadingAnchor.constraint(equalTo: articleImage.trailingAnchor, constant: 30).isActive = true
        articleDescription.topAnchor.constraint(equalTo: articleLabel.bottomAnchor, constant: 8).isActive = true
        articleDescription.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -28).isActive = true
        articleDescription.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
    }

}
