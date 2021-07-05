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
    func get(x:Int,y:Int) -> Float {
        return data[x][y]
    }
    
}

