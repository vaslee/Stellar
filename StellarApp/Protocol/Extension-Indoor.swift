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

var width : CGFloat = 0.5
var height : CGFloat = 40
var length : CGFloat = 40

var doorLength : CGFloat = 16//0.5

func createBox(isDoor : Bool) -> SCNNode {
    let node = SCNNode()
    
    // add first box
    let firstBox = SCNBox(width: width, height: height, length: isDoor ? doorLength : length, chamferRadius: 0)
    let firstBoxNode = SCNNode(geometry: firstBox)
    firstBox.firstMaterial?.diffuse.contents = UIImage(named: "art.scnassets/nightstar.jpg")
    firstBoxNode.renderingOrder = 200
    node.addChildNode(firstBoxNode)
    
    // add masked box
    let maskedBox = SCNBox(width: width, height: height, length: isDoor ? doorLength : length, chamferRadius: 0)
    maskedBox.firstMaterial?.diffuse.contents = UIColor.white

    maskedBox.firstMaterial?.transparency = 0.00001
    
    let maskedBoxNode = SCNNode(geometry: maskedBox)
    maskedBoxNode.renderingOrder = 100
    maskedBoxNode.position = SCNVector3.init(width, 0, 0)
    node.addChildNode(maskedBoxNode)
    
    
    return node
}


extension FloatingPoint {
    var degreesToRadians : Self {
        return self * .pi / 180
    }
}
