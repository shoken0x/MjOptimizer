//
//  YakuParser.swift
//  MjOptimizer
//
//  Created by fetaro on 2014/07/29.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

import Foundation

public class YakuJudger{
    let yakuMaster:[Yaku] = [YakuTanyao()]
    public init(){}
    public func judge(agari:Agari,kyoku:Kyoku)->[Yaku]{
        var resultList:[Yaku] = []
        for yaku in self.yakuMaster{
            if yaku.isConcluded(agari,kyoku: kyoku){
                resultList.append(yaku)
            }
        }
        return resultList
    }
}