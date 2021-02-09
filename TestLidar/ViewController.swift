//
//  ViewController.swift
//  TestLidar
//
//  Created by 阿騰 on 2021/2/4.
//

import UIKit
import RealityKit
import ARKit
import Foundation

class ViewController: UIViewController {
    @IBAction func runDepthDataSwitch(_ sender: UISwitch) {
        if sender.isOn {
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        }
        else{
            timer.invalidate()
        }
    }
    var timer = Timer()
    @IBOutlet weak var myDepthImage: UIImageView!
    @IBOutlet weak var myDepthARView: ARView!
    @IBAction func reDataDepth(_ sender: Any) {
        timerAction()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let configuration = ARWorldTrackingConfiguration()
        configuration.frameSemantics = .sceneDepth
        myDepthARView.session.run(configuration)
        
        // Do any additional setup after loading the view.
    }
    @objc func timerAction() {
        // execute change map setting
        let DepthData=myDepthARView.session.currentFrame?.sceneDepth
        let myCImage = CIImage(cvPixelBuffer: DepthData!.depthMap)
        myDepthImage.image = UIImage(ciImage: myCImage)
    }
    override func viewWillDisappear(_ animated: Bool) {
           super.viewWillDisappear(animated)
           timer.invalidate()
    }
}

