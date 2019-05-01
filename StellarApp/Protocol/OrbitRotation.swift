//
//  OrbitRotation.swift
//  StellarApp
//
//  Created by TingxinLi on 5/1/19.
//  Copyright © 2019 TingxinLi. All rights reserved.
//

import Foundation
import UIKit
import ARKit

struct RotationVector {
    let x: CGFloat, y: CGFloat, z: CGFloat
}

protocol Rotatable {
    func rotate()
    func stopRotating()
}

class RotatingNode: SCNNode, Rotatable {
    private var isRotating: Bool = false
    let rotationVector: RotationVector
    
    init(geometry: SCNGeometry, rotationVector: RotationVector) {
        self.rotationVector = rotationVector
        super.init()
        self.geometry = geometry
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    func rotate() {
        self.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: rotationVector.x, y: rotationVector.y, z: rotationVector.z, duration: 1)), forKey: "rotateNode")
    }
    
    func stopRotating() {
        self.removeAction(forKey: "rotateNode")
    }
    
}
