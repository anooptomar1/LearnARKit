//
//  TouchARViewController.swift
//  ARKit Example
//
//  Created by 李礼光 on 2017/7/6.
//  Copyright © 2017年 LG. All rights reserved.
//

import UIKit
import ARKit
import SceneKit

class TouchARViewController: UIViewController {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func backToMainVC(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)

    }
}
