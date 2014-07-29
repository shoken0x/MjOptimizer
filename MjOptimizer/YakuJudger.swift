//
//  YakuParser.swift
//  MjOptimizer
//
//  Created by fetaro on 2014/07/29.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

import Foundation

class YakuJudger{
    let yakuMaster:[Yaku] = [YakuTanyao()]
    func judge(agari:Agari)->[Yaku]{
        var resultList:[Yaku] = []
        for yaku in self.yakuMaster{
            if yaku.enable(agari){
                resultList.append(yaku)
            }
        }
        return resultList
    }
}