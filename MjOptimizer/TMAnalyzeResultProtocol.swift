//
//  TMAnalyzeResult.swift
//  MjOptimizer
//
//  Created by fetaro on 2014/06/15.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

import Foundation
import UIKit

protocol TMAnalyzeResultProtocol{
    //TODO おぎが実装する
    
    //牌のリスト。0番目は手牌の一番左
    func getPaiList() -> Pai[]
    //牌の位置(paiPositionIndex)を指定すると、その牌がある場所を長方形で返す
    func getPaiPositionRect(paiPositionIndex: Int) -> CGRect
}