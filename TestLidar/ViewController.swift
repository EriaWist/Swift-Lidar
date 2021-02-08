//
//  ViewController.swift
//  TestLidar
//
//  Created by 阿騰 on 2021/2/4.
//

import UIKit
import RealityKit
import ARKit

class ViewController: UIViewController {
    @IBOutlet weak var myDepthImage: UIImageView!
    @IBOutlet weak var myDepthARView: ARView!
    @IBAction func reDataDepth(_ sender: Any) {
            let DepthData=myDepthARView.session.currentFrame?.sceneDepth
            let myCImage = CIImage(cvPixelBuffer: DepthData!.depthMap)
            myDepthImage.image = UIImage(ciImage: myCImage)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let configuration = ARWorldTrackingConfiguration()
        configuration.frameSemantics = .sceneDepth
        myDepthARView.session.run(configuration)
        // Do any additional setup after loading the view.
    }
}

