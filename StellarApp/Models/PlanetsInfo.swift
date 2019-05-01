import UIKit

struct PlanetData: Codable {
    let data: [PlanetInfo]
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
    let createdAt: String
    let updatedAt: String
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
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case description
    }
}

class PlanetInfoCache {
    static let shared = PlanetInfoCache()

    lazy var planetMapping: [PlanetType: PlanetInfo] = {
        let planetData = getPlanetData()
        var planetDict: [PlanetType: PlanetInfo] = [:]
        for info in planetData {
            if let planetType = PlanetType(rawValue: info.name.lowercased()) {
                planetDict[planetType] = info
            }
//                else {
//                fatalError("unhandled planet type \(dump(info))")
//            }
        }
        return planetDict
    }()

    private func getPlanetData() -> [PlanetInfo] {
        guard let path = Bundle.main.path(forResource: "planet", ofType: "json") else { fatalError("planet json file should exist, not found in bundle")}

        let url = URL.init(fileURLWithPath: path)

        guard let data = try? Data.init(contentsOf: url)
            else { fatalError("planet json data should exist") }

        do {
            let planetData = try JSONDecoder().decode(PlanetData.self, from: data)
            return planetData.data
        } catch {
            fatalError("Error: \(error.localizedDescription)")
        }
    }

}
