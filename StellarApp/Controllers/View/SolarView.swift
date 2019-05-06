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
//        mySwitch.onImage = UIImage(named: "icons8-news-25")
//        mySwitch.offImage = UIImage(named: "icons8-planet-25")
       
        return mySwitch
    }()
    
//    public lazy var switchButton: UIButton = {
//        let switchButton = UIButton(type: .custom)
//        switchButton.isSelected = true
//        switchButton.setImage(UIImage(named: "icons8-news-25"), for: .selected)
//        switchButton.setImage(UIImage(named: "icons8-planet-25"), for: .normal)
//        return switchButton
//    }()
    public lazy var resetButton: UIButton = {
        let resetButton = UIButton()
        resetButton.setImage(UIImage(named: "reset"), for: .normal)
        return resetButton
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
        setResetConstraints()
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
//        addSubview(switchButton)
//        switchButton.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            switchButton.topAnchor.constraint(equalTo: playButton.bottomAnchor, constant: 10),
//            switchButton.centerXAnchor.constraint(equalTo: playButton.centerXAnchor),
//            switchButton.bottomAnchor.constraint(equalTo: bottomAnchor)
//            ])
    }
    
    func setResetConstraints(){
        addSubview(resetButton)
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            resetButton.topAnchor.constraint(equalTo: mySwitch.bottomAnchor, constant: 10),
            resetButton.centerXAnchor.constraint(equalTo: mySwitch.centerXAnchor),
            resetButton.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }

}


