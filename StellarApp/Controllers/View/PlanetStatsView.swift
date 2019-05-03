//
//  PlanetStatsView.swift
//  StellarApp
//
//  Created by Diego Estrella III on 5/1/19.
//  Copyright © 2019 TingxinLi. All rights reserved.
//

import UIKit

class PlanetStatsView: UIView {

    private var planetInfo: PlanetInfo

    init(planetInfo: PlanetInfo) {
        self.planetInfo = planetInfo
        super.init(frame: .zero)
        layoutView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func layoutView() {
        let cells = stats().map { PlanetStatCell(title: $0.0, description: $0.1)}
        var topAnchor = self.topAnchor
        for (index,cell) in cells.enumerated() {
            cell.translatesAutoresizingMaskIntoConstraints = false
            addSubview(cell)
            setCellConstraints(cell: cell, topAnchor: topAnchor)
            topAnchor = cell.bottomAnchor
            if index % 2 == 0 {
                cell.backgroundColor = .black
            } else {
                cell.backgroundColor = .darkGray
            }
        }

        cells.last?.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }

    private func setCellConstraints(cell: PlanetStatCell, topAnchor: NSLayoutYAxisAnchor) {
        NSLayoutConstraint.activate([
            cell.leadingAnchor.constraint(equalTo: leadingAnchor),
            cell.trailingAnchor.constraint(equalTo: trailingAnchor),
            cell.topAnchor.constraint(equalTo: topAnchor)
            ])
    }

    private func stats() -> [(String, String)] {
        return [
            ("Mass", planetInfo.mass),
            ("Diameter", planetInfo.diameter),
            ("Density", planetInfo.density),
            ("Gravity", planetInfo.gravity),
            ("Lenght Of Day", planetInfo.lenghtOfDay),
            ("Rotation Period", planetInfo.rotationPeriod),
            ("Orbital Period", planetInfo.orbitalPeriod),
            ("Orbital Velocity", planetInfo.orbitalVelocity),
            ("Mean Temperature", planetInfo.meanTemperature),
            ("Distance From Sun", planetInfo.distanceFromSun),
            ("Number Of Moons", planetInfo.numberOfMoons)
        ]
    }




}


