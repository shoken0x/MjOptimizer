//
//  YakuParser.swift
//  MjOptimizer
//
//  Created by fetaro on 2014/07/29.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

import Foundation

public class YakuJudger{
    let yakuCheckerList :[YakuChecker] = [
     YCPinfu(),
     YCTanyao(),
     YCPeikou(),
     YCChanta(),
     YCIkkitsukan(),
     YCSansyoku(),
     YCSansyokudouko(),
     YCToitoihou(),
     YCAnkou(),
     YCKantsu(),
     YCSangen(),
     YCSushihou(),
     YCSomete(),
     YCChitoitsu(),
     YCKokushimuso(),
     YCHaku(),
     YCHatsu(),
     YCChun(),
     YCJikaze(),
     YCBakaze(),
     YCDora(),
     YCReach(),
     YCIppatsu(),
     YCTsumo(),
     YCAgariTiming()
    ]
    public init(){}
    public func judge(agari:Agari,kyoku:Kyoku)->[Yaku]{
        var yakuList:[Yaku] = []
        for yakuChecker in yakuCheckerList{
            var yaku : Yaku? = yakuChecker.check(agari,kyoku:kyoku)
            if(yaku){
                yakuList.append(yaku!)
            }
        }
        for yaku in yakuList{
            println(yaku.kanji)
        }
        return yakuList
    }
}