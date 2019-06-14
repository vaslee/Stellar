
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
