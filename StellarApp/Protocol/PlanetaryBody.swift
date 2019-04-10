//
//  PlanetaryBody.swift
//  Stellar
//
//  Created by TingxinLi on 4/10/19.
//  Copyright © 2019 TingxinLi. All rights reserved.
//

import UIKit
import ARKit

protocol PlanetaryBody: CelestialBody {
    var planetNode: SCNNode { set get }
  
}


