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
    var portalChange: PortalChange = .reality {
        didSet {
            updateScene()
        }
    }

    lazy var solarView: SolarView = {
        return SolarView()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.delegate = self
        
        sceneView.showsStatistics = true

        updateScene()
        
        //        Sound.playSound(sound: "background", format: "mp3")
        

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tapped(sender:)))
        let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(self.pinch(pinch:)))
        sceneView.addGestureRecognizer(tapGestureRecognizer)
        sceneView.addGestureRecognizer(pinchGestureRecognizer)

        setUpSolarView()
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
        solarView.layer.borderColor = UIColor.orange.cgColor
        solarView.layer.borderWidth = 2
        sceneView.addSubview(solarView)
        sceneView.bringSubviewToFront(solarView)

        NSLayoutConstraint.activate([
            solarView.topAnchor.constraint(equalTo: sceneView.safeAreaLayoutGuide.topAnchor, constant: 8),
            solarView.trailingAnchor.constraint(equalTo: sceneView.safeAreaLayoutGuide.trailingAnchor, constant: -4)
            ])

        solarView.playButton.addTarget(self, action: #selector(playPressed), for: .touchUpInside)
        solarView.mySwitch.addTarget(self, action: #selector(portalSwitch), for: .valueChanged)
    }

    @objc func portalSwitch() {
        if portalChange == .galaxy {
            portalChange = .reality
        } else {
            portalChange = .galaxy
        }
    }
    
    @objc func tapped(sender: UITapGestureRecognizer) {
        let tappedView = sender.view as!SCNView
        let touchLocation = sender.location(in: tappedView)
        let hitTest = tappedView.hitTest(touchLocation, options: nil)
        if let nodeName = hitTest.first?.node.name,
            let planetType = PlanetType(rawValue: nodeName) {
            Sound.playSound(sound: "planetSelect", format: "wav")
            planetTapped(planetType: planetType)
        }
    }

    private func planetTapped(planetType: PlanetType) {
        let vc = SolarDetailViewController()
        vc.planetType = planetType
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
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    private func updateScene() {
        sceneView.scene.rootNode.enumerateChildNodes { (node, stop ) in
            node.removeFromParentNode()
        }


        switch portalChange {
        case .reality:
            sceneView.scene.rootNode.addChildNode(centerNode)
            Planet.getPlanets().forEach { centerNode.addChildNode($0) }

        case .galaxy:
            let cubeNode = CubeMapBox(wallHeight: 50, wallThickness: 0.1, wallLength: 50, textures: .spaceTextures)
            sceneView.scene.rootNode.addChildNode(centerNode)
            centerNode.addChildNode(cubeNode)
            MovedPlanet.getPlanets().forEach { centerNode.addChildNode($0) }
        }
    }
    
}
