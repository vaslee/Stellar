import UIKit
import SceneKit
import ARKit


enum PlayAnimation {
    case regular
    case animation
}


class SolarViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet weak var mySwitch: UISwitch!
    @IBOutlet var sceneView: ARSCNView!


    var playAnimation: PlayAnimation = .animation
    let sunNode = Sun.getSunNode()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.delegate = self
        
        sceneView.showsStatistics = true
        
        sceneView.scene.rootNode.addChildNode(sunNode)
        
        PlanetsAction.getPlanets().forEach { sunNode.addChildNode($0) }
        

    }
    
    @IBAction func switchAction(_ sender: UISwitch) {
        if playAnimation == .regular {
            playAnimation = .animation
        } else {
            playAnimation = .regular
        }
        
        switch playAnimation {
        case .regular:
            
            sceneView.scene.rootNode.enumerateChildNodes { (node, stop ) in
                node.removeFromParentNode()
            }
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped))
            let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(pinch))
            let rotateGestureRecognizer = UIRotationGestureRecognizer(target: self, action: #selector(rotate))
            sceneView.addGestureRecognizer(tapGestureRecognizer)
            sceneView.addGestureRecognizer(pinchGestureRecognizer)
            sceneView.addGestureRecognizer(rotateGestureRecognizer)
            
            sceneView.scene.rootNode.addChildNode(sunNode)
            Planet.getPlanets().forEach { sunNode.addChildNode($0) }
            sceneView.isUserInteractionEnabled = true
            
        case .animation:
            sceneView.scene.rootNode.enumerateChildNodes { (node, stop ) in
                node.removeFromParentNode()
            }
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped))
            let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(pinch))
            let rotateGestureRecognizer = UIRotationGestureRecognizer(target: self, action: #selector(rotate))
            sceneView.removeGestureRecognizer(tapGestureRecognizer)
            sceneView.removeGestureRecognizer(pinchGestureRecognizer)
            sceneView.removeGestureRecognizer(rotateGestureRecognizer)
            
            sceneView.scene.rootNode.addChildNode(sunNode)
            PlanetsAction.getPlanets().forEach { sunNode.addChildNode($0) }
            sceneView.isUserInteractionEnabled = false
            
        }
    }
    
    
    @objc func tapped(sender: UITapGestureRecognizer) {
        let tappedView = sender.view as!SCNView
        let touchLocation = sender.location(in: tappedView)
        let hitTest = tappedView.hitTest(touchLocation, options: nil)
        if !hitTest.isEmpty {
            self.present(SolarDetailViewController(), animated: true, completion: nil)

        }
    }
    

    
    @objc func pinch(pinch: UIPinchGestureRecognizer) {
        
        let pinchView = pinch.view as! SCNView

        let pinchLocation = pinch.location(in: pinchView)
        let hitTest = pinchView.hitTest(pinchLocation, options: nil)
        if !hitTest.isEmpty {
            let scaleAction = SCNAction.scale(by: pinch.scale, duration: 0)
            SCNNode.deepScaleNode(node: sunNode, scaleAction: scaleAction)
            pinch.scale = 1.0
        }
    }
    
    @objc func rotate(rotate: UIRotationGestureRecognizer) {
       
        let rotateView = rotate.view as! SCNView
        let rotateLocation = rotate.location(in: rotateView)
        let hitTest = rotateView.hitTest(rotateLocation, options: nil)
        if !hitTest.isEmpty {
            let rotateAction = SCNAction.rotateBy(x: 1, y: 1, z: 0, duration: 0.1)
            SCNNode.deepScaleNode(node: sunNode, scaleAction: rotateAction)
            rotate.rotation = 0
        }
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARWorldTrackingConfiguration()

        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }

}
