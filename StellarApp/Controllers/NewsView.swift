//
//  NewsView.swift
//  StellarApp
//
//  Created by Ramu on 4/11/19.
//  Copyright © 2019 TingxinLi. All rights reserved.
//

import UIKit

class NewsView: UIView {

    lazy var newsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let ncv = UICollectionView.init(frame: self.bounds, collectionViewLayout: layout)
        ncv.backgroundColor = .clear
        ncv.register(NewsCollectionViewCell.self, forCellWithReuseIdentifier: "NewsCell")
        return ncv
    }()
    

    override init(frame: CGRect) {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        setConstraints()
        
    
    }
    
    func setConstraints() {
        self.addSubview(newsCollectionView)
        newsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        newsCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        newsCollectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        newsCollectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        newsCollectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
}

