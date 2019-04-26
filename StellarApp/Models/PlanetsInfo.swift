import UIKit

struct PlanetData: Codable {
    let planetData: [PlanetInfo]
}

struct PlanetInfo: Codable {
    let id: Int
    let name: String
    let mass: String
    let diameter: String
    let density: String
    let gravity: String
    let rotationPeriod: String
    let lenghtOfDay: String
    let distanceFromSun: String
    let orbitalPeriod: String
    let orbitalVelocity: String
    let meanTemperature: String
    let numberOfMoons: String
    let description: String
    let planetDetailImage: String
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
        case planetDetailImage
    }

    init(id: Int, name: String, mass: String, diameter: String, density: String, gravity: String, rotationPeriod: String, lenghtOfDay: String, distanceFromSun: String, orbitalPeriod: String, orbitalVelocity: String, meanTemperature: String, numberOfMoons: String, description: String, planetDetailImage: String) {
        self.id = id
        self.name = name
        self.mass = mass
        self.diameter = diameter
        self.density = density
        self.gravity = gravity
        self.rotationPeriod = rotationPeriod
        self.lenghtOfDay = lenghtOfDay
        self.distanceFromSun = distanceFromSun
        self.orbitalPeriod = orbitalPeriod
        self.orbitalVelocity = orbitalVelocity
        self.meanTemperature = meanTemperature
        self.numberOfMoons = numberOfMoons
        self.description = description
        self.planetDetailImage = planetDetailImage
    }

    init(dict: [String: Any]) {
        self.id = dict[PlanetCollectionKeys.IdKey] as? Int ?? 0
        self.name = dict[PlanetCollectionKeys.NameKey] as? String ?? ""
        self.mass = dict[PlanetCollectionKeys.MassKey] as? String ?? ""
        self.diameter = dict[PlanetCollectionKeys.DiameterKey] as? String ?? ""
        self.density = dict[PlanetCollectionKeys.DensityKey] as? String ?? ""
        self.gravity = dict[PlanetCollectionKeys.GravityKey] as? String ?? ""
        self.rotationPeriod = dict[PlanetCollectionKeys.RotationPeriodKey] as? String ?? ""
        self.lenghtOfDay = dict[PlanetCollectionKeys.LengthOfDayKey] as? String ?? ""
        self.distanceFromSun = dict[PlanetCollectionKeys.DistanceFromSunKey] as? String ?? ""
        self.orbitalPeriod = dict[PlanetCollectionKeys.OrbitalPeriodKey] as? String ?? ""
        self.orbitalVelocity = dict[PlanetCollectionKeys.OrbitalVelocityKey] as? String ?? ""
        self.meanTemperature = dict[PlanetCollectionKeys.MeanTemperatureKey] as? String ?? ""
        self.numberOfMoons = dict[PlanetCollectionKeys.NumberOfMoonsKey] as? String ?? "0"
        self.description = dict[PlanetCollectionKeys.DescriptionKey] as? String ?? ""
        self.planetDetailImage = dict[PlanetCollectionKeys.PlanetDetailImageKey] as? String ?? "phImage"
    }

}
