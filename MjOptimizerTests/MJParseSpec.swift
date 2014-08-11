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
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.NAN
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.reachNum = 0
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.isParent = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m1tm1tm1tm1tm2tm2tm3tm3tm7tm7tm8tm8tm9tm9t"
                let mjpr : MjParseResult = MjParse.parse(paiStr, kyoku: kyoku)
                switch mjpr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(30))
                    expect(agari.hanNum).to(equal(13))
                    expect(agari.score.child).to(equal(0))
                    expect(agari.score.parent).to(equal(0))
                    expect(agari.score.total).to(equal(32000))
                    expect(agari.yakuNameList()).to(contain("pinfu"))
                    expect(agari.yakuNameList()).to(contain("ryanpeikou"))
                    expect(agari.yakuNameList()).to(contain("junchan"))
                    expect(agari.yakuNameList()).to(contain("chinitsu"))
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
                expect(MjParse.calcFuNum(agari,kyoku:kyoku)).to(equal(30))
            }
        }
        describe("calcPoint"){
            it("returns child ron"){
                var kyoku : Kyoku = Kyoku()
                kyoku.isTsumo = false
                kyoku.isParent = false
                var s : Score = MjParse.calcPoint(30,hanNum:3,kyoku:kyoku)
                expect(s.child).to(equal(0))
                expect(s.parent).to(equal(0))
                expect(s.total).to(equal(3900))
                s = MjParse.calcPoint(70,hanNum:2,kyoku:kyoku)
                expect(s.child).to(equal(0))
                expect(s.parent).to(equal(0))
                expect(s.total).to(equal(4500))
                s = MjParse.calcPoint(25,hanNum:2,kyoku:kyoku)
                expect(s.child).to(equal(0))
                expect(s.parent).to(equal(0))
                expect(s.total).to(equal(1600))
                expect(s.manganScale).to(equal(0.0))
                s = MjParse.calcPoint(30,hanNum:4,kyoku:kyoku)
                expect(s.child).to(equal(0))
                expect(s.parent).to(equal(0))
                expect(s.total).to(equal(7700))
                s = MjParse.calcPoint(70,hanNum:3,kyoku:kyoku)
                expect(s.child).to(equal(0))
                expect(s.parent).to(equal(0))
                expect(s.total).to(equal(8000))
                expect(s.manganScale).to(equal(1.0))
                s = MjParse.calcPoint(70,hanNum:6,kyoku:kyoku)
                expect(s.child).to(equal(0))
                expect(s.parent).to(equal(0))
                expect(s.total).to(equal(12000))
                expect(s.manganScale).to(equal(1.5))
            }
            it("returns child tsumo"){
                var kyoku : Kyoku = Kyoku()
                kyoku.isTsumo = true
                kyoku.isParent = false
                var s : Score = MjParse.calcPoint(30,hanNum:3,kyoku:kyoku)
                expect(s.child).to(equal(1000))
                expect(s.parent).to(equal(2000))
                expect(s.total).to(equal(4000))
                s = MjParse.calcPoint(70,hanNum:2,kyoku:kyoku)
                expect(s.child).to(equal(1200))
                expect(s.parent).to(equal(2300))
                expect(s.total).to(equal(4700))
                s = MjParse.calcPoint(25,hanNum:2,kyoku:kyoku)
                expect(s.child).to(equal(400))
                expect(s.parent).to(equal(800))
                expect(s.total).to(equal(1600))
                s = MjParse.calcPoint(30,hanNum:4,kyoku:kyoku)
                expect(s.child).to(equal(2000))
                expect(s.parent).to(equal(3900))
                expect(s.total).to(equal(7900))
                s = MjParse.calcPoint(70,hanNum:3,kyoku:kyoku)
                expect(s.child).to(equal(2000))
                expect(s.parent).to(equal(4000))
                expect(s.total).to(equal(8000))
                expect(s.manganScale).to(equal(1.0))
                s = MjParse.calcPoint(70,hanNum:6,kyoku:kyoku)
                expect(s.child).to(equal(3000))
                expect(s.parent).to(equal(6000))
                expect(s.total).to(equal(12000))
                expect(s.manganScale).to(equal(1.5))
            }
            it("returns parent true"){
                var kyoku : Kyoku = Kyoku()
                kyoku.isTsumo = false
                kyoku.isParent = true
                var s : Score = MjParse.calcPoint(30,hanNum:3,kyoku:kyoku)
                expect(s.child).to(equal(0))
                expect(s.parent).to(equal(0))
                expect(s.total).to(equal(5800))
                s = MjParse.calcPoint(70,hanNum:2,kyoku:kyoku)
                expect(s.child).to(equal(0))
                expect(s.parent).to(equal(0))
                expect(s.total).to(equal(6800))
                s = MjParse.calcPoint(25,hanNum:2,kyoku:kyoku)
                expect(s.child).to(equal(0))
                expect(s.parent).to(equal(0))
                expect(s.total).to(equal(2400))
                s = MjParse.calcPoint(30,hanNum:4,kyoku:kyoku)
                expect(s.child).to(equal(0))
                expect(s.parent).to(equal(0))
                expect(s.total).to(equal(11600))
                s = MjParse.calcPoint(70,hanNum:3,kyoku:kyoku)
                expect(s.child).to(equal(0))
                expect(s.parent).to(equal(0))
                expect(s.total).to(equal(12000))
                expect(s.manganScale).to(equal(1.0))
                s = MjParse.calcPoint(70,hanNum:6,kyoku:kyoku)
                expect(s.child).to(equal(0))
                expect(s.parent).to(equal(0))
                expect(s.total).to(equal(18000))
                expect(s.manganScale).to(equal(1.5))
            }
            it("returns"){
                var kyoku : Kyoku = Kyoku()
                kyoku.isTsumo = true
                kyoku.isParent = true
                var s : Score = MjParse.calcPoint(30,hanNum:3,kyoku:kyoku)
                expect(s.child).to(equal(2000))
                expect(s.parent).to(equal(0))
                expect(s.total).to(equal(6000))
                s = MjParse.calcPoint(70,hanNum:2,kyoku:kyoku)
                expect(s.child).to(equal(2300))
                expect(s.parent).to(equal(0))
                expect(s.total).to(equal(6900))
                s = MjParse.calcPoint(25,hanNum:2,kyoku:kyoku)
                expect(s.child).to(equal(800))
                expect(s.parent).to(equal(0))
                expect(s.total).to(equal(2400))
                s = MjParse.calcPoint(30,hanNum:4,kyoku:kyoku)
                expect(s.child).to(equal(3900))
                expect(s.parent).to(equal(0))
                expect(s.total).to(equal(11700))
                s = MjParse.calcPoint(70,hanNum:3,kyoku:kyoku)
                expect(s.child).to(equal(4000))
                expect(s.parent).to(equal(0))
                expect(s.total).to(equal(12000))
                expect(s.manganScale).to(equal(1.0))
                s = MjParse.calcPoint(70,hanNum:6,kyoku:kyoku)
                expect(s.child).to(equal(6000))
                expect(s.parent).to(equal(0))
                expect(s.total).to(equal(18000))
                expect(s.manganScale).to(equal(1.5))
            }
        }
    }
}
