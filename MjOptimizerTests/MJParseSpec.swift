//
//  MJParseSpec.swift
//  MjOptimizer
//
//  Created by fetaro on 2014/08/11.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

import Foundation


import MjOptimizer
import Quick
import Nimble

class MJParserSpec: QuickSpec {
    override func spec() {
        describe("parse"){
            it("returns チンイツ・順チャン・リャンペいこう"){
                let mjpr : MjParseResult = MjParse.parse("m1tm1tm1tm1tm2tm2tm3tm3tm7tm7tm8tm8tm9tm9t", kyoku: Kyoku())
                switch mjpr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(20))
                    expect(agari.hanNum).to(equal(13))
                    expect(agari.score.c).to(equal(0))
                    expect(agari.score.p).to(equal(0))
                    expect(agari.score.t).to(equal(48000))
                    expect(agari.score.m).to(equal(4.0))
                    expect(agari.yakuList[0].kanji).to(equal("平和"))
                    expect(agari.yakuList[1].kanji).to(equal("二盃口"))
                    expect(agari.yakuList[2].kanji).to(equal("純全帯么九"))
                    expect(agari.yakuList[3].kanji).to(equal("清一色"))
                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }

        }
        describe("yakuJudge"){
            it("returns タンピン三色"){
                let agariPai = PaiMaster.pais["m2t"]!
                var m = Mentsu.parseStr("m2tm3tm4t")!
                m.agariPai = agariPai
                let mentsuList:[Mentsu] = [
                    m,
                    Mentsu.parseStr("s2ts2t")!,
                    Mentsu.parseStr("s2ts3ts4t")!,
                    Mentsu.parseStr("p2tp3tp4t")!,
                    Mentsu.parseStr("p7tp6tp5t")!,
                ]
                let agari = Agari(mentsuList: mentsuList)
                let kyoku = Kyoku()
                let yakuList:[Yaku] = MjParse.yakuJudge(agari,kyoku:kyoku)
                expect(yakuList[0].kanji).to(equal("平和"))
                expect(yakuList[1].kanji).to(equal("断么九"))
                expect(yakuList[2].kanji).to(equal("三色同順"))
            }
            it("returns チンイツ・順チャン・リャンペいこう"){
                let agariPai = PaiMaster.pais["m1t"]!
                var m = Mentsu.parseStr("m1tm2tm3t")!
                m.agariPai = agariPai
                let mentsuList:[Mentsu] = [
                    m,
                    Mentsu.parseStr("m1tm1t")!,
                    Mentsu.parseStr("m1tm2tm3t")!,
                    Mentsu.parseStr("m7tm8tm9t")!,
                    Mentsu.parseStr("m7tm8tm9t")!,
                ]
                let agari = Agari(mentsuList: mentsuList)
                let kyoku = Kyoku()
                let yakuList:[Yaku] = MjParse.yakuJudge(agari,kyoku:kyoku)
                expect(yakuList[0].kanji).to(equal("平和"))
                expect(yakuList[1].kanji).to(equal("二盃口"))
                expect(yakuList[2].kanji).to(equal("純全帯么九"))
                expect(yakuList[3].kanji).to(equal("清一色"))
            }
            it("returns only やくまん"){
                let agariPai = PaiMaster.pais["j5t"]!
                var m = Mentsu.parseStr("j5tj5t")!
                m.agariPai = agariPai
                let mentsuList:[Mentsu] = [
                    m,
                    Mentsu.parseStr("j1tj1tj1tj1t")!,
                    Mentsu.parseStr("j2tj2tj2tj2t")!,
                    Mentsu.parseStr("j3tj3tj3tj3t")!,
                    Mentsu.parseStr("j4tj4tj4tj4t")!,
                ]
                let agari = Agari(mentsuList: mentsuList)
                let kyoku = Kyoku()
                kyoku.finishType = FinishType.TENHO
                let yakuList:[Yaku] = MjParse.yakuJudge(agari,kyoku:kyoku)
                expect(yakuList[0].kanji).to(equal("四暗刻"))
                expect(yakuList[1].kanji).to(equal("四槓子"))
                expect(yakuList[2].kanji).to(equal("大四喜"))
                expect(yakuList[3].kanji).to(equal("字一色"))
            }
        }

        describe("calcFuNum"){
            it("returns 20"){
                let agariPai = PaiMaster.pais["m1t"]!
                var agariMentsu = Mentsu.parseStr("m1tm2tm3t")!
                agariMentsu.agariPai = agariPai
                let mentsuList:[Mentsu] = [
                    agariMentsu,
                    Mentsu.parseStr("m1tm1t")!,
                    Mentsu.parseStr("m1tm2tm3t")!,
                    Mentsu.parseStr("m7tm8tm9t")!,
                    Mentsu.parseStr("m7tm8tm9t")!,
                ]
                let agari = Agari(mentsuList: mentsuList)
                let kyoku = Kyoku()
                expect(MjParse.calcFuNum(agari,kyoku:kyoku)).to(equal(20))
            }
        }
        describe("calcPoint"){
            it("returns child ron"){
                var kyoku : Kyoku = Kyoku()
                kyoku.isTsumo = false
                kyoku.isParent = false
                var s : Score = MjParse.calcPoint(30,hanNum:3,kyoku:kyoku)
                expect(s.c).to(equal(0))
                expect(s.p).to(equal(0))
                expect(s.t).to(equal(3900))
                s = MjParse.calcPoint(70,hanNum:2,kyoku:kyoku)
                expect(s.c).to(equal(0))
                expect(s.p).to(equal(0))
                expect(s.t).to(equal(4500))
                s = MjParse.calcPoint(25,hanNum:2,kyoku:kyoku)
                expect(s.c).to(equal(0))
                expect(s.p).to(equal(0))
                expect(s.t).to(equal(1600))
                expect(s.m).to(equal(0.0))
                s = MjParse.calcPoint(30,hanNum:4,kyoku:kyoku)
                expect(s.c).to(equal(0))
                expect(s.p).to(equal(0))
                expect(s.t).to(equal(7700))
                s = MjParse.calcPoint(70,hanNum:3,kyoku:kyoku)
                expect(s.c).to(equal(0))
                expect(s.p).to(equal(0))
                expect(s.t).to(equal(8000))
                expect(s.m).to(equal(1.0))
                s = MjParse.calcPoint(70,hanNum:6,kyoku:kyoku)
                expect(s.c).to(equal(0))
                expect(s.p).to(equal(0))
                expect(s.t).to(equal(12000))
                expect(s.m).to(equal(1.5))
            }
            it("returns child tsumo"){
                var kyoku : Kyoku = Kyoku()
                kyoku.isTsumo = true
                kyoku.isParent = false
                var s : Score = MjParse.calcPoint(30,hanNum:3,kyoku:kyoku)
                expect(s.c).to(equal(1000))
                expect(s.p).to(equal(2000))
                expect(s.t).to(equal(4000))
                s = MjParse.calcPoint(70,hanNum:2,kyoku:kyoku)
                expect(s.c).to(equal(1200))
                expect(s.p).to(equal(2300))
                expect(s.t).to(equal(4700))
                s = MjParse.calcPoint(25,hanNum:2,kyoku:kyoku)
                expect(s.c).to(equal(400))
                expect(s.p).to(equal(800))
                expect(s.t).to(equal(1600))
                s = MjParse.calcPoint(30,hanNum:4,kyoku:kyoku)
                expect(s.c).to(equal(2000))
                expect(s.p).to(equal(3900))
                expect(s.t).to(equal(7900))
                s = MjParse.calcPoint(70,hanNum:3,kyoku:kyoku)
                expect(s.c).to(equal(2000))
                expect(s.p).to(equal(4000))
                expect(s.t).to(equal(8000))
                expect(s.m).to(equal(1.0))
                s = MjParse.calcPoint(70,hanNum:6,kyoku:kyoku)
                expect(s.c).to(equal(3000))
                expect(s.p).to(equal(6000))
                expect(s.t).to(equal(12000))
                expect(s.m).to(equal(1.5))
            }
            it("returns parent true"){
                var kyoku : Kyoku = Kyoku()
                kyoku.isTsumo = false
                kyoku.isParent = true
                var s : Score = MjParse.calcPoint(30,hanNum:3,kyoku:kyoku)
                expect(s.c).to(equal(0))
                expect(s.p).to(equal(0))
                expect(s.t).to(equal(5800))
                s = MjParse.calcPoint(70,hanNum:2,kyoku:kyoku)
                expect(s.c).to(equal(0))
                expect(s.p).to(equal(0))
                expect(s.t).to(equal(6800))
                s = MjParse.calcPoint(25,hanNum:2,kyoku:kyoku)
                expect(s.c).to(equal(0))
                expect(s.p).to(equal(0))
                expect(s.t).to(equal(2400))
                s = MjParse.calcPoint(30,hanNum:4,kyoku:kyoku)
                expect(s.c).to(equal(0))
                expect(s.p).to(equal(0))
                expect(s.t).to(equal(11600))
                s = MjParse.calcPoint(70,hanNum:3,kyoku:kyoku)
                expect(s.c).to(equal(0))
                expect(s.p).to(equal(0))
                expect(s.t).to(equal(12000))
                expect(s.m).to(equal(1.0))
                s = MjParse.calcPoint(70,hanNum:6,kyoku:kyoku)
                expect(s.c).to(equal(0))
                expect(s.p).to(equal(0))
                expect(s.t).to(equal(18000))
                expect(s.m).to(equal(1.5))
            }
            it("returns"){
                var kyoku : Kyoku = Kyoku()
                kyoku.isTsumo = true
                kyoku.isParent = true
                var s : Score = MjParse.calcPoint(30,hanNum:3,kyoku:kyoku)
                expect(s.c).to(equal(2000))
                expect(s.p).to(equal(0))
                expect(s.t).to(equal(6000))
                s = MjParse.calcPoint(70,hanNum:2,kyoku:kyoku)
                expect(s.c).to(equal(2300))
                expect(s.p).to(equal(0))
                expect(s.t).to(equal(6900))
                s = MjParse.calcPoint(25,hanNum:2,kyoku:kyoku)
                expect(s.c).to(equal(800))
                expect(s.p).to(equal(0))
                expect(s.t).to(equal(2400))
                s = MjParse.calcPoint(30,hanNum:4,kyoku:kyoku)
                expect(s.c).to(equal(3900))
                expect(s.p).to(equal(0))
                expect(s.t).to(equal(11700))
                s = MjParse.calcPoint(70,hanNum:3,kyoku:kyoku)
                expect(s.c).to(equal(4000))
                expect(s.p).to(equal(0))
                expect(s.t).to(equal(12000))
                expect(s.m).to(equal(1.0))
                s = MjParse.calcPoint(70,hanNum:6,kyoku:kyoku)
                expect(s.c).to(equal(6000))
                expect(s.p).to(equal(0))
                expect(s.t).to(equal(18000))
                expect(s.m).to(equal(1.5))
            }
        }
    }
}
