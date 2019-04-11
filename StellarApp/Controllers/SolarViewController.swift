//
//  ViewController.swift
//  StellarApp
//
//  Created by TingxinLi on 4/5/19.
//  Copyright © 2019 TingxinLi. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet var sceneView: ARSCNView!
    
    let sun = SCNSphere(radius: 0.5)
    let meterial = SCNMaterial()
    let sunNode = SCNNode()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.delegate = self
        
        sceneView.showsStatistics = true
        
        setUpSun()
        
        Planet.getPlanets().forEach { sceneView.scene.rootNode.addChildNode($0) }
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped))
        let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(pinch))
        sceneView.addGestureRecognizer(tapGestureRecognizer)
        sceneView.addGestureRecognizer(pinchGestureRecognizer)
        
    }
    
    @objc func tapped(sender: UITapGestureRecognizer) {
        let tappedView = sender.view as!SCNView
        let touchLocation = sender.location(in: tappedView)
        let hitTest = tappedView.hitTest(touchLocation, options: nil)
        if !hitTest.isEmpty {
            print("yes")
        }
    }
    
    @objc func pinch(pinch: UIPinchGestureRecognizer) {
        
        for planet in Planet.getPlanets() {
            if planet.name == Planet.planetNodes.first?.name {
                
                planet.enumerateChildNodes { (node, stop) in
                    print("node: \(node.name ?? "no name")")
                    if node.name == "jupiter" {
                        node.scale.x = 5.0//newScale
                        node.scale.y = 5.0//newScale
                        node.scale.z = 5.0
                    }
                }
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
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
}
