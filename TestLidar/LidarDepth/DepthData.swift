//
//  DepthData.swift
//  TestLidar
//
//  Created by 阿騰 on 2021/7/3.
//

class DepthData {
    private var data = Array(repeating: Array(repeating: Float(-1), count: 192), count: 256)
    func set(x:Int,y:Int,floatData:Float) {
         data[x][y]=floatData
    }
    //x 範圍 255 y範圍191
    func get(x:Int,y:Int) -> Float {
        if x>255||y>191 {
            print("---------------DepthData Error----------------")
            print("x與y的範圍分別在255與191內")
            print("-------------DepthData Error END--------------")
            return -1
        }
        
        return data[x][y]
    }
    
}

