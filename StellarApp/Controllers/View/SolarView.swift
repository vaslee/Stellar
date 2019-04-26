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
        
        mySwitch.setOn(true, animated: true)
        mySwitch.tintColor = UIColor.white
        mySwitch.onTintColor = UIColor.clear
        mySwitch.thumbTintColor = UIColor.white
        
        return mySwitch
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
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
extension SolarView {
    private func setupView() {
        setPlayButtonConstraints()
        setSwitchConstraints()
    }
    
    func setPlayButtonConstraints() {
        addSubview(playButton)
        playButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        playButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 11),
        playButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -11),
        playButton.heightAnchor.constraint(equalToConstant: 45),
        playButton.widthAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    func setSwitchConstraints() {
        addSubview(mySwitch)
        mySwitch.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        mySwitch.topAnchor.constraint(equalTo: playButton.bottomAnchor, constant: 10),
        mySwitch.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -11)
        ])
    }

}


