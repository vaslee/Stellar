import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet var sceneView: ARSCNView!
    

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
        
        // TESTING CODE:
        //let node = Planet.getNode(image: UIImage(named: "art.scnassets/mercury.jpg")!, radius: 0.2, vector: (x: 1.3, y: -1, z: 0))
        
        
        
        planetObjects.forEach { sceneView.scene.rootNode.addChildNode($0.planetNode) }
        
        // TESTING CODE:
        // let ring = Planet.getRing(radius: 2, vector: (x: 0, y: -1, z: 0), color: .yellow)
        // planetObjects.forEach { sceneView.scene.rootNode.addChildNode($0.ringNode) }
        //sceneView.scene.rootNode.addChildNode(node)
        
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
        
        // Pause the view's session
        sceneView.session.pause()
    }

    
}
