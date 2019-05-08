//
//  SolarDetailView.swift
//  StellarApp
//
//  Created by Diego Estrella III on 4/12/19.
//  Copyright © 2019 TingxinLi. All rights reserved.
//

import UIKit

class SolarDetailView: UIView {

    private let cornerRadiusMeasurement: CGFloat = 10
    private let planetType: PlanetType

    private lazy var contentView: PlanetInfoView = {
        guard let planetInfo = PlanetInfoCache.shared.planetMapping[planetType] else { fatalError("Missing Info for Planet: \(planetType.rawValue)") }
    return PlanetInfoView(planetInfo: planetInfo)
    }()

    public lazy var backgroundImageView: UIImageView = {
        let backgroundImage = UIImageView()
        backgroundImage.image = UIImage(named: "stars")
        backgroundImage.clipsToBounds = true
        backgroundImage.layer.cornerRadius = cornerRadiusMeasurement
        backgroundImage.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        backgroundImage.contentMode = .scaleToFill
        return backgroundImage
    }()

    public lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        image.image = UIImage.getPlanetDetailImage(planetType: planetType)
        return image
    }()

    public lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .black
        scrollView.indicatorStyle = .white

        return scrollView
    }()

    required init?(coder aDecoder: NSCoder) {
        fatalError("Unimplemented use init(_: PlanetType)")
    }

    init(planetType: PlanetType) {
        self.planetType = planetType
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }

    private func commonInit() {
        setBaseAttributes()
        setbackgroundImage()
        setImageView()
        setScrollView()
    }

    private func setBaseAttributes() {
        backgroundColor = .black
        layer.cornerRadius = cornerRadiusMeasurement
    }

    private func setbackgroundImage() {
        addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            backgroundImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5)
            ])
    }

    private func setImageView() {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: backgroundImageView.topAnchor, constant: 16),
            imageView.leadingAnchor.constraint(equalTo: backgroundImageView.leadingAnchor, constant: 16),
            imageView.trailingAnchor.constraint(equalTo: backgroundImageView.trailingAnchor, constant: -16),
            imageView.bottomAnchor.constraint(equalTo: backgroundImageView.bottomAnchor, constant: -16)
            ])
    }

    private func setScrollView() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            scrollView.leadingAnchor.constraint(equalTo: backgroundImageView.trailingAnchor, constant: 16),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
            ])
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1),
            ])
    }
}

extension UIImage {
    static func getPlanetDetailImage(planetType: PlanetType) -> UIImage {
       let fileName = "art.scnassets/structure_\(planetType.rawValue).png"

        return UIImage(named: fileName)!
    }
}
