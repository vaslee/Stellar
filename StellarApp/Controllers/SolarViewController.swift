import UIKit
import SceneKit
import ARKit

class SolarViewController: UIViewController, ARSCNViewDelegate {
    

    @IBOutlet var sceneView: ARSCNView!

  
    
    let sunNode = Sun.getSunNode()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.delegate = self
        
        sceneView.showsStatistics = true
<<<<<<< HEAD
=======
        
>>>>>>> 89228002006c778040676b8e4859095304522289

        sceneView.scene.rootNode.addChildNode(sunNode)
        Planet.getPlanets().forEach { sunNode.addChildNode($0) }


        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped))
        let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(pinch))
        sceneView.addGestureRecognizer(tapGestureRecognizer)
        sceneView.addGestureRecognizer(pinchGestureRecognizer)
<<<<<<< HEAD
=======
        
>>>>>>> 89228002006c778040676b8e4859095304522289

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

        let pinchLocation = pinch.location(in: pinchView)
        let hitTest = pinchView.hitTest(pinchLocation, options: nil)
        if !hitTest.isEmpty {
            let scaleAction = SCNAction.scale(by: pinch.scale, duration: 0)
            SCNNode.deepScaleNode(node: sunNode, scaleAction: scaleAction)
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

}
