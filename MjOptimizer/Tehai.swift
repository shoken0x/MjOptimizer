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

public class Tehai {
    
    var basePaiList: [Pai] = []
    var restPaiList: [Pai] = []
    var chunkList: [Chunk] = []
    var tatsuList: [Tatsu] = []
    var toitsuList: [Toitsu] = []
    var singleList: [Single] = []
    var agariType: AgariType = AgariType.AGARI_TYPE_NORMAL
    var analyzedFlag: Bool = false
    
    public init(paiList: [Pai] = []) {
        self.basePaiList = paiList
    }
    
    func copy() -> Tehai {
        var tehai: Tehai = Tehai()
        tehai.basePaiList = self.basePaiList
        tehai.restPaiList = self.restPaiList
        tehai.chunkList = self.chunkList
        tehai.tatsuList = self.tatsuList
        tehai.toitsuList = self.toitsuList
        tehai.singleList = self.singleList
        tehai.agariType = self.agariType
        tehai.analyzedFlag = self.analyzedFlag
        return tehai
    }
    
    public func isAgari() -> Bool {
        if self.getShantenNum() == -1 {
            return true
        }
        else {
            return false
        }
    }
    
    public func getShantenNum() -> Int {
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
        var chunkNum = self.chunkList.count
        var chunkKouhoNum = self.tatsuList.count
        var janto = 0
        
        // 対子が複数あれば1つを雀頭にする
        if self.toitsuList.count > 1 {
            janto = 1
            chunkKouhoNum = chunkKouhoNum + self.toitsuList.count - 1
        }
        else {
            chunkKouhoNum = chunkKouhoNum + self.toitsuList.count
        }
        // 面子と面子候補の合計はMAX4なので、5以上はノーカウントにする。
        if chunkNum + chunkKouhoNum > 4 {
            chunkKouhoNum = 4 - chunkNum
        }
        
        // 公式: 8 - ((面子数*2) + 面子候補数 + 雀頭数)
        return 8 - ((chunkNum * 2) + chunkKouhoNum + janto )
    }
    
    func getShantenNumAsChitoitsu() -> Int{
        // 公式: 6 - 対子数
        return 6 - self.toitsuList.count
    }
    
    func getShantenNumAsKokushimuso() -> Int{
        return 0
    }
    
    func getChunkList() -> [ChunkProtocol]{
        var chunkList: [ChunkProtocol] = []
//        chunkList = self.chunkList // OK
//        chunkList = self.chunkList + self.tatsuList + self.toitsuList + self.singleList // NG
        
        for chunk in self.chunkList{
            chunkList.append(chunk)
        }
        for chunk in self.tatsuList{
            chunkList.append(chunk)
        }
        for chunk in self.toitsuList{
            chunkList.append(chunk)
        }
        for chunk in self.singleList{
            chunkList.append(chunk)
        }
        return chunkList
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

class Chunk: ChunkProtocol {
    var paiList: [Pai]
    var type: ChunkType
    
    init (paiList: [Pai], type: ChunkType) {
        self.paiList = paiList
        self.type = type
    }
    func getMissingPaiList() -> [Pai]{
        return []
    }
    func getChunkType() -> ChunkType {
        return self.type
    }
    func getPriority() -> Int {
        var priority = 0
        switch self.type{
        case ChunkType.KOTSU:
            priority = 39
        case ChunkType.SHUNTSU:
            priority = 35
        default:
            priority = 0
        }
        return priority
    }
    func getPaiList() -> [Pai] {
        return self.paiList
    }
}

class Single:ChunkProtocol{
    var pai: Pai
    var type: ChunkType = ChunkType.SINGLE
    
    init (pai: Pai){
        self.pai = pai
    }
    func getMissingPaiList() -> [Pai]{
        var prevPai = pai.getPrevPai(range: 1)
        var nextPai = pai.getNextPai(range: 1)
        var missingPaiList: [Pai] = [pai]
        if (prevPai != nil) {
            missingPaiList.append(prevPai!)
        }
        if (nextPai != nil) {
            missingPaiList.append(nextPai!)
        }
        return missingPaiList
    }
    func getChunkType() -> ChunkType {
        return self.type
    }
    func getPriority() -> Int {
        var priority = 0
        if self.pai.type == PaiType.JIHAI{
            priority = 10
        }
        else if (self.pai.number == 1 || self.pai.number == 9){
            priority = 15
        }
        else{
            priority = 19
        }
        return priority
    }
    func getPaiList() -> [Pai] {
        return [self.pai]
    }
}

class Tatsu:ChunkProtocol{
    var paiList: [Pai]
    var type: ChunkType
    
    init (paiList: [Pai], type: ChunkType) {
        self.paiList = paiList
        self.type = type
    }
    func getMissingPaiList() -> [Pai]{
        var missingPaiList: [Pai] = []
        switch(self.type){
        case ChunkType.PENCHAN:
            if paiList[0].number == 1 {
                missingPaiList.append( paiList[0].getNextPai(range: 1)!)
            }
            else {
                missingPaiList.append( paiList[1].getPrevPai(range: 1)!)
            }
        case ChunkType.KANCHAN:
            if paiList[0].number > paiList[1].number {
                missingPaiList.append( paiList[1].getNextPai(range: 1)!)
            }
            else {
                missingPaiList.append( paiList[0].getNextPai(range: 1)!)
            }
        case ChunkType.RYANMENCHAN:
            if paiList[0].number > paiList[1].number {
                missingPaiList.append( paiList[0].getNextPai(range: 1)!)
                missingPaiList.append( paiList[1].getPrevPai(range: 1)!)
            }
            else {
                missingPaiList.append( paiList[1].getNextPai(range: 1)!)
                missingPaiList.append( paiList[0].getPrevPai(range: 1)!)
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
        var priority = 0
        switch self.type{
        case ChunkType.RYANMENCHAN:
            priority = 29
        case ChunkType.KANCHAN:
            priority = 25
        case ChunkType.PENCHAN:
            priority = 24
        default:
            priority = 0
        }
        return priority
    }
    func getPaiList() -> [Pai] {
        return self.paiList
    }
}

class Toitsu:ChunkProtocol{
    var paiList: [Pai]
    var type: ChunkType = ChunkType.TOITSU
    init (paiList: [Pai]) {
        self.paiList = paiList
    }
    func getMissingPaiList() -> [Pai]{
        return [self.paiList[0]]
    }
    func getChunkType() -> ChunkType {
        return self.type
    }
    func getPriority() -> Int {
        return 24
    }
    func getPaiList() -> [Pai] {
        return self.paiList
    }
}

