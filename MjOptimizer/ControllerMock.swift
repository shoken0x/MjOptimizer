//
//  ControllerMock.swift
//  MjOptimizer
//
//  Created by fetaro on 2014/06/16.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

import Foundation
import UIKit
import CoreMedia

class ControllerMock:ControllerProtocol{
    func sutehaiSelect(image : CMSampleBuffer, targetFrame : CGRect) -> SutehaiSelectResult{
        var sc1:SutehaiCandidate = SutehaiCandidate(
            pai:Pai.parse("m3t")!,
            ukeirePaiList:[
                UkeirePai(pai: Pai.parse("m2t")!,remainNum: 4),
                UkeirePai(pai: Pai.parse("m5t")!,remainNum: 4),
                UkeirePai(pai: Pai.parse("s2t")!,remainNum: 3),
                UkeirePai(pai: Pai.parse("s7t")!,remainNum: 3),
                UkeirePai(pai: Pai.parse("j1t")!,remainNum: 2)
            ],
            shantenNum:3,
            positionIndex:2
        )
        var sc2:SutehaiCandidate = SutehaiCandidate(
            pai:Pai.parse("j1t")!,
            ukeirePaiList:[
                UkeirePai(pai: Pai.parse("m2t")!,remainNum: 4),
                UkeirePai(pai: Pai.parse("m5t")!,remainNum: 4),
                UkeirePai(pai: Pai.parse("s2t")!,remainNum: 3),
                UkeirePai(pai: Pai.parse("s7t")!,remainNum: 3)
            ],
            shantenNum:4,
            positionIndex:5
        )
        var sc3:SutehaiCandidate = SutehaiCandidate(
            pai:Pai.parse("m5t")!,
            ukeirePaiList:[
                UkeirePai(pai: Pai.parse("s2t")!,remainNum: 3),
                UkeirePai(pai: Pai.parse("s7t")!,remainNum: 3),
            ],
            shantenNum:5,
            positionIndex:10
        )

        return SutehaiSelectResult(sutehaiCandidateList : [sc1,sc2,sc3],tehaiShantenNum : 5)
    }
}