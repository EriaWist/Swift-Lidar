//
//  Depth.swift
//  TestLidar
//
//  Created by 阿騰 on 2021/7/3.
//
//https://www.it-jim.com/blog/iphones-12-pro-lidar-how-to-get-and-interpret-data/
import ARKit
class Depth {
    private let arARSession:ARSession
    private var depthData:ARDepthData?
    init(arARSession:ARSession,arConfiguration:ARConfiguration) {
        self.arARSession=arARSession
        arConfiguration.frameSemantics = .sceneDepth
        arARSession.run(arConfiguration)
        depthData=arARSession.currentFrame?.sceneDepth        
    }
    //取得深度UIimage
    func getUIImage() -> UIImage {
        if let depthData=arARSession.currentFrame?.sceneDepth{
            let myCImage = CIImage(cvPixelBuffer: depthData.depthMap)
            return UIImage(ciImage: myCImage)
        }
        return UIImage()
    }
    //取得詳細數據
    func getDepthDistance() -> DepthData {
        let depthFloatData = DepthData()
        if let depth = arARSession.currentFrame?.sceneDepth?.depthMap{
            let depthWidth = CVPixelBufferGetWidth(depth)
            let depthHeight = CVPixelBufferGetHeight(depth)
            CVPixelBufferLockBaseAddress(depth, CVPixelBufferLockFlags(rawValue: 0))
            let floatBuffer = unsafeBitCast(CVPixelBufferGetBaseAddress(depth), to: UnsafeMutablePointer<Float32>.self)
            for y in 0...depthHeight-1 {
                for x in 0...depthWidth-1 {
                    let distanceAtXYPoint = floatBuffer[y*depthWidth+x]
                    depthFloatData.set(x: x, y: y, floatData: distanceAtXYPoint)
                }
            }
        }
           
       
        
        
        return depthFloatData
    }
}
