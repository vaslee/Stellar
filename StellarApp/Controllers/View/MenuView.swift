//
//  MenuView.swift
//  StellarApp
//
//  Created by TingxinLi on 4/12/19.
//  Copyright © 2019 TingxinLi. All rights reserved.
//

import UIKit

class MenuView: UIView {

    public lazy var exitButton: UIButton = {
        let button = UIButton()
        button.setTitle("Exit", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        updateData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        updateData()
    }
    
    private func updateData() {
        
        setupView()
    }
}
extension MenuView {
    private func setupView() {
        setExitButtonConstraints()
    }
    
    func setExitButtonConstraints() {
        addSubview(exitButton)
        exitButton.translatesAutoresizingMaskIntoConstraints = false
        exitButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 11).isActive = true
        exitButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -11).isActive = true
    }
}
