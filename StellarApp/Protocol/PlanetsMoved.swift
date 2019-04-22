//
//  PlanetsMoved.swift
//  StellarApp
//
//  Created by TingxinLi on 4/18/19.
//  Copyright © 2019 TingxinLi. All rights reserved.
//

import UIKit
import ARKit

enum MovedPlanetType: CaseIterable{
    
    case sun
    case mercury
    case venus
    case earth
    case mars
    case jupiter
    case saturn
    case uranus
    case neptune
    case pluto
}

struct NewCenterNode {
    static func getCenterNode() -> SCNNode {
        
        return SCNNode.getNodes(name: "sun", image: UIImage(named: "art.scnassets/sun.jpg")!, radius: CGFloat.leastNormalMagnitude, vector: (x: -1, y: 0, z: 0), moveSpeed: 0, rotation: 0)
    }
    
}
struct MovedPlanet {
    static var planetNodes = [SCNNode]()
    
    static func getPlanets() -> [SCNNode] {
        planetNodes.removeAll()
        for planetType in PlanetType.allCases {
            switch planetType {
            case .sun:
                let planetNode = SCNNode.getNodes(name: "sun", image: UIImage(named: "art.scnassets/sun.jpg")!, radius: 1, vector: (x: 0, y: 0, z: 0), moveSpeed: 0, rotation: 0)
                planetNodes.append(planetNode)
                
            case .mercury:
                let orbitNode = SCNNode.getRings(radius: 1.48, vector: (x: 0, y: 0, z: 0), color: .yellow)
                let planetNode = SCNNode.getNodes(name: "mercury", image: UIImage(named: "art.scnassets/mercury.jpg")!, radius: 0.3, vector: (x: 1.48, y: 0, z: 0), moveSpeed: 1.2, rotation: 1.6)
                orbitNode.addChildNode(planetNode)
                orbitNode.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 1.2, z: 0, duration: 1)))
                planetNodes.append(orbitNode)
                
            case .venus:
                let orbitNode = SCNNode.getRings(radius: 2.39, vector: (x: 0, y: 0, z: 0), color: .yellow)
                let planetNode = SCNNode.getNodes(name: "venus", image: UIImage(named: "art.scnassets/venus.jpg")!, radius: 0.38, vector: (x: 2.39, y: 0, z: 0), moveSpeed: 0.8, rotation: 0.9)
                orbitNode.addChildNode(planetNode)
                orbitNode.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 0.8, z: 0, duration: 1)))
                planetNodes.append(orbitNode)
                
            case .earth:
                let orbitNode = SCNNode.getRings(radius: 3.25, vector: (x: 0, y: 0, z: 0), color: .yellow)
                let planetNode = SCNNode.getNodes(name: "earth", image: UIImage(named: "art.scnassets/earth.jpg")!, radius: 0.42, vector: (x: 3.25, y: 0, z: 0), moveSpeed: 0.5, rotation: 1.2)
                let moonOrbitNode = SCNNode.getRings(radius: 0.47, vector: (x: 0, y: 0, z: 0), color: .blue)
                let moonNode = SCNNode.getNodes(name: "moon", image: UIImage(named:"art.scnassets/moon.jpg")!, radius: 0.08, vector: (x: -0.47, y: 0, z: 0), moveSpeed: 0.2, rotation: 1.6)
                
                orbitNode.addChildNode(planetNode)
                planetNode.addChildNode(moonOrbitNode)
                moonOrbitNode.addChildNode(moonNode)
                orbitNode.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 0.5, z: 0, duration: 1)))
                planetNodes.append(orbitNode)
                
            case .mars:
                let orbitNode = SCNNode.getRings(radius: 4.11, vector: (x: 0, y: 0, z: 0), color: .yellow)
                let planetNode = SCNNode.getNodes(name: "mars", image: UIImage(named: "art.scnassets/mars.jpg")!, radius: 0.3, vector: (x: 4.11, y: 0, z: 0), moveSpeed: 0.4, rotation: 0.8)
                orbitNode.addChildNode(planetNode)
                orbitNode.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 0.4, z: 0, duration: 1)))
                planetNodes.append(orbitNode)
                
            case .jupiter:
                let orbitNode = SCNNode.getRings(radius: 6.3, vector: (x: 0, y: 0, z: 0), color: .yellow)
                let planetNode = SCNNode.getNodes(name: "jupiter", image: UIImage(named: "art.scnassets/jupiter.jpg")!, radius: 0.6, vector: (x: 6.3, y: 0, z: 0), moveSpeed: 0.9, rotation: 1.3)
                orbitNode.addChildNode(planetNode)
                orbitNode.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 0.9, z: 0, duration: 1)))
                planetNodes.append(orbitNode)
                
            case .saturn:
                let orbitNode = SCNNode.getRings(radius: 9.42, vector: (x: 0, y: 0, z: 0), color: .yellow)
                let planetNode = SCNNode.getNodes(name: "saturn", image: UIImage(named: "art.scnassets/saturn.jpg")!, radius: 0.86, vector: (x: 9.42, y: 0, z: 0), moveSpeed: 0.7, rotation: 0.2)
                let saturnOrbitNode = SCNNode.getSaturnRings(radius: 0.9, vector: (x: 0, y: 0, z: 0), texture: UIImage(named: "art.scnassets/saturnRing.png")!)
                orbitNode.addChildNode(planetNode)
                planetNode.addChildNode(saturnOrbitNode)
                orbitNode.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 0.7, z: 0, duration: 1)))
                planetNodes.append(orbitNode)
                
            case .uranus:
                let orbitNode = SCNNode.getRings(radius: 12.58, vector: (x: 0, y: 0, z: 0), color: .yellow)
                let planetNode = SCNNode.getNodes(name: "uranus", image: UIImage(named: "art.scnassets/uranus.jpg")!, radius: 0.65, vector: (x: 12.58, y: 0, z: 0), moveSpeed: 0.5, rotation: 0.4)
                orbitNode.addChildNode(planetNode)
                orbitNode.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 0.5, z: 0, duration: 1)))
                planetNodes.append(orbitNode)
                
            case .neptune:
                let orbitNode = SCNNode.getRings(radius: 15.98, vector: (x: 0, y: 0, z: 0), color: .yellow)
                let planetNode = SCNNode.getNodes(name: "neptune", image: UIImage(named: "art.scnassets/neptune.jpg")!, radius: 0.5, vector: (x: 15.98, y: 0, z: 0), moveSpeed: 0.4, rotation: 0.8)
                orbitNode.addChildNode(planetNode)
                orbitNode.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 0.4, z: 0, duration: 1)))
                planetNodes.append(orbitNode)
                
            case .pluto:
                let orbitNode = SCNNode.getRings(radius: 18.65, vector: (x: 0, y: 0, z: 0), color: .yellow)
                let planetNode = SCNNode.getNodes(name: "pluto", image: UIImage(named: "art.scnassets/pluto.jpg")!, radius: 0.19, vector: (x: 18.65, y: 0, z: 0), moveSpeed: 0.4, rotation: 0.8)
                orbitNode.addChildNode(planetNode)
                orbitNode.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 0.4, z: 0, duration: 1)))
                planetNodes.append(orbitNode)
            }
        }
        return planetNodes
    }
}

extension SCNNode {
    static func deepScaleNodes(node: SCNNode, scaleAction: SCNAction) {
        node.runAction(scaleAction)
        for child in node.childNodes {
            deepScaleNode(node: child, scaleAction: scaleAction)
        }
    }
    
    static func deepScaleNodes(node: SCNNode, scale: CGFloat) {
        let scaleX = scale * CGFloat(node.scale.x)
        let scaleY = scale * CGFloat(node.scale.y)
        let scaleZ = scale * CGFloat(node.scale.z)
        
        let newScale = SCNVector3Make(Float(scaleX), Float(scaleY), Float(scaleZ))
        node.scale = newScale
        for child in node.childNodes {
            deepScaleNode(node: child, scale: scale)
        }
    }
    
    static func getNodes(name: String, image: UIImage,
                        radius: CGFloat,
                        vector: (x: Float, y: Float, z: Float), /*orbitRadius: CGFloat,*/ moveSpeed: CGFloat, rotation: CGFloat/*, moonOrbitRadius: CGFloat*/) -> SCNNode{
        
        let node = SCNNode()
        let nodeSize = SCNSphere(radius: radius)
        let material = SCNMaterial()
        material.diffuse.contents = image
        node.name = name
        nodeSize.materials = [material]
        node.position = SCNVector3(x: vector.x, y: vector.y, z: vector.z)
        node.geometry = nodeSize
        node.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: rotation, z: 0, duration: 1)))
        
        return node
        
    }
    
    static func getRings(radius: CGFloat,
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
    
    static func getSaturnRings(radius: CGFloat,
                              vector: (x: Float, y: Float, z: Float),
                              texture: UIImage) -> SCNNode {
        
        var ringGeo = SCNTorus()
        let ringNode = SCNNode()
        
        ringGeo = SCNTorus(ringRadius: radius, pipeRadius: 0.01)
        ringNode.geometry = ringGeo
        ringNode.position = SCNVector3(x: vector.x, y: vector.y, z: vector.z)
        ringGeo.firstMaterial?.diffuse.contents = texture
        
        
        return ringNode
    }
    
}
