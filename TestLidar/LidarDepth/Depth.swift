//
//  Depth.swift
//  TestLidar
//
//  Created by 阿騰 on 2021/7/3.
//

import ARKit
class Depth {
    let arARSession:ARSession
    let arConfiguration:ARConfiguration
    let depthData:ARDepthData?
    init(arARSession:ARSession,arConfiguration:ARConfiguration) {
        self.arARSession=arARSession
        self.arConfiguration=arConfiguration
        
        self.arConfiguration.frameSemantics = .sceneDepth
        arARSession.run(arConfiguration)
        depthData=arARSession.currentFrame?.sceneDepth
    }
    
    func getUIImage() -> UIImage {
        if let depthData=self.depthData{
            let myCImage = CIImage(cvPixelBuffer: depthData.depthMap)
            return UIImage(ciImage: myCImage)
        }
        return UIImage()
    }
    func getDepthDistance() -> DepthData {
        if let depth = depthData?.depthMap{
            let depthWidth = CVPixelBufferGetWidth(depth)
            let depthHeight = CVPixelBufferGetHeight(depth)
            CVPixelBufferLockBaseAddress(depth, CVPixelBufferLockFlags(rawValue: 0))
            let floatBuffer = unsafeBitCast(CVPixelBufferGetBaseAddress(depth), to: UnsafeMutablePointer<Float32>.self)
            for y in 0...depthHeight-1 {
                for x in 0...depthWidth-1 {
                    let distanceAtXYPoint = floatBuffer[y*depthWidth+x]
                    
                    print("x : \(x) y : \(y)距離\(distanceAtXYPoint)")
                }
            }
        }
        
        
        return DepthData()
    }
}
