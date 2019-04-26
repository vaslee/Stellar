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

    lazy var solarView: SolarView = {
        return SolarView()
    }()

    let cubeNode = CubeMapBox(wallHeight: 40, wallThickness: 0.1, wallLength: 40, textures: .spaceTextures)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.delegate = self
        
        sceneView.showsStatistics = true

        
        setUpSolarView()


        sceneView.scene.rootNode.addChildNode(centerNode)
        Planet.getPlanets().forEach { centerNode.addChildNode($0) }
        
        //        Sound.playSound(sound: "background", format: "mp3")

        solarView.playButton.addTarget(self, action: #selector(playPressed), for: .touchUpInside)
        solarView.mySwitch.addTarget(self, action: #selector(portalSwitch), for: .valueChanged)

        
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tapped(sender:)))
        let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(self.pinch(pinch:)))

        sceneView.addGestureRecognizer(tapGestureRecognizer)
        sceneView.addGestureRecognizer(pinchGestureRecognizer)

    }
    
    
    
    @objc func playPressed() {
//        if playAnimation == .regular {
//            playAnimation = .animation
//        } else {
//            playAnimation = .regular
//        }
//
//
//        switch playAnimation {
//        case .regular:
//
//            sceneView.scene.rootNode.enumerateChildNodes { (node, stop ) in
//                node.removeFromParentNode()
//            }
//
//            sceneView.scene.rootNode.addChildNode(centerNode)
//            Planet.getPlanets().forEach { centerNode.addChildNode($0) }
//            sceneView.isUserInteractionEnabled = true
//
//        case .animation:
//
//            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped))
//            let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(pinch))
//
//            sceneView.removeGestureRecognizer(tapGestureRecognizer)
//            sceneView.removeGestureRecognizer(pinchGestureRecognizer)
//            sceneView.scene.rootNode.enumerateChildNodes { (node, stop ) in
//                node.removeFromParentNode()
//            }
//            sceneView.scene.rootNode.addChildNode(centerNode)
//            MovedPlanet.getPlanets().forEach { centerNode.addChildNode($0) }
//            sceneView.isUserInteractionEnabled = false
//
//        }
    }
    
    private func setUpSolarView() {
        solarView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(solarView)

        NSLayoutConstraint.activate([
            solarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            solarView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -4)
            ])
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
            
            
            setupScene(node: centerNode)
            cubeNode.addChildNode(centerNode)
//            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped))
//            let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(pinch))
//
//            sceneView.addGestureRecognizer(tapGestureRecognizer)
//            sceneView.addGestureRecognizer(pinchGestureRecognizer)
            MovedPlanet.getPlanets().forEach { centerNode.addChildNode($0) }

            
        }
    }
    
    @objc func tapped(sender: UITapGestureRecognizer) {
        let tappedView = sender.view as!SCNView
        let touchLocation = sender.location(in: tappedView)
        let hitTest = tappedView.hitTest(touchLocation, options: nil)
        if !hitTest.isEmpty {
            Sound.playSound(sound: "planetSelect", format: "wav")
            planetTapped()
        }
    }

    private func planetTapped() {
        let vc = SolarDetailViewController()
        vc.view.backgroundColor = UIColor.init(white: 0.2, alpha: 0.5)
        vc.providesPresentationContextTransitionStyle = true
        vc.definesPresentationContext = true
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true, completion: nil)
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
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARWorldTrackingConfiguration()

        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }

    
    func setupScene(node: SCNNode) {
       
        cubeNode.position = centerNode.position
        sceneView.scene.rootNode.addChildNode(cubeNode)

//        let light = SCNLight()
//        light.type = .spot
//        light.spotInnerAngle = 70
//        light.spotOuterAngle = 120
//        light.zNear = 0.00001
//        light.zFar = 5
//        light.castsShadow = true
//        light.shadowRadius = 200
//        light.shadowColor = UIColor.black.withAlphaComponent(0.3)
//        light.shadowMode = .deferred
//        let constraint = SCNLookAtConstraint(target: centerNode)
//        constraint.isGimbalLockEnabled = true
//
//        let lightNode = SCNNode()
//        lightNode.light = light
//        lightNode.position = SCNVector3.init(0, 19.5, 0)
//        lightNode.constraints = [constraint]
//        node.addChildNode(lightNode)
//
    }
    
}
