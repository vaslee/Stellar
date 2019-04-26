//
//  Extension-Indoor.swift
//  StellarApp
//
//  Created by TingxinLi on 4/22/19.
//  Copyright © 2019 TingxinLi. All rights reserved.
//

import Foundation
import ARKit
import SceneKit

class CubeMapWall : SCNNode {
    
    init(height: CGFloat, thickness: CGFloat, length: CGFloat, texture: UIImage) {
        super.init()
        
        let firstBox = SCNBox(width: thickness, height: height, length: length, chamferRadius: 0)
        let firstBoxNode = SCNNode(geometry: firstBox)
        firstBox.firstMaterial?.diffuse.contents = texture
        firstBoxNode.renderingOrder = 200
        self.addChildNode(firstBoxNode)
        
        // add masked box
        let maskedBox = SCNBox(width: thickness, height: height, length: length, chamferRadius: 0)
        maskedBox.firstMaterial?.diffuse.contents = UIColor.white
        
        maskedBox.firstMaterial?.transparency = 0.00001
        
        let maskedBoxNode = SCNNode(geometry: maskedBox)
        maskedBoxNode.renderingOrder = 100
        maskedBoxNode.position = SCNVector3.init(thickness, 0, 0)
        self.addChildNode(maskedBoxNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FloatingPoint {
    var degreesToRadians : Self {
        return self * .pi / 180
    }
}
