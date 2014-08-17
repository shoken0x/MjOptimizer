//
//  Yaku.swift
//  MjOptimizer
//
//  Created by fetaro on 2014/07/29.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

import Foundation

public class Yaku {
    public let name:String   //名前。ローマ字表記
    public let kanji:String  //漢字
    public let hanNum:Int    //鳴いてない場合の翻数
    public let nakiHanNum:Int//鳴いた場合の翻数
    public let isYakuman:Bool//役満かどうか
    public let isDora:Bool   //ドラを示す役かどうか
    init(name:String,kanji:String,hanNum:Int = 13,nakiHanNum:Int = 13,isDora:Bool = false){
        self.name = name
        self.kanji = kanji
        self.hanNum = hanNum
        self.nakiHanNum = nakiHanNum
        self.isYakuman = hanNum == 13
        self.isDora = isDora
    }
}
