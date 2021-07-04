//
//  ViewController.swift
//  TestLidar
//
//  Created by 阿騰 on 2021/2/4.


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
    var depthData:Depth?
    override func viewDidLoad() {
        super.viewDidLoad()
        let configuration = ARWorldTrackingConfiguration()
        depthData = Depth(arARSession: myDepthARView.session, arConfiguration: configuration)
        // Do any additional setup after loading the view.
    }
    @objc func timerAction() {
        // execute change map setting
        
        if let depthData = depthData{
            let data = depthData.getDepthDistance()
        MM.text="x:128y:96距離\(data.get(x: 128, y: 96))"
            LU.text="x :0y:0)距離\(data.get(x: 0, y: 0))"
            RU.text="x :255y:191距離\(data.get(x: 255, y: 191))"
            LD.text="x:255y:191距離\(data.get(x: 0, y: 191))"
            RD.text="x:254y:191距離\(data.get(x: 254, y: 191))"
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer.invalidate()
    }
}


