//
//  AnalyzeResultMock.swift
//  MjOptimizer
//
//  Created by fetaro on 2014/06/21.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

import Foundation
import UIKit

class AnalyzeResultMock:AnalyzeResultProtocol{
    init(){}
    //牌のリスト。0番目は手牌の一番左
    func getPaiList() -> Pai[]{
        return [ Pai.parse("m1t")! ]
    }
    //牌の位置(paiPositionIndex)を指定すると、その牌がある場所を長方形で返す
    func getPaiPositionRect(paiPositionIndex: Int) -> CGRect {
        return CGRect()
    }
    //解析に成功した牌の数
    func getAnalyzeSuccessNum() -> Int {
        return 14
    }
}