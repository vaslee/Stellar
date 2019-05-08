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
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 5
        image.clipsToBounds = true
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    public lazy var articleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 11.5)
        label.textColor = .black
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public lazy var articleDescription: UILabel = {
        let description = UILabel()
        description.numberOfLines = 2
        description.textAlignment = .left
        description.font = UIFont.boldSystemFont(ofSize: 16.0)
        description.textColor = .black
        description.translatesAutoresizingMaskIntoConstraints = false
        return description
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        articleImage.image = UIImage.init(named: "placeholder-image")
        articleLabel.text = nil
        articleDescription.text = nil
    }
    
    private func commonInit() {
       setupConstraints()
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
    }
    
    private func setupConstraints() {
        setupSolarImage()
        setupLabel()
        setupDescription()
    }
    
    private func setupSolarImage() {
        addSubview(articleImage)
        NSLayoutConstraint.activate([
            articleImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            articleImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            articleImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            articleImage.heightAnchor.constraint(equalToConstant: 220)
            ])
    }
    
    private func setupLabel() {
        addSubview(articleLabel)
        NSLayoutConstraint.activate([
            articleLabel.topAnchor.constraint(equalTo: articleImage.bottomAnchor, constant: 4),
            articleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            articleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12)
            ])
        
    }
    
    private func setupDescription() {
        addSubview(articleDescription)
        NSLayoutConstraint.activate([
            articleDescription.topAnchor.constraint(equalTo: articleLabel.bottomAnchor, constant: 4),
            articleDescription.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            articleDescription.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            
            ])
        
    }
}
