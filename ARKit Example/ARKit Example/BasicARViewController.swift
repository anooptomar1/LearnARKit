//
//  BasicARViewController.swift
//  ARKit Example
//
//  Created by 李礼光 on 2017/7/6.
//  Copyright © 2017年 LG. All rights reserved.
//

//  这里面有一个bug待解决,关于线性代数矩阵的问题的.
//  这里面的截图在横屏的时候才是准确的方向,竖屏的时候截图就不是正常的了.会自动向左旋转90度
//  PS : 可以用纯代码的方式去创建,但是这里使用Xib主要是为了简化自动布局的事情

import UIKit
import ARKit
import SceneKit

class BasicARViewController: UIViewController {
    
    //属性
    var session : ARSession!
    var trackConfig : ARWorldTrackingSessionConfiguration!
    
    @IBOutlet var secenView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        session = ARSession()
        session.delegate = self
        trackConfig = ARWorldTrackingSessionConfiguration()
        trackConfig.planeDetection = .horizontal
        session.run(trackConfig, options: .resetTracking)
        secenView.session = session
        let scene  = SCNScene(named: "Models.scnassets/ship.scn")!
        secenView.scene = scene
        setupGes()
    }

  
    @IBAction func backToMain(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}


extension BasicARViewController : ARSessionDelegate {
    
    func isSupported() -> Bool {
        if ARWorldTrackingSessionConfiguration.isSupported {
            print("支持AR")
            return true
        }else {
            print("不支持AR")
            return false
        }
    }
    
    //代理方法
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        //更新frame时调用,也就是刷新界面的时候调用.
        //print(frame)
    }
    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
        //添加锚点时调用
        print("didAdd \(anchors)")
    }
    func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
        //更新锚点时调用
        print("didUpdate \(anchors)")
    }
    func session(_ session: ARSession, didRemove anchors: [ARAnchor]) {
        //移除锚点时调用
        print("didRemove \(anchors)")
    }
}


//添加动作手势
extension BasicARViewController {
    func setupGes()  {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(BasicARViewController.handleTap(gestureRecognize:)))
        view.addGestureRecognizer(tapGesture)
    }
    @objc
    func handleTap(gestureRecognize : UITapGestureRecognizer)  {
        //获取当前帧
        guard let currentFrame = secenView.session.currentFrame else { return  }
        //创建一个节点,是一个平面,这个平面的材质是截取的截图
        let imagePlane = SCNPlane(width: secenView.bounds.width/6000,
                                  height: secenView.bounds.height/6000)
        
        imagePlane.firstMaterial?.diffuse.contents = secenView.snapshot()
        imagePlane.firstMaterial?.lightingModel = .constant
        
        //往AR中添加节点
        let planeNode = SCNNode(geometry: imagePlane)
        secenView.scene.rootNode.addChildNode(planeNode)
        
        //放置截图的位置
        var translation = matrix_identity_float4x4
        translation.columns.3.z = -0.2
        planeNode.simdTransform = matrix_multiply(currentFrame.camera.transform, translation)
        
    }
}






