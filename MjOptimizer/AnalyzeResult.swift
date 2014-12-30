//
//  AnalyzeResult.swift
//  MjOptimizer
//
//  Created by fetaro on 2014/12/30.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

import Foundation

class AnalyzeResult {
    let resultList: [TMResult]
    let paiList: [Pai]
    let targetImage: UIImage
    let debugImage: UIImage
    init(resultList: [TMResult],targetImage: UIImage,debugImage: UIImage) {
        self.resultList = resultList
        self.paiList = resultList.map{ $0.pai }
        self.targetImage = targetImage
        self.debugImage = debugImage
    }
    
    //牌の位置(paiPositionIndex)を指定すると、その牌がある場所を長方形で返す
    func getPaiPositionRect(paiPositionIndex: Int) -> CGRect {
        return resultList[paiPositionIndex].place
    }

    //文字列で表示
    func toString() -> String{
        return "画像解析結果 牌:\(resultList.count)枚 paiList:" + join(",",paiList.map({$0.toString() }))
    }
}
