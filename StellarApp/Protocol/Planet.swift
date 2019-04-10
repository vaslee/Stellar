//
//  Planet.swift
//  Stellar
//
//  Created by TingxinLi on 4/10/19.
//  Copyright © 2019 TingxinLi. All rights reserved.
//

import UIKit
import ARKit

struct Planet: PlanetaryBody {
    
    var name: String
    var planetNode: SCNNode
    
     /*deleting later*/// "mercury","venus", "earth", "mars", "jupiter", "saturn", "uranus", "neptune"
    static let loadPlanets: [Planet] = [
        
        Planet(name: "mercury", planetNode: getNode(image: UIImage(named: "art.scnassets/mercury.jpg")!, radius: 0.2, vector: (x: 1.3, y: 0, z: 0), orbitRadius: 1.3, moveSpeed: 1.2, rotation: 1.6)),
        Planet(name: "venus", planetNode: getNode(image: UIImage(named: "art.scnassets/venus.jpg")!, radius: 0.4, vector: (x: 2, y: 0, z: 0), orbitRadius: 2, moveSpeed: 0.8, rotation: 0.9)),
        Planet(name: "earth", planetNode: getNode(image: UIImage(named: "art.scnassets/earth.jpg")!, radius: 0.5, vector: (x: 3, y: 0, z: 0), orbitRadius: 3, moveSpeed: 0.5, rotation: 1.2)),
        
        Planet(name: "mars", planetNode: getNode(image: UIImage(named: "art.scnassets/mars.jpg")!, radius: 0.4, vector: (x: 4.2, y: 0, z: 0), orbitRadius: 4.2, moveSpeed: 0.4, rotation: 0.8)),
        
        Planet(name: "jupiter", planetNode: getNode(image: UIImage(named: "art.scnassets/jupiter.jpg")!, radius: 0.9, vector: (x: 6, y: 0, z: 0), orbitRadius: 6, moveSpeed: 0.9, rotation: 1.3)),
        
        Planet(name: "saturn", planetNode: getNode(image: UIImage(named: "art.scnassets/saturn.jpg")!, radius: 0.7, vector: (x: 8, y: 0, z: 0), orbitRadius: 8, moveSpeed: 0.7, rotation: 0.2)),
        
        Planet(name: "uranus", planetNode: getNode(image: UIImage(named: "art.scnassets/uranus.jpg")!, radius: 0.8, vector: (x: 10, y: 0, z: 0), orbitRadius: 10, moveSpeed: 0.5, rotation: 0.4)),
        
        Planet(name: "neptune", planetNode: getNode(image: UIImage(named: "art.scnassets/neptune.jpg")!, radius: 0.6, vector: (x: 12, y: 0, z: 0), orbitRadius: 12, moveSpeed: 0.4, rotation: 0.8))
        
        
        //TESTING CODE
        //                Planet(name: "mercury", planetNode: getNode(image: UIImage(named: "art.scnassets/mercury.jpg")!, radius: 0.2, vector: (x: 1.3, y: 0, z: 0), orbitRadius: 1.3, moveSpeed: 1.2, rotation: 1.6))
        
        
    ]
    
    
    static func getNode(image: UIImage,
                        radius: CGFloat,
                        vector: (x: Float, y: Float, z: Float), orbitRadius: CGFloat, moveSpeed: CGFloat, rotation: CGFloat) -> SCNNode{
        // TODO: if ring node first
        let orbitNode = getRing(radius: orbitRadius, vector: (x: 0, y: -1, z: 0), color: .yellow)
        let node = SCNNode()
        let nodeSize = SCNSphere(radius: radius)
        let material = SCNMaterial()
        
        material.diffuse.contents = image
        nodeSize.materials = [material]
        node.position = SCNVector3(x: vector.x, y: vector.y, z: vector.z)
        node.geometry = nodeSize
        
        orbitNode.addChildNode(node)
        
        orbitNode.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: moveSpeed, z: 0, duration: 1)))
        node.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: rotation, z: 0, duration: 1)))
        
        return orbitNode
        
    }
    
    static func getRing(radius: CGFloat,
                        vector: (x: Float, y: Float, z: Float),
                        color: UIColor) -> SCNNode {
        
        var ringGeo = SCNTorus()
        let ringNode = SCNNode()
        
        ringGeo = SCNTorus(ringRadius: radius, pipeRadius: 0.01)
        ringNode.geometry = ringGeo
        ringNode.position = SCNVector3(x: vector.x, y: vector.y, z: vector.z)
        ringGeo.firstMaterial?.diffuse.contents = color
        
        
        return ringNode
    }
    
    static private func generateTexture(image: UIImage) -> SCNMaterial {
        let material = SCNMaterial()
        material.diffuse.contents = image
        return material
    }
    
    //    func getPlanet(_ name: String) -> Planet? {
    //        let results = Planet.loadPlanets.filter { $0.name == name }
    //        guard let planet = results.first else {
    //            return nil
    //        }
    //        return planet
    //    }
}
