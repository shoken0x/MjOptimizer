//
//  Tehai.swift
//  MjOptimizer
//
//  Created by ryosuke on 2014/06/19.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

import Foundation


enum AgariType: String {
    case AGARI_TYPE_NORMAL = "n"
    case AGARI_TYPE_CHITOITSU = "t"
    case AGARI_TYPE_KOKUSHIMUSO = "k"
}

class Tehai {
    
    var basePaiList: Pai[] = []
    var restPaiList: Pai[] = []
    var mentsuList: Mentsu[] = []
    var tatsuList: Tatsu[] = []
    var toitsuList: Toitsu[] = []
    var singleList: Single[] = []
    var agariType: AgariType = AgariType.AGARI_TYPE_NORMAL
    var analyzedFlag: Bool = false
    
    init() {
        
    }
    
    // TODO: 実装
    func isAgari() -> Bool {
        if self.getShantenNum() == -1 {
            return true
        }
        else {
            return false
        }
    }
    
    func getShantenNum() -> Int {
        var shantenNum = 0
        
        switch (self.agariType) {
        case AgariType.AGARI_TYPE_NORMAL:
            shantenNum = getShantenNumAsNormal()
        case AgariType.AGARI_TYPE_CHITOITSU:
            shantenNum = getShantenNumAsChitoitsu()
        case AgariType.AGARI_TYPE_KOKUSHIMUSO:
            shantenNum = getShantenNumAsKokushimuso()
        }
        return shantenNum
    }
    
    func getShantenNumAsNormal() -> Int{
        var mentsuNum = self.mentsuList.count
        var mentsuKouhoNum = self.tatsuList.count
        var janto = 0
        
        // 対子が複数あれば1つを雀頭にする
        if self.toitsuList.count > 1 {
            janto = 1
            mentsuKouhoNum = mentsuKouhoNum + self.toitsuList.count - 1
        }
        else {
            mentsuKouhoNum = mentsuKouhoNum + self.toitsuList.count
        }
        // 面子と面子候補の合計はMAX4なので、5以上はノーカウントにする。
        if mentsuNum + mentsuKouhoNum > 4 {
            mentsuKouhoNum = 4 - mentsuNum
        }
        
        // 公式: 8 - ((面子数*2) + 面子候補数 + 雀頭数)
        return 8 - ((mentsuNum * 2) + mentsuKouhoNum + janto )
    }
    
    func getShantenNumAsChitoitsu() -> Int{
        // 公式: 6 - 対子数
        return 6 - self.toitsuList.count
    }
    
    func getShantenNumAsKokushimuso() -> Int{
        return 0
    }
    
    func getChunkList() -> ChunkProtocol[]{
        var chunklist: ChunkProtocol[] = []
//        chunklist = self.mentsuList
//        chunkList = self.tatsuList
//        chunkList = self.toitsuList
//        chunkList = self.singleList
        //self.tatsuList + self.toitsuList + self.singleList
        return chunklist
    }
}

enum ChunkType: String {
    case KOTSU = "kotsu"
    case SHUNTSU = "shuntsu"
    case PENCHAN = "penchan"
    case KANCHAN = "kanchan"
    case RYANMENCHAN = "ryanmenchan"
    case TOITSU = "toitsu"
    case SINGLE = "single"
}

class Mentsu: ChunkProtocol {
    var paiList: Pai[]
    var type: ChunkType
    
    init (paiList: Pai[], type: ChunkType) {
        self.paiList = paiList
        self.type = type
    }
    func getMissingPaiList() -> Pai[]{
        return []
    }
    func getChunkType() -> ChunkType {
        return self.type
    }
    func getPriority() -> Int {
        return 0
    }
}

class Single:ChunkProtocol{
    var pai: Pai
    var type: ChunkType = ChunkType.SINGLE
    
    init (pai: Pai){
        self.pai = pai
    }
    func getMissingPaiList() -> Pai[]{
        var prevPai = pai.getPrevPai(range: 1)
        var nextPai = pai.getNextPai(range: 1)
        var missingPaiList: Pai[] = [pai]
        if prevPai {
            missingPaiList += prevPai!
        }
        if nextPai {
            missingPaiList += nextPai!
        }
        return missingPaiList
    }
    func getChunkType() -> ChunkType {
        return self.type
    }
    func getPriority() -> Int {
        return 0
    }
}

class Tatsu:ChunkProtocol{
    var paiList: Pai[]
    var type: ChunkType
    
    init (paiList: Pai[], type: ChunkType) {
        self.paiList = paiList
        self.type = type
    }
    func getMissingPaiList() -> Pai[]{
        var missingPaiList: Pai[] = []
        switch(self.type){
        case ChunkType.PENCHAN:
            if paiList[0].number == 1 {
                missingPaiList += paiList[0].getNextPai(range: 1)!
            }
            else {
                missingPaiList += paiList[1].getPrevPai(range: 1)!
            }
        case ChunkType.KANCHAN:
            if paiList[0].number > paiList[1].number {
                missingPaiList += paiList[1].getNextPai(range: 1)!
            }
            else {
                missingPaiList += paiList[0].getNextPai(range: 1)!
            }
        case ChunkType.RYANMENCHAN:
            if paiList[0].number > paiList[1].number {
                missingPaiList += paiList[0].getNextPai(range: 1)!
                missingPaiList += paiList[1].getPrevPai(range: 1)!
            }
            else {
                missingPaiList += paiList[1].getNextPai(range: 1)!
                missingPaiList += paiList[0].getPrevPai(range: 1)!
            }
        default:
            true
        }
        return missingPaiList
    }
    func getChunkType() -> ChunkType {
        return self.type
    }
    func getPriority() -> Int {
        return 0
    }
}

class Toitsu:ChunkProtocol{
    var paiList: Pai[]
    var type: ChunkType = ChunkType.TOITSU
    init (paiList: Pai[]) {
        self.paiList = paiList
    }
    func getMissingPaiList() -> Pai[]{
        return [self.paiList[0]]
    }
    func getChunkType() -> ChunkType {
        return self.type
    }
    func getPriority() -> Int {
        return 0
    }
}

