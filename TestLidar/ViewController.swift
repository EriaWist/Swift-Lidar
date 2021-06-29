//
//  ViewController.swift
//  TestLidar
//
//  Created by 阿騰 on 2021/2/4.
//https://www.it-jim.com/blog/iphones-12-pro-lidar-how-to-get-and-interpret-data/

import UIKit
import RealityKit
import ARKit
import Foundation

class ViewController: UIViewController {
    @IBOutlet weak var RD: UILabel!
    @IBOutlet weak var RU: UILabel!
    @IBOutlet weak var LU: UILabel!
    @IBOutlet weak var MM: UILabel!
    @IBOutlet weak var LD: UILabel!
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
        
        
        let depthData =  myDepthARView.session.currentFrame?.sceneDepth?.depthMap
        if let depth = depthData{
            let depthWidth = CVPixelBufferGetWidth(depth)
            let depthHeight = CVPixelBufferGetHeight(depth)
            CVPixelBufferLockBaseAddress(depth, CVPixelBufferLockFlags(rawValue: 0))
            let floatBuffer = unsafeBitCast(CVPixelBufferGetBaseAddress(depth), to: UnsafeMutablePointer<Float32>.self)
            for y in 0...depthHeight-1 {
                for x in 0...depthWidth-1 {
                    let distanceAtXYPoint = floatBuffer[y*depthWidth+x]
                    if x==128&&y==96 {
                        MM.text="x:\(x)y:\(y)距離\(distanceAtXYPoint)"
                    }
                    else if x==0&&y==0{
                        LU.text="x :\(x)y:\(y)距離\(distanceAtXYPoint)"
                    }else if x==255&&y==191{
                        RU.text="x :\(x)y:\(y)距離\(distanceAtXYPoint)"
                    }else if x==0&&y==191{
                        LD.text="x:\(x)y:\(y)距離\(distanceAtXYPoint)"
                    }else if x==254&&y==191{
                        RD.text="x:\(x)y:\(y)距離\(distanceAtXYPoint)"
                    }
                    print("x : \(x) y : \(y)距離\(distanceAtXYPoint)")
                }
            }
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
           super.viewWillDisappear(animated)
           timer.invalidate()
    }
}


