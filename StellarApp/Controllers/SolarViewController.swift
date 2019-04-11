import UIKit
import SceneKit
import ARKit

class SolarViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet weak var sceneView: ARSCNView!
    
    let sun = SCNSphere(radius: 0.5)
    let meterial = SCNMaterial()
    let sunNode = SCNNode()
    
    private var planetObjects = [Planet]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.delegate = self
        
        sceneView.showsStatistics = true
        
        setUpSun()
        
        planetObjects = Planet.loadPlanets
        
        planetObjects.forEach { sceneView.scene.rootNode.addChildNode($0.planetNode) }

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped))
        sceneView.addGestureRecognizer(tapGestureRecognizer)
        
       // let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(pinch))
    }
    
    @objc func tapped(sender: UITapGestureRecognizer) {
        let tappedView = sender.view as!SCNView
        let touchLocation = sender.location(in: tappedView)
        let hitTest = tappedView.hitTest(touchLocation, options: nil)
        if !hitTest.isEmpty {
            self.present(MenuViewController(), animated: true, completion: nil)
        }
    }
    
    @objc func pinch(pinch: UIPinchGestureRecognizer) {
        
        let pinchView = pinch.view as! SCNView
        
        
        sceneView.scene.rootNode.enumerateChildNodes { (node, stop) in // only zooming to big
            if node.name == "mercury" {
                print("node: \(node) stop: \(stop)")
                node.scale.x = 2.0//newScale
                node.scale.y = 2.0//newScale
                node.scale.z = 2.0//newScale
            }
        }
    }
    
    func setUpSun() {
        
        meterial.diffuse.contents = UIImage(named: "art.scnassets/sun.jpg")
        sun.materials = [meterial]
        sunNode.position = SCNVector3(x: 0, y: -1, z: 0)
        sunNode.geometry = sun
        sceneView.scene.rootNode.addChildNode(sunNode)
        
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
