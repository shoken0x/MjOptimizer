//
//  PaiPairProtocol.swift
//  MjOptimizer
//
//  Created by fetaro on 2014/06/21.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

import Foundation

protocol ChunkProtocol{
    //孤立牌であれば、ターツやトイツになる牌を返す
    //ターツやといつであれば、メンツになる牌を返す
    //メンツであれば、空の配列を返す
    func getMissingPaiList() -> Pai[]
    func getChunkType() -> ChunkType
    func getPriority() -> Int
    //そのチャンクを構成する牌
    func getPaiList() -> Pai[]
}