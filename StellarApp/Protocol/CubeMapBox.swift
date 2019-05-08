//
//  CubeMapBox.swift
//  StellarApp
//
//  Created by TingxinLi on 4/25/19.
//  Copyright © 2019 TingxinLi. All rights reserved.
//

import Foundation
import SceneKit


struct CubeMapTextures {
    let front, back, top, left, right, bottom: UIImage
}


class CubeMapBox: SCNNode {
    init(wallHeight: CGFloat,
         wallThickness: CGFloat,
         wallLength: CGFloat,
         textures: CubeMapTextures) {
        
        super.init()
        let leftWall = CubeMapWall(height: wallHeight,
                                   thickness: wallThickness,
                                   length: wallLength,
                                   texture: textures.left)
        leftWall.position = SCNVector3.init((-wallLength/2) + wallThickness , 0 , 0)
        leftWall.eulerAngles = SCNVector3.init(0, 180.0.degreesToRadians, 0)
        
        let rightWall = CubeMapWall(height: wallHeight,
                                    thickness: wallThickness,
                                    length: wallLength,
                                    texture: textures.right)
        rightWall.position = SCNVector3.init((wallLength/2) - wallThickness , 0 , 0)
        
        let topWall = CubeMapWall(height: wallHeight,
                                  thickness: wallThickness,
                                  length: wallLength,
                                  texture: textures.top)
        topWall.position = SCNVector3.init(0, (wallHeight/2) - wallThickness , 0)
        topWall.eulerAngles = SCNVector3.init(0, 0 , 90.0.degreesToRadians)
        
        let bottomWall = CubeMapWall(height: wallHeight,
                                     thickness: wallThickness,
                                     length: wallLength,
                                     texture: textures.bottom)
        bottomWall.position = SCNVector3.init(0, (-wallHeight/2) + wallThickness, 0)
        bottomWall.eulerAngles = SCNVector3.init(0, 0 , -90.0.degreesToRadians)
        
        
        let backWall = CubeMapWall(height: wallHeight,
                                   thickness: wallThickness,
                                   length: wallLength,
                                   texture: textures.back)
        backWall.position = SCNVector3.init(0, 0, (-wallLength/2) + wallThickness)
        backWall.eulerAngles = SCNVector3.init(0, 90.0.degreesToRadians, 0)
        
        let frontWall = CubeMapWall(height: wallHeight,
                                    thickness: wallThickness,
                                    length: wallLength,
                                    texture: textures.front)
        frontWall.position = SCNVector3(0, 0, (wallLength/2) + wallThickness)
        frontWall.eulerAngles = SCNVector3.init(0, 90.0.degreesToRadians, 0)
        
        self.addChildNode(leftWall)
        self.addChildNode(rightWall)
        self.addChildNode(topWall)
        self.addChildNode(bottomWall)
        self.addChildNode(backWall)
        self.addChildNode(frontWall)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIImage {
    convenience init(imageName: String) {
        self.init(named: "art.scnassets/\(imageName)")!
    }
}

extension CubeMapTextures {
    static let spaceTextures: CubeMapTextures = {
        let image = UIImage(imageName: "nightstar.jpg")
        return CubeMapTextures(front: image, back: image, top: image, left: image, right: image, bottom: image)
    }()
}
