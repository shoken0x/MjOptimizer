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
    var singleList: Pai[] = []
    var agariType: AgariType = AgariType.AGARI_TYPE_NORMAL
    var analyzedFlag: Bool = false
    
    init() {
        
    }
    
    // TODO: 実装
    func isAgari() -> Int {
        if true {
            return 1
        }
        else {
            return 0
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
    
}

enum MentsuType: String {
    case KOTSU = "k"
    case SHUNTSU = "s"
}
class Mentsu:ChunkProtocol {
    var paiList: Pai[]
    var type: MentsuType
    
    init (paiList: Pai[], type: MentsuType) {
        self.paiList = paiList
        self.type = type
    }
    func getMissingPaiList() -> Pai[]{
        return []
    }
}

enum TatsuType: String {
    case PENCHAN = "p"
    case KANCHAN = "k"
    case RYANMENCHAN = "r"
}

class Single:ChunkProtocol{
    func getMissingPaiList() -> Pai[]{
        return []//TODO
    }
}
class Tatsu:ChunkProtocol{
    var paiList: Pai[]
    var type: TatsuType
    
    init (paiList: Pai[], type: TatsuType) {
        self.paiList = paiList
        self.type = type
    }
    func getMissingPaiList() -> Pai[]{
        return [] //TODO
    }
}

class Toitsu:ChunkProtocol{
    var paiList: Pai[]
    init (paiList: Pai[]) {
        self.paiList = paiList
    }
    func getMissingPaiList() -> Pai[]{
        return [self.paiList[0]]
    }
}

