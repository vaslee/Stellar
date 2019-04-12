//
//  NewsCollectionViewCell.swift
//  StellarApp
//
//  Created by Ramu on 4/11/19.
//  Copyright © 2019 TingxinLi. All rights reserved.
//

import UIKit

class NewsCollectionViewCell: UICollectionViewCell {
    
    public lazy var solarImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "placeholder-image"))
        image.clipsToBounds = true
        return image
    }()
    
    public lazy var solarDescription: UITextView = {
        let description = UITextView()
        description.text = "This solar system is mercury"
        description.textColor = .black
        description.backgroundColor = .blue
        return description
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSolarImage()
        setupDescription()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSolarImage() {
        addSubview(solarImage)
        solarImage.translatesAutoresizingMaskIntoConstraints = false
        solarImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        solarImage.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        solarImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -28).isActive = true
        solarImage.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.38).isActive = true
        
    }
    
    private func setupDescription() {
        addSubview(solarDescription)
        solarDescription.translatesAutoresizingMaskIntoConstraints = false
        solarDescription.leadingAnchor.constraint(equalTo: solarImage.trailingAnchor, constant: 30).isActive = true
        solarDescription.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        solarDescription.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -28).isActive = true
        solarDescription.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
    }

}
