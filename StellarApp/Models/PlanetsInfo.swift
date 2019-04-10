//
//  PlanetsInfo.swift
//  StellarApp
//
//  Created by TingxinLi on 4/8/19.
//  Copyright © 2019 TingxinLi. All rights reserved.
//

import Foundation

struct PlanetInfo {
    let id: String
    let name: String
    let mass: String
    let diameter: String
    let density: String
    let gravity: String
    let rotation_period: String
    let length_of_day: String
    let distance_from_sun: String
    let orbital_period: String
    let orbital_velocity: String
    let mean_temperature: String
    let number_of_moons: String
    let description: String
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case mass
        case diameter
        case density
        case gravity
        case rotationPeriod = "rotation_period"
        case lenghtOfDay = "length_of_day"
        case distanceFromSun = "distance_from_sun"
        case orbitalPeriod = "orbital_period"
        case orbitalVelocity = "orbital_velocity"
        case meanTemperature = "mean_temperature"
        case numberOfMoons = "number_of_moons"
        case description
    }

    init(id: String, name: String, mass: String, diameter: String, density: String, gravity: String, roationPeriod: String, lenghtOfDay: String, distanceFromSun: String, orbitalPeriod: String, orbitalVelocity: String, meanTemperature: String, numberOfMoons: String, description: String) {
        self.id = id
        self.name = name
        self.mass = mass
        self.diameter = diameter
        self.density = density
        self.gravity = gravity
        self.rotation_period = roationPeriod
        self.length_of_day = lenghtOfDay
        self.distance_from_sun = distanceFromSun
        self.orbital_period = orbitalPeriod
        self.orbital_velocity = orbitalVelocity
        self.mean_temperature = meanTemperature
        self.number_of_moons = numberOfMoons
        self.description = description
    }

    init(dict: [String: Any]) {
        self.id = dict[PlanetCollectionKeys.IdKey] as? String ?? ""
        self.name = dict[PlanetCollectionKeys.NameKey] as? String ?? ""
        self.mass = dict[PlanetCollectionKeys.MassKey] as? String ?? ""
        self.diameter = dict[PlanetCollectionKeys.DiameterKey] as? String ?? ""
        self.density = dict[PlanetCollectionKeys.DensityKey] as? String ?? ""
        self.gravity = dict[PlanetCollectionKeys.GravityKey] as? String ?? ""
        self.rotation_period = dict[PlanetCollectionKeys.RotationPeriodKey] as? String ?? ""
        self.length_of_day = dict[PlanetCollectionKeys.LengthOfDayKey] as? String ?? ""
        self.distance_from_sun = dict[PlanetCollectionKeys.DistanceFromSunKey] as? String ?? ""
        self.orbital_period = dict[PlanetCollectionKeys.OrbitalPeriodKey] as? String ?? ""
        self.orbital_velocity = dict[PlanetCollectionKeys.OrbitalVelocityKey] as? String ?? ""
        self.mean_temperature = dict[PlanetCollectionKeys.MeanTemperatureKey] as? String ?? ""
        self.number_of_moons = dict[PlanetCollectionKeys.NumberOfMoonsKey] as? String ?? "0"
        self.description = dict[PlanetCollectionKeys.DescriptionKey] as? String ?? ""
    }

}
