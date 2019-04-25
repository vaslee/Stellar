import UIKit
import SceneKit
import ARKit

enum PlayAnimation {
    case regular
    case animation
}

enum PortalChange {
    case reality
    case galaxy
}

class SolarViewController: UIViewController, ARSCNViewDelegate {
    

    @IBOutlet var sceneView: ARSCNView!

    
    let centerNode = CenterNode.getCenterNode()
    var playAnimation: PlayAnimation = .animation
    var portalChange: PortalChange = .reality
    
    
    let solarView = SolarView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.delegate = self
        
        sceneView.showsStatistics = true
        
        view.addSubview(solarView)

        sceneView.scene.rootNode.addChildNode(centerNode)
        Planet.getPlanets().forEach { centerNode.addChildNode($0) }
        
        solarView.playButton.addTarget(self, action: #selector(playPressed), for: .touchUpInside)
        solarView.mySwitch.addTarget(self, action: #selector(portalSwitch), for: .valueChanged)
       
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped))
        let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(pinch))
        
        sceneView.addGestureRecognizer(tapGestureRecognizer)
        sceneView.addGestureRecognizer(pinchGestureRecognizer)

    }
    
    
    @objc func playPressed() {
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
            sceneView.scene.rootNode.addChildNode(centerNode)
            Planet.getPlanets().forEach { centerNode.addChildNode($0) }
            sceneView.isUserInteractionEnabled = true
            
        case .animation:
            
//            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped))
//            let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(pinch))
//            
//            sceneView.removeGestureRecognizer(tapGestureRecognizer)
//            sceneView.removeGestureRecognizer(pinchGestureRecognizer)
            sceneView.scene.rootNode.enumerateChildNodes { (node, stop ) in
                node.removeFromParentNode()
            }
            sceneView.scene.rootNode.addChildNode(centerNode)
            MovedPlanet.getPlanets().forEach { centerNode.addChildNode($0) }
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
//            let scaleAction = SCNAction.scale(by: pinch.scale, duration: 0)
            SCNNode.deepScaleNode(node: centerNode, scale: pinch.scale)
            pinch.scale = 1.0
        }
    }
    
    @objc func portalSwitch() {
        
        if portalChange == .galaxy {
            portalChange = .reality
              solarView.mySwitch.isOn = true
        } else {
            portalChange = .galaxy
             solarView.mySwitch.isOn = false
        }
        
        switch portalChange {
        case .reality:
            sceneView.scene.rootNode.enumerateChildNodes { (node, stop ) in
                node.removeFromParentNode()
            }
            sceneView.scene.rootNode.addChildNode(centerNode)
            Planet.getPlanets().forEach { centerNode.addChildNode($0) }
            
        case .galaxy:
            sceneView.scene.rootNode.enumerateChildNodes { (node, stop ) in
                node.removeFromParentNode()
            }
            print("hi")
            setupScene()
            
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

    
    func setupScene() {
        let node = SCNNode()
        node.position = SCNVector3.init(1, -1, 0)
        
        let leftWall = createBox(isDoor: false)
        leftWall.position = SCNVector3.init((-length/2) + width , 0 , 0)
    
        leftWall.eulerAngles = SCNVector3.init(0, 180.0.degreesToRadians, 0)
        
        let rightWall = createBox(isDoor: false)
        rightWall.position = SCNVector3.init((length/2) - width , 0 , 0)
        
        let topWall = createBox(isDoor: false)
        topWall.position = SCNVector3.init(0, (height/2) - width , 0)
        topWall.eulerAngles = SCNVector3.init(0, 0 , 90.0.degreesToRadians)
        
        let bottomWall = createBox(isDoor: false)
        bottomWall.position = SCNVector3.init(0, (-height/2) + width, 0)
        
        bottomWall.eulerAngles = SCNVector3.init(0, 0 , -90.0.degreesToRadians)
        
        let backWall = createBox(isDoor: false)
        backWall.position = SCNVector3.init(0, 0, (-length/2) + width)
        backWall.eulerAngles = SCNVector3.init(0, 90.0.degreesToRadians, 0)
        
        let leftDoorSide = createBox(isDoor: true)
        leftDoorSide.position = SCNVector3.init((-length/2) + (doorLength/2) , 0 , (length/2) - width)
        leftDoorSide.eulerAngles = SCNVector3.init(0, -90.0.degreesToRadians, 0)
        
        let rightDoorSide = createBox(isDoor: true)
        rightDoorSide.position = SCNVector3.init((length/2) - (doorLength/2), 0 , (length/2) - width)
        rightDoorSide.eulerAngles = SCNVector3.init(0, -90.0.degreesToRadians, 0)
        
        
        let light = SCNLight()
        light.type = .spot
        light.spotInnerAngle = 70
        light.spotOuterAngle = 120
        light.zNear = 0.00001
        light.zFar = 5
        light.castsShadow = true
        light.shadowRadius = 200
        light.shadowColor = UIColor.black.withAlphaComponent(0.3)
        light.shadowMode = .deferred
        let constraint = SCNLookAtConstraint(target: bottomWall)
        constraint.isGimbalLockEnabled = true
        
        let lightNode = SCNNode()
        lightNode.light = light
        lightNode.position = SCNVector3.init(0, (height/2) - width, 0)
        lightNode.constraints = [constraint]
        node.addChildNode(lightNode)
        
        
        node.addChildNode(leftWall)
        node.addChildNode(rightWall)
        node.addChildNode(topWall)
        node.addChildNode(bottomWall)
        node.addChildNode(backWall)
        node.addChildNode(leftDoorSide)
        node.addChildNode(rightDoorSide)
        
        
        
        self.sceneView.scene.rootNode.addChildNode(node)
        
        //node.addChildNode(centerNode)
       MovedPlanet.getPlanets().forEach { node.addChildNode($0) }
    }
    
}
