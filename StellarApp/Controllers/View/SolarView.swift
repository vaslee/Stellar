//
//  SolarView.swift
//  StellarApp
//
//  Created by TingxinLi on 4/18/19.
//  Copyright © 2019 TingxinLi. All rights reserved.
//

import UIKit

class SolarView: UIView {

    public lazy var playButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "play9"), for: .normal)        
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    public lazy var mySwitch: UISwitch = {
        let mySwitch = UISwitch()
        mySwitch.tintColor = UIColor.white
        mySwitch.onTintColor = UIColor.clear
        mySwitch.thumbTintColor = UIColor.white
        
        return mySwitch
    }()

    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    private func setupView() {
        setPlayButtonConstraints()
        setSwitchConstraints()
    }
    
    func setPlayButtonConstraints() {
        addSubview(playButton)
        playButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        playButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
        playButton.trailingAnchor.constraint(equalTo: trailingAnchor),
        playButton.leadingAnchor.constraint(equalTo: leadingAnchor),
        playButton.heightAnchor.constraint(equalToConstant: 60),
        playButton.widthAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    func setSwitchConstraints() {
        addSubview(mySwitch)
        mySwitch.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        mySwitch.topAnchor.constraint(equalTo: playButton.bottomAnchor, constant: 10),
        mySwitch.centerXAnchor.constraint(equalTo: playButton.centerXAnchor),
        mySwitch.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

}


