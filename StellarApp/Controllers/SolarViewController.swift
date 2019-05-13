import UIKit
import SceneKit
import ARKit


enum PlayAnimation {
    case unanimated
    case animated
}

enum PortalChange {
    case reality
    case galaxy
}

enum PlayButtonImage {
    case play
    case pause
}

class SolarViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!

    let customTabBarHeight = 50
    let centerNode = NewCenterNode.getCenterNode()
    var playAnimation: PlayAnimation = .unanimated {
        didSet {
            updateScene()
        }
    }

    var portalChange: PortalChange = .reality {
        didSet {
            updateScene()
        }
    }
    var playButtonImage: PlayButtonImage = .pause

    lazy var solarView: SolarView = {
        return SolarView()
    }()
    
    let cubeNode = CubeMapBox(wallHeight: 50, wallThickness: 0.1, wallLength: 50, textures: .spaceTextures)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.delegate = self

        sceneView.scene.rootNode.addChildNode(centerNode)
        centerNode.addChildNode(cubeNode)
        MovedPlanet.getPlanets().forEach({centerNode.addChildNode($0)})
        updateScene()

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tapped(sender:)))
        let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(self.pinch(pinch:)))
        sceneView.addGestureRecognizer(tapGestureRecognizer)
        sceneView.addGestureRecognizer(pinchGestureRecognizer)

        setUpSolarView()
    }
    
    override func viewWillLayoutSubviews() {
        var customTabFrame = self.tabBarController?.tabBar.frame
        customTabFrame?.size.height = CGFloat(customTabBarHeight)
        customTabFrame?.origin.y = self.view.frame.size.height - CGFloat(customTabBarHeight)
        self.tabBarController?.tabBar.frame = customTabFrame!
        tabBarController?.tabBar.barTintColor = .black
        tabBarController?.tabBar.tintColor = .white
    }

    @objc func playPressed() {
            playButtonImageChange()
        if playAnimation == .unanimated {
            playAnimation = .animated
        } else {
            playAnimation = .unanimated
        }
    }

    private func playButtonImageChange() {
        if playButtonImage == .pause {
            playButtonImage = .play
        } else {
            playButtonImage = .pause
        }
        switch playButtonImage {
        case .play:
            solarView.playButton.setImage(UIImage(named: "pause"), for: .normal)
        case .pause:
            solarView.playButton.setImage(UIImage(named: "play9"), for: .normal)
        }
    }

    private func setUpSolarView() {
        solarView.translatesAutoresizingMaskIntoConstraints = false
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
            SCNNode.deepScaleNode(node: centerNode,
                                  scale: pinch.scale,
                                  shouldApply: ({ node in
                                    if node is CubeMapBox { return false }
                                    return true
                                  }))
            
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
        if portalChange == .galaxy {
            cubeNode.isHidden = false
        } else {
            cubeNode.isHidden = true
        }
        layoutPlanets()
    }
    
    private func layoutPlanets() {
        switch playAnimation {
        case.animated :
            centerNode.enumerateChildNodes { (node, _) in
                (node as? Rotatable)?.rotate()
            }
        case .unanimated:
            centerNode.enumerateChildNodes { (node, _) in
                (node as? Rotatable)?.stopRotating()
            }
        }
    }
    
    
}
