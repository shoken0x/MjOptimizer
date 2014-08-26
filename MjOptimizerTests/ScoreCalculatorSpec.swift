//
//  ScoreCalculatorSpec.swift
//  MjOptimizer
//
//  Created by fetaro on 2014/08/11.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

import Foundation


import MjOptimizer
import Quick
import Nimble

class TotalSpec: QuickSpec {
    override func spec() {
        
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
                expect(ScoreCalculator.calcFuNum(agari,kyoku:kyoku)).to(equal(30))
            }
        }
        describe("calcPoint"){
            it("returns child ron"){
                var kyoku : Kyoku = Kyoku()
                kyoku.isTsumo = false
                kyoku.jikaze = Kaze.NAN
                var s : Score = ScoreCalculator.calcPoint(30,hanNum:3,kyoku:kyoku)
                expect(s.child).to(equal(0))
                expect(s.parent).to(equal(0))
                expect(s.total).to(equal(3900))
                s = ScoreCalculator.calcPoint(70,hanNum:2,kyoku:kyoku)
                expect(s.child).to(equal(0))
                expect(s.parent).to(equal(0))
                expect(s.total).to(equal(4500))
                s = ScoreCalculator.calcPoint(25,hanNum:2,kyoku:kyoku)
                expect(s.child).to(equal(0))
                expect(s.parent).to(equal(0))
                expect(s.total).to(equal(1600))
                expect(s.manganScale).to(equal(0.0))
                s = ScoreCalculator.calcPoint(30,hanNum:4,kyoku:kyoku)
                expect(s.child).to(equal(0))
                expect(s.parent).to(equal(0))
                expect(s.total).to(equal(7700))
                s = ScoreCalculator.calcPoint(70,hanNum:3,kyoku:kyoku)
                expect(s.child).to(equal(0))
                expect(s.parent).to(equal(0))
                expect(s.total).to(equal(8000))
                expect(s.manganScale).to(equal(1.0))
                s = ScoreCalculator.calcPoint(70,hanNum:6,kyoku:kyoku)
                expect(s.child).to(equal(0))
                expect(s.parent).to(equal(0))
                expect(s.total).to(equal(12000))
                expect(s.manganScale).to(equal(1.5))
            }
            it("returns child tsumo"){
                var kyoku : Kyoku = Kyoku()
                kyoku.isTsumo = true
                kyoku.jikaze = Kaze.NAN
                var s : Score = ScoreCalculator.calcPoint(30,hanNum:3,kyoku:kyoku)
                expect(s.child).to(equal(1000))
                expect(s.parent).to(equal(2000))
                expect(s.total).to(equal(4000))
                s = ScoreCalculator.calcPoint(70,hanNum:2,kyoku:kyoku)
                expect(s.child).to(equal(1200))
                expect(s.parent).to(equal(2300))
                expect(s.total).to(equal(4700))
                s = ScoreCalculator.calcPoint(25,hanNum:2,kyoku:kyoku)
                expect(s.child).to(equal(400))
                expect(s.parent).to(equal(800))
                expect(s.total).to(equal(1600))
                s = ScoreCalculator.calcPoint(30,hanNum:4,kyoku:kyoku)
                expect(s.child).to(equal(2000))
                expect(s.parent).to(equal(3900))
                expect(s.total).to(equal(7900))
                s = ScoreCalculator.calcPoint(70,hanNum:3,kyoku:kyoku)
                expect(s.child).to(equal(2000))
                expect(s.parent).to(equal(4000))
                expect(s.total).to(equal(8000))
                expect(s.manganScale).to(equal(1.0))
                s = ScoreCalculator.calcPoint(70,hanNum:6,kyoku:kyoku)
                expect(s.child).to(equal(3000))
                expect(s.parent).to(equal(6000))
                expect(s.total).to(equal(12000))
                expect(s.manganScale).to(equal(1.5))
            }
            it("returns parent true"){
                var kyoku : Kyoku = Kyoku()
                kyoku.isTsumo = false
                var s : Score = ScoreCalculator.calcPoint(30,hanNum:3,kyoku:kyoku)
                expect(s.child).to(equal(0))
                expect(s.parent).to(equal(0))
                expect(s.total).to(equal(5800))
                s = ScoreCalculator.calcPoint(70,hanNum:2,kyoku:kyoku)
                expect(s.child).to(equal(0))
                expect(s.parent).to(equal(0))
                expect(s.total).to(equal(6800))
                s = ScoreCalculator.calcPoint(25,hanNum:2,kyoku:kyoku)
                expect(s.child).to(equal(0))
                expect(s.parent).to(equal(0))
                expect(s.total).to(equal(2400))
                s = ScoreCalculator.calcPoint(30,hanNum:4,kyoku:kyoku)
                expect(s.child).to(equal(0))
                expect(s.parent).to(equal(0))
                expect(s.total).to(equal(11600))
                s = ScoreCalculator.calcPoint(70,hanNum:3,kyoku:kyoku)
                expect(s.child).to(equal(0))
                expect(s.parent).to(equal(0))
                expect(s.total).to(equal(12000))
                expect(s.manganScale).to(equal(1.0))
                s = ScoreCalculator.calcPoint(70,hanNum:6,kyoku:kyoku)
                expect(s.child).to(equal(0))
                expect(s.parent).to(equal(0))
                expect(s.total).to(equal(18000))
                expect(s.manganScale).to(equal(1.5))
            }
            it("returns"){
                var kyoku : Kyoku = Kyoku()
                kyoku.isTsumo = true
                var s : Score = ScoreCalculator.calcPoint(30,hanNum:3,kyoku:kyoku)
                expect(s.child).to(equal(2000))
                expect(s.parent).to(equal(0))
                expect(s.total).to(equal(6000))
                s = ScoreCalculator.calcPoint(70,hanNum:2,kyoku:kyoku)
                expect(s.child).to(equal(2300))
                expect(s.parent).to(equal(0))
                expect(s.total).to(equal(6900))
                s = ScoreCalculator.calcPoint(25,hanNum:2,kyoku:kyoku)
                expect(s.child).to(equal(800))
                expect(s.parent).to(equal(0))
                expect(s.total).to(equal(2400))
                s = ScoreCalculator.calcPoint(30,hanNum:4,kyoku:kyoku)
                expect(s.child).to(equal(3900))
                expect(s.parent).to(equal(0))
                expect(s.total).to(equal(11700))
                s = ScoreCalculator.calcPoint(70,hanNum:3,kyoku:kyoku)
                expect(s.child).to(equal(4000))
                expect(s.parent).to(equal(0))
                expect(s.total).to(equal(12000))
                expect(s.manganScale).to(equal(1.0))
                s = ScoreCalculator.calcPoint(70,hanNum:6,kyoku:kyoku)
                expect(s.child).to(equal(6000))
                expect(s.parent).to(equal(0))
                expect(s.total).to(equal(18000))
                expect(s.manganScale).to(equal(1.5))
            }
        }

        describe("calc"){
            it("default kyoku"){
                let paiList:[Pai] = Pai.parseList("m2tm3tm6tm7tm8ts4ts5ts6tp7tp8tp9tp9tp9tm4t")!
                let scr : ScoreCalcResult = ScoreCalculator.calc(paiList)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(30))
                    expect(agari.hanNum).to(equal(1))
                    expect(agari.score.total).to(equal(1500))
                    expect(agari.yakuNameList()).to(contain("pinfu"))
                    
                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }
        }
        describe("calcFromStr"){
            it("ttp://dora12.com/2/yakuten/1mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.NAN
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m2tm3tm6tm7tm8ts4ts5ts6tp7tp8tp9tp9tp9tm4t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(30))
                    expect(agari.hanNum).to(equal(1))
                    expect(agari.score.total).to(equal(1000))
                    expect(agari.yakuNameList()).to(contain("pinfu"))
                    
                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }

////以下のケースは量が多いため、普段はコメントアウト

            it("ttp://dora12.com/2/yakuten/2mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.SHA
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = false
                kyoku.doraNum = 1
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m3tm4ts5ts6ts7tp5tp6tp7tp9tp9tm2tj3tj3lj3t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(30))
                    expect(agari.hanNum).to(equal(2))
                    expect(agari.score.total).to(equal(2000))
                    expect(agari.yakuNameList()).to(contain("jikazesha"))
                    expect(agari.yakuNameList()).to(contain("dora1"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/3mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.PEI
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "p1tp2tp4tp4tp6tp7tp8tp3tp8lp6tp7tj4tj4lj4t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(30))
                    expect(agari.hanNum).to(equal(3))
                    expect(agari.score.total).to(equal(3900))
                    expect(agari.yakuNameList()).to(contain("jikazepei"))
                    expect(agari.yakuNameList()).to(contain("honitsu"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/4mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.NAN
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = false
                kyoku.doraNum = 1
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m2tm2tm3tm3tm4tm4ts6ts7ts8tp5tp6tp8tp8tp7t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(30))
                    expect(agari.hanNum).to(equal(4))
                    expect(agari.score.total).to(equal(7700))
                    expect(agari.yakuNameList()).to(contain("tanyao"))
                    expect(agari.yakuNameList()).to(contain("pinfu"))
                    expect(agari.yakuNameList()).to(contain("iipeikou"))
                    expect(agari.yakuNameList()).to(contain("dora1"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/5mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.SHA
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = true
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m4tm4tm5tm5tm6tm6ts4ts5ts6tp5tp6tp9tp9tp4t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(30))
                    expect(agari.hanNum).to(equal(5))
                    expect(agari.score.total).to(equal(8000))
                    expect(agari.yakuNameList()).to(contain("reach"))
                    expect(agari.yakuNameList()).to(contain("pinfu"))
                    expect(agari.yakuNameList()).to(contain("sansyoku"))
                    expect(agari.yakuNameList()).to(contain("iipeikou"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/6mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.PEI
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m3tm4tm5tm7tm8tm9ts8ts8ts8tj5tj5tp8tp8tj5t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(40))
                    expect(agari.hanNum).to(equal(1))
                    expect(agari.score.total).to(equal(1300))
                    expect(agari.yakuNameList()).to(contain("haku"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/7mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.NAN
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m2tm2ts4ts5ts6tp1tp2tp3tp4tp5tp6tp8tp9tp7t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(40))
                    expect(agari.hanNum).to(equal(2))
                    expect(agari.score.total).to(equal(2600))
                    expect(agari.yakuNameList()).to(contain("ikkitsukan"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/8mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.SHA
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = false
                kyoku.doraNum = 1
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "s2ts3ts4ts5ts2tm9tm9lm9ts9ts9ts9lp9tp9lp9t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(40))
                    expect(agari.hanNum).to(equal(3))
                    expect(agari.score.total).to(equal(5200))
                    expect(agari.yakuNameList()).to(contain("sansyokudouko"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/9mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.PEI
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m2tm2tm2tm7tm7tm7ts6ts6ts6tp2tp2tj2lj2tj2t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(40))
                    expect(agari.hanNum).to(equal(4))
                    expect(agari.score.total).to(equal(8000))
                    expect(agari.yakuNameList()).to(contain("toitoihou"))
                    expect(agari.yakuNameList()).to(contain("sanankou"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/10mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.NAN
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = true
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "s2ts2ts3ts3ts4ts4ts6ts7ts8ts8ts9tj4tj4ts7t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(40))
                    expect(agari.hanNum).to(equal(5))
                    expect(agari.score.total).to(equal(8000))
                    expect(agari.yakuNameList()).to(contain("reach"))
                    expect(agari.yakuNameList()).to(contain("honitsu"))
                    expect(agari.yakuNameList()).to(contain("iipeikou"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }
            it("ttp://dora12.com/2/yakuten/11mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.SHA
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m2tm2tm5tm5tm8tm8ts2ts2ts3ts3ts4ts4ts9ts9t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(25))
                    expect(agari.hanNum).to(equal(2))
                    expect(agari.score.total).to(equal(1600))
                    expect(agari.yakuNameList()).to(contain("chitoitsu"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/12mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.SHA
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m2tm2tm8tm8ts3ts3ts4ts4ts5ts5ts7ts7ts8ts8t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(25))
                    expect(agari.hanNum).to(equal(3))
                    expect(agari.score.total).to(equal(3200))
                    expect(agari.yakuNameList()).to(contain("tanyao"))
                    expect(agari.yakuNameList()).to(contain("chitoitsu"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/13mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.PEI
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m1tm1tm9tm9ts1ts1ts9ts9tj1tj1tj3tj3tj6tj6t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(25))
                    expect(agari.hanNum).to(equal(4))
                    expect(agari.score.total).to(equal(6400))
                    expect(agari.yakuNameList()).to(contain("honroutou"))
                    expect(agari.yakuNameList()).to(contain("chitoitsu"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/14mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.PEI
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = true
                kyoku.doraNum = 2
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m1tm1tm3tm3tm6tm6ts6ts6tp4tp4tp7tp7tj4tj4t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(25))
                    expect(agari.hanNum).to(equal(5))
                    expect(agari.score.total).to(equal(8000))
                    expect(agari.yakuNameList()).to(contain("reach"))
                    expect(agari.yakuNameList()).to(contain("chitoitsu"))
                    expect(agari.yakuNameList()).to(contain("dora2"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/15mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.NAN
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m1tm2tm3tm4tm5tm6ts3ts4ts5tp7tp8tp9tp9tp6t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(20))
                    expect(agari.hanNum).to(equal(2))
                    expect(agari.score.total).to(equal(1500))
                    expect(agari.yakuNameList()).to(contain("tsumo"))
                    expect(agari.yakuNameList()).to(contain("pinfu"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/16mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.SHA
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = false
                kyoku.doraNum = 1
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m3tm4tm5tm7tm8tm9ts1ts2ts3tp4tp5tj4tj4tp3t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(20))
                    expect(agari.hanNum).to(equal(3))
                    expect(agari.score.total).to(equal(2700))
                    expect(agari.yakuNameList()).to(contain("tsumo"))
                    expect(agari.yakuNameList()).to(contain("pinfu"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/17mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.PEI
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = false
                kyoku.doraNum = 1
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m2tm2tm2tm3tm4tm6tm7tm8ts3ts4ts5tp7tp8tp6t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(20))
                    expect(agari.hanNum).to(equal(4))
                    expect(agari.score.total).to(equal(5200))
                    expect(agari.yakuNameList()).to(contain("tsumo"))
                    expect(agari.yakuNameList()).to(contain("tanyao"))
                    expect(agari.yakuNameList()).to(contain("pinfu"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/18mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.NAN
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m1tm2tm3tm7tm8tm9ts1ts2ts3tp7tp8tp9tp9tp9t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(20))
                    expect(agari.hanNum).to(equal(5))
                    expect(agari.score.total).to(equal(8000))
                    expect(agari.yakuNameList()).to(contain("tsumo"))
                    expect(agari.yakuNameList()).to(contain("pinfu"))
                    expect(agari.yakuNameList()).to(contain("junchan"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/19mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.SHA
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m5tm6tm7ts3ts4ts7ts7ts5tm4lm2tm3tp6lp7tp8t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(30))
                    expect(agari.hanNum).to(equal(1))
                    expect(agari.score.total).to(equal(1100))
                    expect(agari.yakuNameList()).to(contain("tanyao"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/20mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.NAN
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m2tm3tm4tm5tm6tm7ts5ts6tj4tj4ts4tj2tj2lj2t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(30))
                    expect(agari.hanNum).to(equal(2))
                    expect(agari.score.total).to(equal(2000))
                    expect(agari.yakuNameList()).to(contain("jikazenan"))
                    expect(agari.yakuNameList()).to(contain("bakazenan"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/21mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.PEI
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = false
                kyoku.doraNum = 1
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m2tm2tm3tm3tm4tm4ts3ts4tp6tp6ts2tp2lp3tp4t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(30))
                    expect(agari.hanNum).to(equal(3))
                    expect(agari.score.total).to(equal(4000))
                    expect(agari.yakuNameList()).to(contain("tanyao"))
                    expect(agari.yakuNameList()).to(contain("sansyoku"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/22mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.NAN
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = true
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.HAITEI
                let paiStr = "m1tm2tm3tm7tm8tm9tp7tp8tj6tj6tj6tj4tj4tp6t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(30))
                    expect(agari.hanNum).to(equal(4))
                    expect(agari.score.total).to(equal(7900))
                    expect(agari.yakuNameList()).to(contain("reach"))
                    expect(agari.yakuNameList()).to(contain("tsumo"))
                    expect(agari.yakuNameList()).to(contain("hatsu"))
                    expect(agari.yakuNameList()).to(contain("haitei"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/23mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.SHA
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m1tm2tm3tm7tm8tm9ts7ts8ts9tp8tp9tj7tj7tp7t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(30))
                    expect(agari.hanNum).to(equal(5))
                    expect(agari.score.total).to(equal(8000))
                    expect(agari.yakuNameList()).to(contain("tsumo"))
                    expect(agari.yakuNameList()).to(contain("chanta"))
                    expect(agari.yakuNameList()).to(contain("sansyoku"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/24mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.PEI
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.RINSHAN
                let paiStr = "m4tm5tm6ts3ts4ts8ts8ts5tr0tp2tp2tr0tm1lm2tm3t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(40))
                    expect(agari.hanNum).to(equal(1))
                    expect(agari.score.total).to(equal(1500))
                    expect(agari.yakuNameList()).to(contain("rinshan"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/25mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.NAN
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m1tm1tm2tm2tm2ts6ts6ls6ts8ls8ts8tj4tj4lj4t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(40))
                    expect(agari.hanNum).to(equal(2))
                    expect(agari.score.total).to(equal(2700))
                    expect(agari.yakuNameList()).to(contain("toitoihou"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/26mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.NAN
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = false
                kyoku.doraNum = 1
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m1tm1tm1tm4tm5tj2tj2tj2tj4tj4tm6tp7lp8tp9t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(40))
                    expect(agari.hanNum).to(equal(3))
                    expect(agari.score.total).to(equal(5200))
                    expect(agari.yakuNameList()).to(contain("jikazenan"))
                    expect(agari.yakuNameList()).to(contain("bakazenan"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/27mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.SHA
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m2tm2tm2ts4ts5ts6tj6tj6tj5lj5tj5tj7tj7tj7l"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(40))
                    expect(agari.hanNum).to(equal(4))
                    expect(agari.score.total).to(equal(8000))
                    expect(agari.yakuNameList()).to(contain("haku"))
                    expect(agari.yakuNameList()).to(contain("chun"))
                    expect(agari.yakuNameList()).to(contain("shousangen"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/28mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.SHA
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m5tm5tm5ts8ts8ts8tp2tp2tp3tp3tp2tm2lm2tm2t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(40))
                    expect(agari.hanNum).to(equal(5))
                    expect(agari.score.total).to(equal(8000))
                    expect(agari.yakuNameList()).to(contain("tanyao"))
                    expect(agari.yakuNameList()).to(contain("sanankou"))
                    expect(agari.yakuNameList()).to(contain("toitoihou"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/29mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.PEI
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m1tm1tm3tm3tm5tm5ts7ts7tp6tp6tj2tj2tj3tj3t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(25))
                    expect(agari.hanNum).to(equal(3))
                    expect(agari.score.total).to(equal(3200))
                    expect(agari.yakuNameList()).to(contain("tsumo"))
                    expect(agari.yakuNameList()).to(contain("chitoitsu"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/30mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.NAN
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m2tm2tm4tm4tm8tm8ts2ts2ts8ts8tp6tp6tp7tp7t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(25))
                    expect(agari.hanNum).to(equal(4))
                    expect(agari.score.total).to(equal(6400))
                    expect(agari.yakuNameList()).to(contain("tsumo"))
                    expect(agari.yakuNameList()).to(contain("tanyao"))
                    expect(agari.yakuNameList()).to(contain("chitoitsu"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/31mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.SHA
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = true
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m2tm2tm4tm4tm8tm8ts2ts2ts8ts8tp6tp6tp7tp7t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(25))
                    expect(agari.hanNum).to(equal(5))
                    expect(agari.score.total).to(equal(8000))
                    expect(agari.yakuNameList()).to(contain("reach"))
                    expect(agari.yakuNameList()).to(contain("tsumo"))
                    expect(agari.yakuNameList()).to(contain("tanyao"))
                    expect(agari.yakuNameList()).to(contain("chitoitsu"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }

            it("ttp://dora12.com/2/yakuten/32mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.PEI
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m3tm4ts4ts5ts6ts8ts8tm2tj2lj2tj2tj3tj3tj3l"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    //ここにきたらテスト失敗
                    expect(true).to(beFalsy())
                case let .ERROR(msg):
                    expect(msg).to(equal("役がありません"))
                    expect(true).to(beTruthy())
                }
            }
            
            it("ttp://dora12.com/2/yakuten/33mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.NAN
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m1tm2tm3tm4tm5tm6ts5ts6ts8ts8ts4tj1lj1tj1t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    //ここにきたらテスト失敗
                    expect(true).to(beFalsy())
                case let .ERROR(msg):
                    expect(msg).to(equal("役がありません"))
                    expect(true).to(beTruthy())
                }
            }
            


            it("ttp://dora12.com/2/yakuten/34mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m3tm4tm5ts4ts5ts6tp7tp8tp1tp1tp9tj1tj1lj1t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(30))
                    expect(agari.hanNum).to(equal(1))
                    expect(agari.score.total).to(equal(1500))
                    expect(agari.yakuNameList()).to(contain("jikazeton"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/35mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m3tm4tm5ts4ts5ts6tp7tp8tp1tp1tp9tj1tj1lj1t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(30))
                    expect(agari.hanNum).to(equal(2))
                    expect(agari.score.total).to(equal(2900))
                    expect(agari.yakuNameList()).to(contain("jikazeton"))
                    expect(agari.yakuNameList()).to(contain("bakazeton"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/36mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m1tm1tm2tm3ts7ts8ts9tp7tp8tp9tm1tm7lm8tm9t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(30))
                    expect(agari.hanNum).to(equal(3))
                    expect(agari.score.total).to(equal(5800))
                    expect(agari.yakuNameList()).to(contain("junchan"))
                    expect(agari.yakuNameList()).to(contain("sansyoku"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/37mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = false
                kyoku.doraNum = 1
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m1tm1tm2tm3tm3ts7ts8ts9tj4tj4tm2tj1tj1tj1l"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(30))
                    expect(agari.hanNum).to(equal(4))
                    expect(agari.score.total).to(equal(11600))
                    expect(agari.yakuNameList()).to(contain("jikazeton"))
                    expect(agari.yakuNameList()).to(contain("bakazeton"))
                    expect(agari.yakuNameList()).to(contain("chanta"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/38mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = true
                kyoku.doraNum = 0
                kyoku.isIppatsu = true
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m1tm1ts2ts3ts4tp1tp2tp3tp4tp5tp6tp7tp8tp9t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(30))
                    expect(agari.hanNum).to(equal(5))
                    expect(agari.score.total).to(equal(12000))
                    expect(agari.yakuNameList()).to(contain("reach"))
                    expect(agari.yakuNameList()).to(contain("ippatsu"))
                    expect(agari.yakuNameList()).to(contain("pinfu"))
                    expect(agari.yakuNameList()).to(contain("ikkitsukan"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/39mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m3tm4tm6tm7tm8ts7ts7tm2tr0tp5tp5tr0ts4ls3ts5t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(40))
                    expect(agari.hanNum).to(equal(1))
                    expect(agari.score.total).to(equal(2000))
                    expect(agari.yakuNameList()).to(contain("tanyao"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            //40mon.phpはダブルリーチなので、未対応

            it("ttp://dora12.com/2/yakuten/41mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m1tm2tm3tm3tm4tm5tm6tm7tm8tj2tj2tj3tj3tj3t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(40))
                    expect(agari.hanNum).to(equal(3))
                    expect(agari.score.total).to(equal(7700))
                    expect(agari.yakuNameList()).to(contain("honitsu"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/42mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m3tm3tm4tm5tm5tp2tp2tp3tp3tp4tp4tp7tp7tm4t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(40))
                    expect(agari.hanNum).to(equal(4))
                    expect(agari.score.total).to(equal(12000))
                    expect(agari.yakuNameList()).to(contain("tanyao"))
                    expect(agari.yakuNameList()).to(contain("ryanpeikou"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/43mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m1tm3tm7tm8tm9ts1ts2ts3tp1tp2tp3tp9tp9tm2t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(40))
                    expect(agari.hanNum).to(equal(5))
                    expect(agari.score.total).to(equal(12000))
                    expect(agari.yakuNameList()).to(contain("junchan"))
                    expect(agari.yakuNameList()).to(contain("sansyoku"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/44mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m1tm1tm2tm2tm3tm3tm6tm6ts6ts6tp9tp9tj4tj4t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(25))
                    expect(agari.hanNum).to(equal(2))
                    expect(agari.score.total).to(equal(2400))
                    expect(agari.yakuNameList()).to(contain("chitoitsu"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/45mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = true
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m5tm5ts5ts5tp5tp5tj2tj2tj3tj3tj5tj5tj1tj1t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(25))
                    expect(agari.hanNum).to(equal(3))
                    expect(agari.score.total).to(equal(4800))
                    expect(agari.yakuNameList()).to(contain("reach"))
                    expect(agari.yakuNameList()).to(contain("chitoitsu"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/46mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = true
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m2tm2tm4tm4tm6tm6ts3ts3ts6ts6tp2tp2tp3tp3t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(25))
                    expect(agari.hanNum).to(equal(4))
                    expect(agari.score.total).to(equal(9600))
                    expect(agari.yakuNameList()).to(contain("reach"))
                    expect(agari.yakuNameList()).to(contain("tanyao"))
                    expect(agari.yakuNameList()).to(contain("chitoitsu"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/47mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = false
                kyoku.doraNum = 2
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m3tm3tm6tm6ts2ts2ts3ts3tp4tp4tp7tp7tp8tp8t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(25))
                    expect(agari.hanNum).to(equal(5))
                    expect(agari.score.total).to(equal(12000))
                    expect(agari.yakuNameList()).to(contain("tanyao"))
                    expect(agari.yakuNameList()).to(contain("chitoitsu"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/48mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m1tm2tm3tm5tm6tm7ts4ts5ts6tp2tp3tp5tp5tp1t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(20))
                    expect(agari.hanNum).to(equal(2))
                    expect(agari.score.total).to(equal(2100))
                    expect(agari.yakuNameList()).to(contain("tsumo"))
                    expect(agari.yakuNameList()).to(contain("pinfu"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/49mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m2tm3tm4ts4ts5ts6tp2tp3tp4tp6tp7tp8tp8tp5t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(20))
                    expect(agari.hanNum).to(equal(3))
                    expect(agari.score.total).to(equal(3900))
                    expect(agari.yakuNameList()).to(contain("tsumo"))
                    expect(agari.yakuNameList()).to(contain("tanyao"))
                    expect(agari.yakuNameList()).to(contain("pinfu"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/50mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m1tm2tm3tm7tm8tm9ts7ts8ts9tp2tp3tj4tj4tp1t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(20))
                    expect(agari.hanNum).to(equal(4))
                    expect(agari.score.total).to(equal(7800))
                    expect(agari.yakuNameList()).to(contain("tsumo"))
                    expect(agari.yakuNameList()).to(contain("pinfu"))
                    expect(agari.yakuNameList()).to(contain("chanta"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/51mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = false
                kyoku.doraNum = 1
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m3tm4tm5ts2ts3ts4ts5ts6ts7ts8ts9tp4tp4ts1t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(20))
                    expect(agari.hanNum).to(equal(5))
                    expect(agari.score.total).to(equal(12000))
                    expect(agari.yakuNameList()).to(contain("tsumo"))
                    expect(agari.yakuNameList()).to(contain("pinfu"))
                    expect(agari.yakuNameList()).to(contain("ikkitsukan"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/52mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "s2ts3ts4ts5ts6ts7tp5tp6tp8tp8tp7tj7tj7lj7t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(30))
                    expect(agari.hanNum).to(equal(1))
                    expect(agari.score.total).to(equal(1500))
                    expect(agari.yakuNameList()).to(contain("chun"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/53mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = false
                kyoku.doraNum = 1
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m3tm5ts1ts2ts3ts5ts5ts5tp5tp5tp5tp6tp7tm4t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(30))
                    expect(agari.hanNum).to(equal(2))
                    expect(agari.score.total).to(equal(3000))
                    expect(agari.yakuNameList()).to(contain("tsumo"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }

            //54mon.phpはダブルリーチなので未対応

            it("ttp://dora12.com/2/yakuten/55mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = false
                kyoku.doraNum = 2
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "s3ts4ts5tp4tp5tp9tp9tp3tj3lj3tj3tj1lj1tj1t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(30))
                    expect(agari.hanNum).to(equal(4))
                    expect(agari.score.total).to(equal(11700))
                    expect(agari.yakuNameList()).to(contain("jikazeton"))
                    expect(agari.yakuNameList()).to(contain("bakazeton"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/56mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = false
                kyoku.doraNum = 3
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m2tm2tm2tm3tm4ts2ts3ts4ts6ts7ts8tp3lp2tp4t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(30))
                    expect(agari.hanNum).to(equal(5))
                    expect(agari.score.total).to(equal(12000))
                    expect(agari.yakuNameList()).to(contain("tanyao"))
                    expect(agari.yakuNameList()).to(contain("sansyoku"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/57mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.HAITEI
                let paiStr = "s2ts3ts4tp3tp5tj2tj2tp4tr0ts7ts7tr0tm7lm8tm9t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(40))
                    expect(agari.hanNum).to(equal(1))
                    expect(agari.score.total).to(equal(2100))
                    expect(agari.yakuNameList()).to(contain("haitei"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/58mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m4tm4tm4tm7tm7tm7ts7ts7tj3tj3ts7tp5lp6tp7t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(40))
                    expect(agari.hanNum).to(equal(2))
                    expect(agari.score.total).to(equal(3900))
                    expect(agari.yakuNameList()).to(contain("sanankou"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/59mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m1tm1tm1tm1tm2tm3tm7tm9ts9ts9ts9tj2tj2tm8t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(40))
                    expect(agari.hanNum).to(equal(3))
                    expect(agari.score.total).to(equal(7800))
                    expect(agari.yakuNameList()).to(contain("tsumo"))
                    expect(agari.yakuNameList()).to(contain("chanta"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/60mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "p1tp1tm1tm1lm1tj4tj4lj4tp9tp9lp9tm9tm9lm9t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(40))
                    expect(agari.hanNum).to(equal(4))
                    expect(agari.score.total).to(equal(12000))
                    expect(agari.yakuNameList()).to(contain("honroutou"))
                    expect(agari.yakuNameList()).to(contain("toitoihou"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/61mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m1tm2tm3tm4tm6tm7tm8tm9tj1tj1tj1tp8tp8tm5t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(40))
                    expect(agari.hanNum).to(equal(5))
                    expect(agari.score.total).to(equal(12000))
                    expect(agari.yakuNameList()).to(contain("tsumo"))
                    expect(agari.yakuNameList()).to(contain("jikazeton"))
                    expect(agari.yakuNameList()).to(contain("bakazeton"))
                    expect(agari.yakuNameList()).to(contain("ikkitsukan"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/62mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m5tm5tm7tm7ts4ts4ts6ts6ts7ts7tj3tj3tj5tj5t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(25))
                    expect(agari.hanNum).to(equal(3))
                    expect(agari.score.total).to(equal(4800))
                    expect(agari.yakuNameList()).to(contain("tsumo"))
                    expect(agari.yakuNameList()).to(contain("chitoitsu"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/63mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m7tm7ts6ts6ts7ts7ts8ts8tp3tp3tp5tp5tp7tp7t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(25))
                    expect(agari.hanNum).to(equal(4))
                    expect(agari.score.total).to(equal(9600))
                    expect(agari.yakuNameList()).to(contain("tsumo"))
                    expect(agari.yakuNameList()).to(contain("tanyao"))
                    expect(agari.yakuNameList()).to(contain("chitoitsu"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/64mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = false
                kyoku.doraNum = 2
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m1tm1tm5tm5tm8tm8ts5ts5tp1tp1tj1tj1tj2tj2t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(25))
                    expect(agari.hanNum).to(equal(5))
                    expect(agari.score.total).to(equal(12000))
                    expect(agari.yakuNameList()).to(contain("tsumo"))
                    expect(agari.yakuNameList()).to(contain("chitoitsu"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/65mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m7tm8ts4ts5ts6ts7ts7tm9tp4lp4tp4tp6lp7tp8t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    println(msg)
                    expect(true).to(beFalsy())
                case let .ERROR(msg):
                    expect(msg).to(equal("役がありません"))
                }
            }


            it("ttp://dora12.com/2/yakuten/66mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m1tm1tm1ts1ts1ts1ts4ts5ts6tj1tj1tj2tj2tj2t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    //ここにきたらテスト失敗
                    expect(true).to(beFalsy())
                case let .ERROR(msg):
                    expect(msg).to(equal("役がありません"))
                }
            }


            it("ttp://dora12.com/2/yakuten/67mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.NAN
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m8tm9ts4ts5ts6ts7ts7tp8tp8tp8tj1tj1tj1tm7t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(50))
                    expect(agari.hanNum).to(equal(1))
                    expect(agari.score.total).to(equal(1600))
                    expect(agari.yakuNameList()).to(contain("bakazeton"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/68mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.SHA
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = true
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m1tm2tm3tm4tm5tm6ts5ts5tj7tj7tj7tr0tp7tp7tr0t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(50))
                    expect(agari.hanNum).to(equal(2))
                    expect(agari.score.total).to(equal(3200))
                    expect(agari.yakuNameList()).to(contain("reach"))
                    expect(agari.yakuNameList()).to(contain("chun"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/69mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.PEI
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = false
                kyoku.doraNum = 1
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m1tm1ts6ts7ts8tp1tp2tj4tj4tj4tj5tj5tj5tp3t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(50))
                    expect(agari.hanNum).to(equal(3))
                    expect(agari.score.total).to(equal(6400))
                    expect(agari.yakuNameList()).to(contain("haku"))
                    expect(agari.yakuNameList()).to(contain("jikazepei"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/70mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.NAN
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = true
                kyoku.doraNum = 1
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m2tm3tm4ts2ts3ts4tj2tj2tj3tj3tj2tr0tm5tm5tr0t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(50))
                    expect(agari.hanNum).to(equal(4))
                    expect(agari.score.total).to(equal(8000))
                    expect(agari.yakuNameList()).to(contain("reach"))
                    expect(agari.yakuNameList()).to(contain("jikazenan"))
                    expect(agari.yakuNameList()).to(contain("bakazenan"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/71mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.SHA
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = true
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m1tm2tm3tm3tm3tm8tm9tj3tj3tj3tj4tj4tj4tm7t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(50))
                    expect(agari.hanNum).to(equal(5))
                    expect(agari.score.total).to(equal(8000))
                    expect(agari.yakuNameList()).to(contain("reach"))
                    expect(agari.yakuNameList()).to(contain("jikazesha"))
                    expect(agari.yakuNameList()).to(contain("honitsu"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/72mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.PEI
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m3tm5ts3ts4ts5tp6tp6tm4tr0tj5tj5tr0tj1lj1tj1t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(60))
                    expect(agari.hanNum).to(equal(1))
                    expect(agari.score.total).to(equal(2000))
                    expect(agari.yakuNameList()).to(contain("haku"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/73mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.NAN
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m1tm3ts7ts8ts9tp1tp1tm2tr0tj7tj7tr0tp9tp9tp9l"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(60))
                    expect(agari.hanNum).to(equal(2))
                    expect(agari.score.total).to(equal(3900))
                    expect(agari.yakuNameList()).to(contain("chun"))
                    expect(agari.yakuNameList()).to(contain("chanta"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/74mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.SHA
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = false
                kyoku.doraNum = 2
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m3tm4ts4ts5ts6ts8ts8tm2tj4tj4tj4lj4tj6lj6tj6tj6t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(60))
                    expect(agari.hanNum).to(equal(3))
                    expect(agari.score.total).to(equal(7700))
                    expect(agari.yakuNameList()).to(contain("hatsu"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/75mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.PEI
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = false
                kyoku.doraNum = 2
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "p1tp1tp2tp2tp2tr0tm2tm2tr0tr0ts5ts5tr0tp7lp7tp7t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(60))
                    expect(agari.hanNum).to(equal(4))
                    expect(agari.score.total).to(equal(8000))
                    expect(agari.yakuNameList()).to(contain("toitoihou"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/76mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.NAN
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = true
                kyoku.doraNum = 4
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m2tm3tm4ts5ts6ts9ts9tp9tp9tp9ts7tr0tp8tp8tr0t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(60))
                    expect(agari.hanNum).to(equal(5))
                    expect(agari.score.total).to(equal(8000))
                    expect(agari.yakuNameList()).to(contain("reach"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/77mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.SHA
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m1tm1tm1tm2tm3tp7tp8tj6tj6tj6tp6tr0tj4tj4tr0t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(70))
                    expect(agari.hanNum).to(equal(1))
                    expect(agari.score.total).to(equal(2300))
                    expect(agari.yakuNameList()).to(contain("hatsu"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/78mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.PEI
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = true
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m4tm5ts3ts4ts5tp7tp7tj4tj4tj4tm3tr0tp1tp1tr0t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(70))
                    expect(agari.hanNum).to(equal(2))
                    expect(agari.score.total).to(equal(4500))
                    expect(agari.yakuNameList()).to(contain("reach"))
                    expect(agari.yakuNameList()).to(contain("jikazepei"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/79mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.NAN
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m5tm5tp8tp8tp8tr0tj5tj5tr0ts9ls9ts9tj4tj4lj4t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(70))
                    expect(agari.hanNum).to(equal(3))
                    expect(agari.score.total).to(equal(8000))
                    expect(agari.yakuNameList()).to(contain("haku"))
                    expect(agari.yakuNameList()).to(contain("toitoihou"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/80mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.SHA
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "s4ts5ts7ts7ts3tr0tj3tj3tr0tj2tj2lj2tp9lp9tp9tp9t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(80))
                    expect(agari.hanNum).to(equal(1))
                    expect(agari.score.total).to(equal(2600))
                    expect(agari.yakuNameList()).to(contain("jikazesha"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/81mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.NAN
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "s8ts8tp5tp6tp7tr0tj3tj3tr0tm7tm7lm7tm7tm1lm1tm1tm1t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(80))
                    expect(agari.hanNum).to(equal(2))
                    expect(agari.score.total).to(equal(5200))
                    expect(agari.yakuNameList()).to(contain("sankantsu"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/82mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.SHA
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "p4tp4ts7ts7tp4tr0tj6tj6tr0tp1tp1lp1tp1tj4tj4tj4l"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(80))
                    expect(agari.hanNum).to(equal(3))
                    expect(agari.score.total).to(equal(8000))
                    expect(agari.yakuNameList()).to(contain("hatsu"))
                    expect(agari.yakuNameList()).to(contain("toitoihou"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/83mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.NAN
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m5tm6tm7tj4tj4tj2tj2tj4tr0ts2ts2tr0tr0tj7tj7tr0t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(90))
                    expect(agari.hanNum).to(equal(1))
                    expect(agari.score.total).to(equal(2900))
                    expect(agari.yakuNameList()).to(contain("chun"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/84mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.SHA
                kyoku.jikaze = Kaze.SHA
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m1tm2tm3tm4tp8tp8tp8tm1tr0tm7tm7tr0tr0tj2tj2tr0t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(90))
                    expect(agari.hanNum).to(equal(2))
                    expect(agari.score.total).to(equal(5800))
                    expect(agari.yakuNameList()).to(contain("sanankou"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/85mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.NAN
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m5tm5ts4ts5ts3tr0tj6tj6tr0tr0tj2tj2tr0tp9lp9tp9t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(90))
                    expect(agari.hanNum).to(equal(3))
                    expect(agari.score.total).to(equal(8000))
                    expect(agari.yakuNameList()).to(contain("jikazenan"))
                    expect(agari.yakuNameList()).to(contain("bakazenan"))
                    expect(agari.yakuNameList()).to(contain("hatsu"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/86mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.SHA
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = true
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "s7ts8ts9tp2tp3tp7tp7tp1tr0tm1tm1tr0tr0tj2tj2tr0t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(100))
                    expect(agari.hanNum).to(equal(1))
                    expect(agari.score.total).to(equal(3200))
                    expect(agari.yakuNameList()).to(contain("reach"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/87mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.PEI
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m2tm2tm8tm9tm7tr0tj3tj3tr0tr0ts1ts1tr0ts5ls5ts5ts5t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(100))
                    expect(agari.hanNum).to(equal(2))
                    expect(agari.score.total).to(equal(6400))
                    expect(agari.yakuNameList()).to(contain("sankantsu"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/88mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.NAN
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = true
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m2tm3tm4tm7tm7tp4tp5tp3tr0tj5tj5tr0tr0tj6tj6tr0t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(100))
                    expect(agari.hanNum).to(equal(3))
                    expect(agari.score.total).to(equal(8000))
                    expect(agari.yakuNameList()).to(contain("reach"))
                    expect(agari.yakuNameList()).to(contain("haku"))
                    expect(agari.yakuNameList()).to(contain("hatsu"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/89mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.NAN
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m4tm5tm6tj2tj2tj7tj7tj7tr0tj4tj4tr0tr0ts9ts9tr0t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(110))
                    expect(agari.hanNum).to(equal(1))
                    expect(agari.score.total).to(equal(3600))
                    expect(agari.yakuNameList()).to(contain("chun"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/90mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.NAN
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m5tm6tm7tp9tp9tp9tj2tj2tr0tj1tj1tr0tr0tj4tj4tr0t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(110))
                    expect(agari.hanNum).to(equal(2))
                    expect(agari.score.total).to(equal(7100))
                    expect(agari.yakuNameList()).to(contain("sanankou"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/91mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.NAN
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = false
                kyoku.doraNum = 1
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m5tm6tm7tp9tp9tp9tj2tj2tr0tj1tj1tr0tr0tj4tj4tr0t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(110))
                    expect(agari.hanNum).to(equal(3))
                    expect(agari.score.total).to(equal(8000))
                    expect(agari.yakuNameList()).to(contain("sanankou"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/92mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.NAN
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m5tm6tm7ts8ts9tp5tp5tj4tj4tj4ts7tr0tm8tm8tr0t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(50))
                    expect(agari.hanNum).to(equal(1))
                    expect(agari.score.total).to(equal(1600))
                    expect(agari.yakuNameList()).to(contain("tsumo"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/93mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.SHA
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "s1ts2tp8tp8tj3tj3tj3tj6tj6tj6ts3tm4tm4lm4t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(50))
                    expect(agari.hanNum).to(equal(2))
                    expect(agari.score.total).to(equal(3200))
                    expect(agari.yakuNameList()).to(contain("jikazesha"))
                    expect(agari.yakuNameList()).to(contain("hatsu"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/94mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.PEI
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m3tm3tm3tm4tm4tm4ts1ts1ts1tp4tp6tj4tj4tp5t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(50))
                    expect(agari.hanNum).to(equal(3))
                    expect(agari.score.total).to(equal(6400))
                    expect(agari.yakuNameList()).to(contain("tsumo"))
                    expect(agari.yakuNameList()).to(contain("sanankou"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/95mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.NAN
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m2tm2ts1ts2tp7tp7tp7tj4tj4tj4tj7tj7tj7ts3t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(50))
                    expect(agari.hanNum).to(equal(4))
                    expect(agari.score.total).to(equal(8000))
                    expect(agari.yakuNameList()).to(contain("tsumo"))
                    expect(agari.yakuNameList()).to(contain("chun"))
                    expect(agari.yakuNameList()).to(contain("sanankou"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/96mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.SHA
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m2tm2ts2ts2ts3ts3ts3ts9ts9ts9ts2tj6lj6tj6t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(50))
                    expect(agari.hanNum).to(equal(5))
                    expect(agari.score.total).to(equal(8000))
                    expect(agari.yakuNameList()).to(contain("hatsu"))
                    expect(agari.yakuNameList()).to(contain("toitoihou"))
                    expect(agari.yakuNameList()).to(contain("sanankou"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/97mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.PEI
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "s7ts8ts9tp2tp4tp6tp6tp3tr0tj4tj4tr0tm5lm4tm6t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(60))
                    expect(agari.hanNum).to(equal(1))
                    expect(agari.score.total).to(equal(2000))
                    expect(agari.yakuNameList()).to(contain("jikazepei"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/98mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.NAN
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = false
                kyoku.doraNum = 1
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "s2ts3ts4tp2tp3tp4tp5tp7tp9tp9tp6tr0tj3tj3tr0t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(60))
                    expect(agari.hanNum).to(equal(2))
                    expect(agari.score.total).to(equal(4000))
                    expect(agari.yakuNameList()).to(contain("tsumo"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/99mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.SHA
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = true
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m1tm3ts5ts6ts7ts7ts8ts9tp1tp1tm2tr0tj5tj5tr0t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(60))
                    expect(agari.hanNum).to(equal(3))
                    expect(agari.score.total).to(equal(7900))
                    expect(agari.yakuNameList()).to(contain("reach"))
                    expect(agari.yakuNameList()).to(contain("tsumo"))
                    expect(agari.yakuNameList()).to(contain("haku"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/100mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.PEI
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m1tm2tm4tm4tp3tp3tp3tj1tj1tj1tm3tr0tm8tm8tr0t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(60))
                    expect(agari.hanNum).to(equal(4))
                    expect(agari.score.total).to(equal(8000))
                    expect(agari.yakuNameList()).to(contain("tsumo"))
                    expect(agari.yakuNameList()).to(contain("bakazeton"))
                    expect(agari.yakuNameList()).to(contain("sanankou"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/101mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.NAN
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = false
                kyoku.doraNum = 3
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m1tm1tm6tm6tm6tr0ts4ts4tr0ts5ls5ts5tm9lm9tm9tm9t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(60))
                    expect(agari.hanNum).to(equal(5))
                    expect(agari.score.total).to(equal(8000))
                    expect(agari.yakuNameList()).to(contain("toitoihou"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/102mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.SHA
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m1tm1tm1ts7ts8ts9tp2tp2tp7tp9tp8tr0tm9tm9tr0t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(70))
                    expect(agari.hanNum).to(equal(1))
                    expect(agari.score.total).to(equal(2400))
                    expect(agari.yakuNameList()).to(contain("tsumo"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/103mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.PEI
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m1tm1tm1ts4ts5ts6tp6tp6tp8tp9tp7tr0tj2tj2tr0t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(70))
                    expect(agari.hanNum).to(equal(2))
                    expect(agari.score.total).to(equal(4700))
                    expect(agari.yakuNameList()).to(contain("tsumo"))
                    expect(agari.yakuNameList()).to(contain("bakazenan"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/104mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.NAN
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m1tm2tm3tm4tm1tp3tp3tp3tp3lj4tj4lj4tj4tj6lj6tj6tj6t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(70))
                    expect(agari.hanNum).to(equal(3))
                    expect(agari.score.total).to(equal(8000))
                    expect(agari.yakuNameList()).to(contain("hatsu"))
                    expect(agari.yakuNameList()).to(contain("sankantsu"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/105mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.SHA
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "s4ts5ts6tp8tp9tp9tp9tp7tj4tj4lj4tj4tr0tj1tj1tr0t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(80))
                    expect(agari.hanNum).to(equal(1))
                    expect(agari.score.total).to(equal(2700))
                    expect(agari.yakuNameList()).to(contain("bakazeton"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/106mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.PEI
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m5tm5ts4ts6ts5tm1lm1tm1tm1tp9tp9tp9tp9lj2lj2tj2tj2t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(80))
                    expect(agari.hanNum).to(equal(2))
                    expect(agari.score.total).to(equal(5200))
                    expect(agari.yakuNameList()).to(contain("sankantsu"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/108mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.SHA
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m7tm8tm9ts1ts1tp3tp4tp2tr0tp9tp9tr0tr0tj1tj1tr0t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(90))
                    expect(agari.hanNum).to(equal(1))
                    expect(agari.score.total).to(equal(3100))
                    expect(agari.yakuNameList()).to(contain("tsumo"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/109mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.PEI
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m3tm4tm5ts5ts5tm1lm1tm1tm1tr0tj1tj1tr0tj3tj3tj3tj3l"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(90))
                    expect(agari.hanNum).to(equal(2))
                    expect(agari.score.total).to(equal(5900))
                    expect(agari.yakuNameList()).to(contain("sankantsu"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/111mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.SHA
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m1tm2tm4tm4tm3tp9tp9lp9tr0tj3tj3tr0tr0tj4tj4tr0t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(100))
                    expect(agari.hanNum).to(equal(1))
                    expect(agari.score.total).to(equal(3200))
                    expect(agari.yakuNameList()).to(contain("jikazesha"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/114mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.NAN
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m5tm7tj2tj2tm6tp9lp9tp9tp9tr0tj1tj1tr0tr0tj4tj4tr0t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(110))
                    expect(agari.hanNum).to(equal(2))
                    expect(agari.score.total).to(equal(7200))
                    expect(agari.yakuNameList()).to(contain("sankantsu"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/115mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.NAN
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = false
                kyoku.doraNum = 1
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m5tm7tj2tj2tm6tp9lp9tp9tp9tr0tj1tj1tr0tr0tj4tj4tr0t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(110))
                    expect(agari.hanNum).to(equal(3))
                    expect(agari.score.total).to(equal(8000))
                    expect(agari.yakuNameList()).to(contain("sankantsu"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/116mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.NAN
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m7tm8tm9ts7ts8ts9tj7tj7tr0tm2tm2tr0tr0tm3tm3tr0t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    //ここにきたらテスト失敗
                    expect(true).to(beFalsy())
                case let .ERROR(msg):
                    expect(msg).to(equal("役がありません"))
                    expect(true).to(beTruthy())
                }
            }


            it("ttp://dora12.com/2/yakuten/117mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.NAN
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m4tm5tm6ts9ts9tr0tj1tj1tr0tj3tj3lj3tj4tj4tj4l"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    //ここにきたらテスト失敗
                    expect(true).to(beFalsy())
                case let .ERROR(msg):
                    expect(msg).to(equal("役がありません"))
                    expect(true).to(beTruthy())
                }
            }


            it("ttp://dora12.com/2/yakuten/118mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = true
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m2tm3tm4tm5tm6ts1ts1tj2tj2tj2tj3tj3tj3tm1t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(50))
                    expect(agari.hanNum).to(equal(1))
                    expect(agari.score.total).to(equal(2400))
                    expect(agari.yakuNameList()).to(contain("reach"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/119mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m5tm5tm8tm9ts9ts9ts9tp5tp6tp7tj1tj1tj1tm7t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(50))
                    expect(agari.hanNum).to(equal(2))
                    expect(agari.score.total).to(equal(4800))
                    expect(agari.yakuNameList()).to(contain("jikazeton"))
                    expect(agari.yakuNameList()).to(contain("bakazeton"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/120mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = true
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m2tm3tm4ts5ts6tp8tp8tj2tj2tj2tj6tj6tj6ts4t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(50))
                    expect(agari.hanNum).to(equal(3))
                    expect(agari.score.total).to(equal(9600))
                    expect(agari.yakuNameList()).to(contain("reach"))
                    expect(agari.yakuNameList()).to(contain("bakazenan"))
                    expect(agari.yakuNameList()).to(contain("hatsu"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/121mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = true
                kyoku.doraNum = 1
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "s3ts4ts5ts6ts6tp1tp2tj1tj1tj1tj2tj2tj2tp3t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(50))
                    expect(agari.hanNum).to(equal(4))
                    expect(agari.score.total).to(equal(12000))
                    expect(agari.yakuNameList()).to(contain("reach"))
                    expect(agari.yakuNameList()).to(contain("jikazeton"))
                    expect(agari.yakuNameList()).to(contain("bakazeton"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/122mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = false
                kyoku.doraNum = 1
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m6tm7tm8ts6ts7tj5tj5tj5tj6tj6tj6tj7tj7ts8t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(50))
                    expect(agari.hanNum).to(equal(5))
                    expect(agari.score.total).to(equal(12000))
                    expect(agari.yakuNameList()).to(contain("haku"))
                    expect(agari.yakuNameList()).to(contain("hatsu"))
                    expect(agari.yakuNameList()).to(contain("shousangen"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/125mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = false
                kyoku.doraNum = 2
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "s6ts7tp1tp1ts8tp7lp8tp9tj4lj4tj4tj4tj5lj5tj5tj5t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(60))
                    expect(agari.hanNum).to(equal(3))
                    expect(agari.score.total).to(equal(11600))
                    expect(agari.yakuNameList()).to(contain("haku"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/126mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m8tm8tm9tm9tm8tp6lp6tp6tr0tj7tj7tr0tj2lj2tj2t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(60))
                    expect(agari.hanNum).to(equal(4))
                    expect(agari.score.total).to(equal(12000))
                    expect(agari.yakuNameList()).to(contain("bakazenan"))
                    expect(agari.yakuNameList()).to(contain("chun"))
                    expect(agari.yakuNameList()).to(contain("toitoihou"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/127mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = false
                kyoku.doraNum = 3
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m1tm2tm3tm7tm9tm9tm9tm8ts1ts1ls1tr0tp1tp1tr0t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(60))
                    expect(agari.hanNum).to(equal(5))
                    expect(agari.score.total).to(equal(12000))
                    expect(agari.yakuNameList()).to(contain("junchan"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/129mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m1tm1tm1ts2ts2ts8ts9tj4tj4tj4ts7tr0tm2tm2tr0t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(70))
                    expect(agari.hanNum).to(equal(2))
                    expect(agari.score.total).to(equal(6800))
                    expect(agari.yakuNameList()).to(contain("sanankou"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/131mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m4tm4tm6tm7tm8ts9ts9ls9tr0tj1tj1tr0ts1ts1ts1ts1l"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(80))
                    expect(agari.hanNum).to(equal(1))
                    expect(agari.score.total).to(equal(3900))
                    expect(agari.yakuNameList()).to(contain("jikazeton"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/132mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "p2tp2tp7tp8tp9tm1lm1tm1tm1tr0tj4tj4tr0ts5ts5ls5ts5t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(80))
                    expect(agari.hanNum).to(equal(2))
                    expect(agari.score.total).to(equal(7700))
                    expect(agari.yakuNameList()).to(contain("sankantsu"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/133mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = false
                kyoku.doraNum = 1
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m3tm4tm6tm6tp1tp1tp1tm2tr0tm1tm1tr0ts1ts1ls1ts1t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(80))
                    expect(agari.hanNum).to(equal(3))
                    expect(agari.score.total).to(equal(12000))
                    expect(agari.yakuNameList()).to(contain("sansyokudouko"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/135mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "s7ts7tp1tp2tp3tm8lm8tm8tr0tj4tj4tr0tr0tj1tj1tr0t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(90))
                    expect(agari.hanNum).to(equal(2))
                    expect(agari.score.total).to(equal(8700))
                    expect(agari.yakuNameList()).to(contain("jikazeton"))
                    expect(agari.yakuNameList()).to(contain("bakazeton"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/136mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m2tm2tp3tp4tp2tj3lj3tj3tr0tj1tj1tr0tr0tj6tj6tr0t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(90))
                    expect(agari.hanNum).to(equal(3))
                    expect(agari.score.total).to(equal(12000))
                    expect(agari.yakuNameList()).to(contain("jikazeton"))
                    expect(agari.yakuNameList()).to(contain("bakazeton"))
                    expect(agari.yakuNameList()).to(contain("hatsu"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/137mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = true
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m6tm7tm8ts1ts1ts4ts5ts3tr0tm1tm1tr0tr0tj4tj4tr0t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(100))
                    expect(agari.hanNum).to(equal(1))
                    expect(agari.score.total).to(equal(4800))
                    expect(agari.yakuNameList()).to(contain("reach"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/138mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "s6ts6tp8tp9tp7tm8lm8tm8tm8tr0tj3tj3tr0tr0tj2tj2tr0t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(100))
                    expect(agari.hanNum).to(equal(2))
                    expect(agari.score.total).to(equal(9600))
                    expect(agari.yakuNameList()).to(contain("sankantsu"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/139mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = true
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m5tm6tm7tm7tm7tp1tp2tp3tr0tj1tj1tr0tr0tj2tj2tr0t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(100))
                    expect(agari.hanNum).to(equal(3))
                    expect(agari.score.total).to(equal(12000))
                    expect(agari.yakuNameList()).to(contain("reach"))
                    expect(agari.yakuNameList()).to(contain("jikazeton"))
                    expect(agari.yakuNameList()).to(contain("bakazenan"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/140mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "p5tp6tp7tj1tj1tj6tj6tj6tr0tp1tp1tr0tr0tm9tm9tr0t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(110))
                    expect(agari.hanNum).to(equal(1))
                    expect(agari.score.total).to(equal(5300))
                    expect(agari.yakuNameList()).to(contain("hatsu"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/141mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = false
                kyoku.doraNum = 1
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m3tm4tm5tj1tj1tj5tj5tj5tr0tj4tj4tr0tr0tp9tp9tr0t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(110))
                    expect(agari.hanNum).to(equal(2))
                    expect(agari.score.total).to(equal(10600))
                    expect(agari.yakuNameList()).to(contain("haku"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/142mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = false
                kyoku.doraNum = 2
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "s4ts5ts6tj1tj1tj7tj7tj7tr0ts9ts9tr0tr0tm9tm9tr0t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(110))
                    expect(agari.hanNum).to(equal(3))
                    expect(agari.score.total).to(equal(12000))
                    expect(agari.yakuNameList()).to(contain("chun"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/143mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m6tm7tm8tp1tp1tp2tp2tj6tj6tj6tp1tm5tm5tm5tm5l"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(50))
                    expect(agari.hanNum).to(equal(1))
                    expect(agari.score.total).to(equal(2400))
                    expect(agari.yakuNameList()).to(contain("hatsu"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/144mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = true
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m1tm2tm3ts3ts5tp8tp8tp8tj1tj1ts4tr0ts7ts7tr0t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(50))
                    expect(agari.hanNum).to(equal(2))
                    expect(agari.score.total).to(equal(4800))
                    expect(agari.yakuNameList()).to(contain("reach"))
                    expect(agari.yakuNameList()).to(contain("tsumo"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/145mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m6tm6tm8tm8tp8tp8tp8tm8ts4ls3ts5tr0ts7ts7tr0t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(50))
                    expect(agari.hanNum).to(equal(3))
                    expect(agari.score.total).to(equal(9600))
                    expect(agari.yakuNameList()).to(contain("tanyao"))
                    expect(agari.yakuNameList()).to(contain("sanankou"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/146mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m1tm3ts8ts8tp5tp5tp5tj4tj4tj4tj6tj6tj6tm2t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(50))
                    expect(agari.hanNum).to(equal(4))
                    expect(agari.score.total).to(equal(12000))
                    expect(agari.yakuNameList()).to(contain("tsumo"))
                    expect(agari.yakuNameList()).to(contain("hatsu"))
                    expect(agari.yakuNameList()).to(contain("sanankou"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/147mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m9tm9tm9ts4ts4ts4tp8tp8tp9tp9tp8tj1lj1tj1t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(50))
                    expect(agari.hanNum).to(equal(5))
                    expect(agari.score.total).to(equal(12000))
                    expect(agari.yakuNameList()).to(contain("jikazeton"))
                    expect(agari.yakuNameList()).to(contain("sanankou"))
                    expect(agari.yakuNameList()).to(contain("toitoihou"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/150mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = true
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m6tm7tm8ts6ts6ts8ts9tp7tp7tp7ts7tr0tj2tj2tr0t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(60))
                    expect(agari.hanNum).to(equal(3))
                    expect(agari.score.total).to(equal(11700))
                    expect(agari.yakuNameList()).to(contain("reach"))
                    expect(agari.yakuNameList()).to(contain("tsumo"))
                    expect(agari.yakuNameList()).to(contain("bakazenan"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/151mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "s3ts3ts6ts8tp5tp5tp5tj1tj1tj1ts7tr0tm5tm5tr0t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(60))
                    expect(agari.hanNum).to(equal(4))
                    expect(agari.score.total).to(equal(12000))
                    expect(agari.yakuNameList()).to(contain("tsumo"))
                    expect(agari.yakuNameList()).to(contain("jikazeton"))
                    expect(agari.yakuNameList()).to(contain("sanankou"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/152mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = false
                kyoku.doraNum = 3
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m7tm7ts2ts2ts2tp7lp7tp7tj4lj4tj4tj4tr0tm3tm3tr0t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(60))
                    expect(agari.hanNum).to(equal(5))
                    expect(agari.score.total).to(equal(12000))
                    expect(agari.yakuNameList()).to(contain("toitoihou"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/153mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m7tm8tm9ts1ts2ts5ts5tp1tp1tp1ts3tr0tp9tp9tr0t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(70))
                    expect(agari.hanNum).to(equal(1))
                    expect(agari.score.total).to(equal(3600))
                    expect(agari.yakuNameList()).to(contain("tsumo"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/155mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m5tm5ts5ts6ts4tp8tp8tp8tp8lp9lp9tp9tp9tj1tj1lj1tj1t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(70))
                    expect(agari.hanNum).to(equal(3))
                    expect(agari.score.total).to(equal(12000))
                    expect(agari.yakuNameList()).to(contain("jikazeton"))
                    expect(agari.yakuNameList()).to(contain("sankantsu"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/157mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "s3ts3ts5ts7ts6tj2tj2lj2tj2tp1tp1tp1tp1lm9tm9lm9tm9t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(80))
                    expect(agari.hanNum).to(equal(2))
                    expect(agari.score.total).to(equal(7800))
                    expect(agari.yakuNameList()).to(contain("sankantsu"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/159mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m5tm6tm7tp2tp3tp4tp5tp5tr0tj2tj2tr0tr0ts1ts1tr0t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(90))
                    expect(agari.hanNum).to(equal(1))
                    expect(agari.score.total).to(equal(4500))
                    expect(agari.yakuNameList()).to(contain("tsumo"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/160mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "s8ts8tp1tp1tp1tr0tj4tj4tr0tm1tm1tm1tm1lm9tm9tm9l"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(90))
                    expect(agari.hanNum).to(equal(2))
                    expect(agari.score.total).to(equal(8700))
                    expect(agari.yakuNameList()).to(contain("toitoihou"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/161mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m4tm4tm9tm9tm9tj1lj1tj1tr0tj3tj3tr0ts9ts9ls9ts9t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(90))
                    expect(agari.hanNum).to(equal(3))
                    expect(agari.score.total).to(equal(12000))
                    expect(agari.yakuNameList()).to(contain("jikazeton"))
                    expect(agari.yakuNameList()).to(contain("toitoihou"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/163mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "p3tp4tp5tp8tp8tr0tj1tj1tr0tr0tj2tj2tr0ts9ts9ls9t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(100))
                    expect(agari.hanNum).to(equal(2))
                    expect(agari.score.total).to(equal(9600))
                    expect(agari.yakuNameList()).to(contain("jikazeton"))
                    expect(agari.yakuNameList()).to(contain("bakazeton"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/164mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "p1tp1tp5tp6tp7tr0tj1tj1tr0tr0ts1ts1tr0ts2ts2ls2ts2t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(100))
                    expect(agari.hanNum).to(equal(3))
                    expect(agari.score.total).to(equal(12000))
                    expect(agari.yakuNameList()).to(contain("jikazeton"))
                    expect(agari.yakuNameList()).to(contain("sankantsu"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/165mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m2tm4tj1tj1tm3tr0tj3tj3tr0tr0tj4tj4tr0tp1tp1lp1tp1t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(110))
                    expect(agari.hanNum).to(equal(2))
                    expect(agari.score.total).to(equal(10800))
                    expect(agari.yakuNameList()).to(contain("sankantsu"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/166mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = false
                kyoku.doraNum = 1
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m5tm6tj1tj1tm4tr0tp1tp1tr0tr0tp9tp9tr0ts9ls9ts9ts9t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.fuNum).to(equal(110))
                    expect(agari.hanNum).to(equal(3))
                    expect(agari.score.total).to(equal(12000))
                    expect(agari.yakuNameList()).to(contain("sankantsu"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/167mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "s1ts2ts3ts4ts5ts6ts7ts8tp4tp4ts3tp7lp8tp9t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    //ここにきたらテスト失敗
                    expect(true).to(beFalsy())
                case let .ERROR(msg):
                    expect(msg).to(equal("役がありません"))
                    expect(true).to(beTruthy())
                }
            }


            it("ttp://dora12.com/2/yakuten/168mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m1tm1tm2tm3tj2tj2tj2tj3tj3tj3tm4ts9ts9ls9t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    //ここにきたらテスト失敗
                    expect(true).to(beFalsy())
                case let .ERROR(msg):
                    expect(msg).to(equal("役がありません"))
                    expect(true).to(beTruthy())
                }
            }


            it("ttp://dora12.com/2/yakuten/169mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.NAN
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = false
                kyoku.doraNum = 1
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m4tm5tm6ts4ts4ts5ts5ts6tp4tp5tp6tp7tp7ts6t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.score.total).to(equal(12000))
                    expect(agari.yakuNameList()).to(contain("tanyao"))
                    expect(agari.yakuNameList()).to(contain("pinfu"))
                    expect(agari.yakuNameList()).to(contain("sansyoku"))
                    expect(agari.yakuNameList()).to(contain("iipeikou"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/170mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.SHA
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "s5ts5ts8ts8ts8ts1ls1ts1tj3tj3tj3lj6tj6tj6l"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.score.total).to(equal(12000))
                    expect(agari.yakuNameList()).to(contain("jikazesha"))
                    expect(agari.yakuNameList()).to(contain("hatsu"))
                    expect(agari.yakuNameList()).to(contain("honitsu"))
                    expect(agari.yakuNameList()).to(contain("toitoihou"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/171mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.PEI
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = true
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "s1ts2ts2ts3ts3ts4ts4ts5ts6ts7ts8tj2tj2ts9t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.score.total).to(equal(12000))
                    expect(agari.yakuNameList()).to(contain("reach"))
                    expect(agari.yakuNameList()).to(contain("pinfu"))
                    expect(agari.yakuNameList()).to(contain("honitsu"))
                    expect(agari.yakuNameList()).to(contain("ikkitsukan"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/172mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.NAN
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "p5tp5tp9tp9tp9tp6lp6tp6tp2tp2lp2tp1tp1lp1t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.score.total).to(equal(12000))
                    expect(agari.yakuNameList()).to(contain("chinitsu"))
                    expect(agari.yakuNameList()).to(contain("toitoihou"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/173mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.SHA
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = true
                kyoku.doraNum = 4
                kyoku.isIppatsu = true
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m1tm1tm3tm3tm6tm6ts4ts4tp4tp4tp8tp8tj3tj3t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.score.total).to(equal(16000))
                    expect(agari.yakuNameList()).to(contain("reach"))
                    expect(agari.yakuNameList()).to(contain("ippatsu"))
                    expect(agari.yakuNameList()).to(contain("chitoitsu"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/174mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.PEI
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = false
                kyoku.doraNum = 3
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "p3tp3tp3ts2ts2tp8tp8tp8tm3lm3tm3ts3ts3ls3t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.score.total).to(equal(16000))
                    expect(agari.yakuNameList()).to(contain("tanyao"))
                    expect(agari.yakuNameList()).to(contain("sansyokudouko"))
                    expect(agari.yakuNameList()).to(contain("toitoihou"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/175mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.NAN
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = true
                kyoku.doraNum = 0
                kyoku.isIppatsu = true
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m1tm2tm3tm4tm5tm6tm8tm9tj2tj2tj2tj5tj5tm7t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.score.total).to(equal(16000))
                    expect(agari.yakuNameList()).to(contain("reach"))
                    expect(agari.yakuNameList()).to(contain("ippatsu"))
                    expect(agari.yakuNameList()).to(contain("jikazenan"))
                    expect(agari.yakuNameList()).to(contain("bakazenan"))
                    expect(agari.yakuNameList()).to(contain("honitsu"))
                    expect(agari.yakuNameList()).to(contain("ikkitsukan"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/176mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.NAN
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = false
                kyoku.doraNum = 3
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "p1tp1tp1tp2tp3tp4tp6tp7tp8tp9tp5tp8tp8tp8l"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.score.total).to(equal(16000))
                    expect(agari.yakuNameList()).to(contain("chinitsu"))
                    expect(agari.yakuNameList()).to(contain("ikkitsukan"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/177mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.NAN
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = true
                kyoku.doraNum = 2
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m1tm2tm3tm8tm9tj2tj2tj2tj3tj3tj3tj4tj4tm7t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.score.total).to(equal(16000))
                    expect(agari.yakuNameList()).to(contain("reach"))
                    expect(agari.yakuNameList()).to(contain("jikazenan"))
                    expect(agari.yakuNameList()).to(contain("bakazenan"))
                    expect(agari.yakuNameList()).to(contain("honitsu"))
                    expect(agari.yakuNameList()).to(contain("chanta"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/178mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.SHA
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "j7tj7tj5lj5tj5tj6tj6lj6ts1ls1ts1ts9ts9ts9l"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.score.total).to(equal(16000))
                    expect(agari.yakuNameList()).to(contain("haku"))
                    expect(agari.yakuNameList()).to(contain("hatsu"))
                    expect(agari.yakuNameList()).to(contain("shousangen"))
                    expect(agari.yakuNameList()).to(contain("honitsu"))
                    expect(agari.yakuNameList()).to(contain("honroutou"))
                    expect(agari.yakuNameList()).to(contain("toitoihou"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/179mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.PEI
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = true
                kyoku.doraNum = 1
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m1tm2tm2tm3tm3tm4tm5tm6tm7tm8tm9tm9tm9tm4t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.score.total).to(equal(24000))
                    expect(agari.yakuNameList()).to(contain("reach"))
                    expect(agari.yakuNameList()).to(contain("chinitsu"))
                    expect(agari.yakuNameList()).to(contain("pinfu"))
                    expect(agari.yakuNameList()).to(contain("ikkitsukan"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/180mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.NAN
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = false
                kyoku.doraNum = 3
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m1tm1tj5tj5tm1tj6lj6tj6tj7tj7lj7tp9tp9tp9l"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.score.total).to(equal(24000))
                    expect(agari.yakuNameList()).to(contain("hatsu"))
                    expect(agari.yakuNameList()).to(contain("chun"))
                    expect(agari.yakuNameList()).to(contain("shousangen"))
                    expect(agari.yakuNameList()).to(contain("honroutou"))
                    expect(agari.yakuNameList()).to(contain("toitoihou"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/181mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.NAN
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = false
                kyoku.doraNum = 1
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m1tm2tm9tm9tj2tj2tj2tj5tj5tj5tj6tj6tj6tm3t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.score.total).to(equal(24000))
                    expect(agari.yakuNameList()).to(contain("jikazenan"))
                    expect(agari.yakuNameList()).to(contain("bakazenan"))
                    expect(agari.yakuNameList()).to(contain("haku"))
                    expect(agari.yakuNameList()).to(contain("hatsu"))
                    expect(agari.yakuNameList()).to(contain("honitsu"))
                    expect(agari.yakuNameList()).to(contain("chanta"))
                    expect(agari.yakuNameList()).to(contain("sanankou"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/182mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.NAN
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "s1ts1tj7tj7ts1tj2lj2tj2tj6tj6tj6lj5tj5tj5l"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.score.total).to(equal(24000))
                    expect(agari.yakuNameList()).to(contain("jikazenan"))
                    expect(agari.yakuNameList()).to(contain("bakazenan"))
                    expect(agari.yakuNameList()).to(contain("haku"))
                    expect(agari.yakuNameList()).to(contain("hatsu"))
                    expect(agari.yakuNameList()).to(contain("shousangen"))
                    expect(agari.yakuNameList()).to(contain("honitsu"))
                    expect(agari.yakuNameList()).to(contain("honroutou"))
                    expect(agari.yakuNameList()).to(contain("toitoihou"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/183mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.SHA
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = true
                kyoku.doraNum = 0
                kyoku.isIppatsu = true
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "p2tp2tp3tp3tp4tp5tp5tp6tp6tp7tp7tp8tp8tp4t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.score.total).to(equal(32000))
                    expect(agari.yakuNameList()).to(contain("reach"))
                    expect(agari.yakuNameList()).to(contain("ippatsu"))
                    expect(agari.yakuNameList()).to(contain("tanyao"))
                    expect(agari.yakuNameList()).to(contain("pinfu"))
                    expect(agari.yakuNameList()).to(contain("ryanpeikou"))
                    expect(agari.yakuNameList()).to(contain("chinitsu"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/184mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.PEI
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = false
                kyoku.doraNum = 3
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m9tm9tj6tj6tm9tj5lj5tj5tj7tj7tj7lj1tj1tj1l"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.score.total).to(equal(32000))
                    expect(agari.yakuNameList()).to(contain("haku"))
                    expect(agari.yakuNameList()).to(contain("chun"))
                    expect(agari.yakuNameList()).to(contain("shousangen"))
                    expect(agari.yakuNameList()).to(contain("honitsu"))
                    expect(agari.yakuNameList()).to(contain("honroutou"))
                    expect(agari.yakuNameList()).to(contain("toitoihou"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/185mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.NAN
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "j5tj5tj6tj6tj5tj1tj1tj1lj2tj2tj2lj4tj4tj4l"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.score.total).to(equal(32000))
                    expect(agari.yakuNameList()).to(contain("tsuisou"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/186mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.SHA
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m9tm9ts1ts1ts1tm1lm1tm1ts9ts9ls9tp1tp1lp1t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.score.total).to(equal(32000))
                    expect(agari.yakuNameList()).to(contain("chinroutou"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/187mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.PEI
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "s2ts2ts3ts3ts4ts8ts8ts4ts6ls6ts6tj6tj6lj6t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.score.total).to(equal(32000))
                    expect(agari.yakuNameList()).to(contain("ryuisou"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/188mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.PEI
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = true
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m6tm6tm7tm7tm8tm8ts6ts7ts8tp6tp7tp9tp9tp8t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.score.total).to(equal(12000))
                    expect(agari.yakuNameList()).to(contain("reach"))
                    expect(agari.yakuNameList()).to(contain("tsumo"))
                    expect(agari.yakuNameList()).to(contain("pinfu"))
                    expect(agari.yakuNameList()).to(contain("iipeikou"))
                    expect(agari.yakuNameList()).to(contain("sansyoku"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/189mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.NAN
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m2tm2tm3tm3tm4tm5tm5tm5tm6tm6tm4tm8lm8tm8t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.score.total).to(equal(12000))
                    expect(agari.yakuNameList()).to(contain("tanyao"))
                    expect(agari.yakuNameList()).to(contain("chinitsu"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/190mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.SHA
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "s1ts2ts3ts3ts4ts4ts5ts5ts7ts8ts9tj1tj1ts6t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.score.total).to(equal(12000))
                    expect(agari.yakuNameList()).to(contain("tsumo"))
                    expect(agari.yakuNameList()).to(contain("pinfu"))
                    expect(agari.yakuNameList()).to(contain("honitsu"))
                    expect(agari.yakuNameList()).to(contain("ikkitsukan"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/191mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.PEI
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = false
                kyoku.doraNum = 3
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m4tm5tm6ts7ts8tj7tj7ts6tj5lj5tj5tj6lj6tj6t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.score.total).to(equal(12000))
                    expect(agari.yakuNameList()).to(contain("haku"))
                    expect(agari.yakuNameList()).to(contain("haku"))
                    expect(agari.yakuNameList()).to(contain("shousangen"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/192mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.NAN
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = true
                kyoku.doraNum = 0
                kyoku.isIppatsu = true
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m2tm3tm4ts2ts2ts3ts3ts4ts4tp3tp4tp7tp7tp2t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.score.total).to(equal(16000))
                    expect(agari.yakuNameList()).to(contain("reach"))
                    expect(agari.yakuNameList()).to(contain("ippatsu"))
                    expect(agari.yakuNameList()).to(contain("tsumo"))
                    expect(agari.yakuNameList()).to(contain("tanyao"))
                    expect(agari.yakuNameList()).to(contain("pinfu"))
                    expect(agari.yakuNameList()).to(contain("sansyoku"))
                    expect(agari.yakuNameList()).to(contain("iipeikou"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/193mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.NAN
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = false
                kyoku.doraNum = 2
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m1tm1tm2tm2tj2tj2tj2tm2tj4lj4tj4tm8lm8tm8t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.score.total).to(equal(16000))
                    expect(agari.yakuNameList()).to(contain("jikazenan"))
                    expect(agari.yakuNameList()).to(contain("bakazenan"))
                    expect(agari.yakuNameList()).to(contain("honitsu"))
                    expect(agari.yakuNameList()).to(contain("toitoihou"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/194mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.NAN
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = true
                kyoku.doraNum = 0
                kyoku.isIppatsu = true
                kyoku.finishType = FinishType.HAITEI
                let paiStr = "m1tm2tm3tm7tm8tm9ts1ts2ts3tp1tp3tp9tp9tp2t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.score.total).to(equal(16000))
                    expect(agari.yakuNameList()).to(contain("reach"))
                    expect(agari.yakuNameList()).to(contain("ippatsu"))
                    expect(agari.yakuNameList()).to(contain("haitei"))
                    expect(agari.yakuNameList()).to(contain("tsumo"))
                    expect(agari.yakuNameList()).to(contain("junchan"))
                    expect(agari.yakuNameList()).to(contain("sansyoku"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/195mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.PEI
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "s1ts1ts9ts9tj6tj6tj6ts9tj1lj1tj1tj7lj7tj7t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.score.total).to(equal(16000))
                    expect(agari.yakuNameList()).to(contain("bakazeton"))
                    expect(agari.yakuNameList()).to(contain("hatsu"))
                    expect(agari.yakuNameList()).to(contain("chun"))
                    expect(agari.yakuNameList()).to(contain("honitsu"))
                    expect(agari.yakuNameList()).to(contain("honroutou"))
                    expect(agari.yakuNameList()).to(contain("toitoihou"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/196mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.SHA
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = true
                kyoku.doraNum = 0
                kyoku.isIppatsu = true
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m1tm2tm2tm3tm3tm4tm5tm5tm6tm7tm7tm8tm9tm8t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.score.total).to(equal(16000))
                    expect(agari.yakuNameList()).to(contain("reach"))
                    expect(agari.yakuNameList()).to(contain("ippatsu"))
                    expect(agari.yakuNameList()).to(contain("tsumo"))
                    expect(agari.yakuNameList()).to(contain("pinfu"))
                    expect(agari.yakuNameList()).to(contain("chinitsu"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/197mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.PEI
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = false
                kyoku.doraNum = 2
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "s5ts5ts8ts8ts8ts2ls2ts2ts3ls3ts3ts6ts6ls6t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.score.total).to(equal(16000))
                    expect(agari.yakuNameList()).to(contain("tanyao"))
                    expect(agari.yakuNameList()).to(contain("chinitsu"))
                    expect(agari.yakuNameList()).to(contain("toitoihou"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/198mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.PEI
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = true
                kyoku.doraNum = 4
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.RINSHAN
                let paiStr = "m2tm2tm5tm6tm4tr0tj3tj3tr0tr0tp7tp7tr0tr0ts1ts1tr0t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.score.total).to(equal(24000))
                    expect(agari.yakuNameList()).to(contain("reach"))
                    expect(agari.yakuNameList()).to(contain("tsumo"))
                    expect(agari.yakuNameList()).to(contain("rinshan"))
                    expect(agari.yakuNameList()).to(contain("sanankou"))
                    expect(agari.yakuNameList()).to(contain("sankantsu"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/199mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.PEI
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.RINSHAN
                let paiStr = "m5tm5tm5tj7tj7tm4tm4tm4tm4lj5lj5tj5tj5tj6tj6lj6tj6t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.score.total).to(equal(24000))
                    expect(agari.yakuNameList()).to(contain("rinshan"))
                    expect(agari.yakuNameList()).to(contain("haku"))
                    expect(agari.yakuNameList()).to(contain("hatsu"))
                    expect(agari.yakuNameList()).to(contain("shousangen"))
                    expect(agari.yakuNameList()).to(contain("honitsu"))
                    expect(agari.yakuNameList()).to(contain("toitoihou"))
                    expect(agari.yakuNameList()).to(contain("sankantsu"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/200mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.PEI
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = true
                kyoku.doraNum = 4
                kyoku.isIppatsu = true
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m3tm3tm5tm6tm7ts5ts6ts7tp5tp5tp6tp6tp7tp7t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.score.total).to(equal(24000))
                    expect(agari.yakuNameList()).to(contain("reach"))
                    expect(agari.yakuNameList()).to(contain("ippatsu"))
                    expect(agari.yakuNameList()).to(contain("tsumo"))
                    expect(agari.yakuNameList()).to(contain("tanyao"))
                    expect(agari.yakuNameList()).to(contain("pinfu"))
                    expect(agari.yakuNameList()).to(contain("sansyoku"))
                    expect(agari.yakuNameList()).to(contain("iipeikou"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/201mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.PEI
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m1tm1tj5tj5tm1tj6tj6lj6tj6tj7tj7tj7tj7lj1tj1tj1lj1t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.score.total).to(equal(24000))
                    expect(agari.yakuNameList()).to(contain("hatsu"))
                    expect(agari.yakuNameList()).to(contain("chun"))
                    expect(agari.yakuNameList()).to(contain("shousangen"))
                    expect(agari.yakuNameList()).to(contain("honitsu"))
                    expect(agari.yakuNameList()).to(contain("honroutou"))
                    expect(agari.yakuNameList()).to(contain("toitoihou"))
                    expect(agari.yakuNameList()).to(contain("sankantsu"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/202mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.NAN
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = true
                kyoku.doraNum = 0
                kyoku.isIppatsu = true
                kyoku.finishType = FinishType.HAITEI
                let paiStr = "s2ts3ts4ts5ts6ts6ts6ts6ts7ts7ts8ts8ts9ts1t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.score.total).to(equal(32000))
                    expect(agari.yakuNameList()).to(contain("reach"))
                    expect(agari.yakuNameList()).to(contain("ippatsu"))
                    expect(agari.yakuNameList()).to(contain("haitei"))
                    expect(agari.yakuNameList()).to(contain("tsumo"))
                    expect(agari.yakuNameList()).to(contain("chinitsu"))
                    expect(agari.yakuNameList()).to(contain("pinfu"))
                    expect(agari.yakuNameList()).to(contain("ikkitsukan"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/203mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.NAN
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.RINSHAN
                let paiStr = "p9tp9tj6tj6tp9tj2lj2tj2tj2tj5tj5lj5tj7tj7lj7t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.score.total).to(equal(32000))
                    expect(agari.yakuNameList()).to(contain("rinshan"))
                    expect(agari.yakuNameList()).to(contain("jikazenan"))
                    expect(agari.yakuNameList()).to(contain("bakazenan"))
                    expect(agari.yakuNameList()).to(contain("haku"))
                    expect(agari.yakuNameList()).to(contain("chun"))
                    expect(agari.yakuNameList()).to(contain("shousangen"))
                    expect(agari.yakuNameList()).to(contain("honitsu"))
                    expect(agari.yakuNameList()).to(contain("honroutou"))
                    expect(agari.yakuNameList()).to(contain("toitoihou"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/204mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.SHA
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m5tm5tm5ts9ts9ts9tp7tp7tp9tp9tj3tj3tj3tp9t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.score.total).to(equal(32000))
                    expect(agari.yakuNameList()).to(contain("suankou"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/205mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.PEI
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m3tm3tm4tm5tj7tj7tj7tm3tj5lj5tj5tj6tj6tj6l"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.score.total).to(equal(32000))
                    expect(agari.yakuNameList()).to(contain("daisangen"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/206mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.NAN
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m1tm9ts1ts9tp1tj1tj2tj3tj4tj5tj5tj6tj7tp9t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.score.total).to(equal(32000))
                    expect(agari.yakuNameList()).to(contain("kokushimuso"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/207mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.NAN
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m1tm2tm3tm4tm4tm4tm5tm6tm8tm8tm9tm9tm9tm3t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    //ここにきたらテスト失敗
                    expect(true).to(beFalsy())
                case let .ERROR(msg):
                    expect(true).to(beTruthy())
                }
            }


            it("ttp://dora12.com/2/yakuten/208mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = true
                kyoku.doraNum = 2
                kyoku.isIppatsu = true
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m5tm5ts2ts2ts9ts9tp4tp4tp5tp5tp6tp6tj1tj1t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.score.total).to(equal(18000))
                    expect(agari.yakuNameList()).to(contain("reach"))
                    expect(agari.yakuNameList()).to(contain("ippatsu"))
                    expect(agari.yakuNameList()).to(contain("chitoitsu"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/209mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m1tm1tm1tj3tj3tj4tj4tj3ts1ls1ts1tp1tp1lp1t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.score.total).to(equal(18000))
                    expect(agari.yakuNameList()).to(contain("sansyokudouko"))
                    expect(agari.yakuNameList()).to(contain("honroutou"))
                    expect(agari.yakuNameList()).to(contain("toitoihou"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/210mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = true
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m1tm2tm3tm7tm8tm9ts1ts2ts3tp2tp3tp9tp9tp1t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.score.total).to(equal(18000))
                    expect(agari.yakuNameList()).to(contain("reach"))
                    expect(agari.yakuNameList()).to(contain("pinfu"))
                    expect(agari.yakuNameList()).to(contain("junchan"))
                    expect(agari.yakuNameList()).to(contain("sansyoku"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/211mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = false
                kyoku.doraNum = 3
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m7tm8tm9ts7ts9tp7tp8tp9tj7tj7ts8tj1lj1tj1t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.score.total).to(equal(18000))
                    expect(agari.yakuNameList()).to(contain("jikazeton"))
                    expect(agari.yakuNameList()).to(contain("bakazeton"))
                    expect(agari.yakuNameList()).to(contain("chanta"))
                    expect(agari.yakuNameList()).to(contain("sansyoku"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/212mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = true
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m1tm2tm3tm4tm5tm6tm7tm8tm9tj1tj1tj5tj5tj1t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.score.total).to(equal(24000))
                    expect(agari.yakuNameList()).to(contain("reach"))
                    expect(agari.yakuNameList()).to(contain("jikazeton"))
                    expect(agari.yakuNameList()).to(contain("bakazeton"))
                    expect(agari.yakuNameList()).to(contain("honitsu"))
                    expect(agari.yakuNameList()).to(contain("ikkitsukan"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/213mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "j4tj4ts9ls9ts9ts1ls1ts1tj2lj2tj2tj7lj7tj7t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.score.total).to(equal(24000))
                    expect(agari.yakuNameList()).to(contain("bakazenan"))
                    expect(agari.yakuNameList()).to(contain("chun"))
                    expect(agari.yakuNameList()).to(contain("honitsu"))
                    expect(agari.yakuNameList()).to(contain("honroutou"))
                    expect(agari.yakuNameList()).to(contain("toitoihou"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/214mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = true
                kyoku.doraNum = 1
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.HAITEI
                let paiStr = "p1tp1tp1tp2tp2tp2tp4tp5tp6tp6tp7tp8tp9tp9t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.score.total).to(equal(24000))
                    expect(agari.yakuNameList()).to(contain("reach"))
                    expect(agari.yakuNameList()).to(contain("haitei"))
                    expect(agari.yakuNameList()).to(contain("chinitsu"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/215mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m1tm1tm1tm5tm5tm5tm9tj7tj7tj7tm9tj1lj1tj1t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.score.total).to(equal(24000))
                    expect(agari.yakuNameList()).to(contain("jikazeton"))
                    expect(agari.yakuNameList()).to(contain("bakazeton"))
                    expect(agari.yakuNameList()).to(contain("chun"))
                    expect(agari.yakuNameList()).to(contain("honitsu"))
                    expect(agari.yakuNameList()).to(contain("sanankou"))
                    expect(agari.yakuNameList()).to(contain("toitoihou"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/216mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = true
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.HAITEI
                let paiStr = "s1ts2ts2ts3ts3ts4ts4ts5ts6ts6ts6ts8ts9ts7t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.score.total).to(equal(24000))
                    expect(agari.yakuNameList()).to(contain("reach"))
                    expect(agari.yakuNameList()).to(contain("haitei"))
                    expect(agari.yakuNameList()).to(contain("chinitsu"))
                    expect(agari.yakuNameList()).to(contain("ikkitsukan"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/217mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "p5tp5tj5tj5tp5tj6lj6tj6tj7tj7lj7tj1lj1tj1t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.score.total).to(equal(24000))
                    expect(agari.yakuNameList()).to(contain("jikazeton"))
                    expect(agari.yakuNameList()).to(contain("bakazeton"))
                    expect(agari.yakuNameList()).to(contain("hatsu"))
                    expect(agari.yakuNameList()).to(contain("chun"))
                    expect(agari.yakuNameList()).to(contain("shousangen"))
                    expect(agari.yakuNameList()).to(contain("honitsu"))
                    expect(agari.yakuNameList()).to(contain("toitoihou"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/218mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m1tm3tm9tm9tj1tj1tj1tj6tj6tj6tj7tj7tj7tm2t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.score.total).to(equal(36000))
                    expect(agari.yakuNameList()).to(contain("jikazeton"))
                    expect(agari.yakuNameList()).to(contain("bakazeton"))
                    expect(agari.yakuNameList()).to(contain("hatsu"))
                    expect(agari.yakuNameList()).to(contain("chun"))
                    expect(agari.yakuNameList()).to(contain("honitsu"))
                    expect(agari.yakuNameList()).to(contain("sanankou"))
                    expect(agari.yakuNameList()).to(contain("chanta"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/219mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = false
                kyoku.doraNum = 3
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m9tm9tj5tj5tj5tj6tj6tm9tj7tj7lj7ts1ts1ts1l"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.score.total).to(equal(36000))
                    expect(agari.yakuNameList()).to(contain("haku"))
                    expect(agari.yakuNameList()).to(contain("chun"))
                    expect(agari.yakuNameList()).to(contain("shousangen"))
                    expect(agari.yakuNameList()).to(contain("honroutou"))
                    expect(agari.yakuNameList()).to(contain("toitoihou"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/220mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = true
                kyoku.doraNum = 2
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "p1tp1tp2tp2tp3tp4tp4tp6tp6tp7tp7tp8tp8tp3t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.score.total).to(equal(36000))
                    expect(agari.yakuNameList()).to(contain("reach"))
                    expect(agari.yakuNameList()).to(contain("chinitsu"))
                    expect(agari.yakuNameList()).to(contain("ryanpeikou"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/221mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "j5tj5tj5tj6tj6tj6tj7tj7tj1tj1tj1lm1lm1tm1t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.score.total).to(equal(36000))
                    expect(agari.yakuNameList()).to(contain("jikazeton"))
                    expect(agari.yakuNameList()).to(contain("bakazeton"))
                    expect(agari.yakuNameList()).to(contain("haku"))
                    expect(agari.yakuNameList()).to(contain("hatsu"))
                    expect(agari.yakuNameList()).to(contain("shousangen"))
                    expect(agari.yakuNameList()).to(contain("honitsu"))
                    expect(agari.yakuNameList()).to(contain("honroutou"))
                    expect(agari.yakuNameList()).to(contain("toitoihou"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/222mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "s1ts1ts9ts9tj1tj1tj1tj5tj5tj5tj7tj7tj7ts9t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.score.total).to(equal(48000))
                    expect(agari.yakuNameList()).to(contain("jikazeton"))
                    expect(agari.yakuNameList()).to(contain("bakazeton"))
                    expect(agari.yakuNameList()).to(contain("haku"))
                    expect(agari.yakuNameList()).to(contain("chun"))
                    expect(agari.yakuNameList()).to(contain("honitsu"))
                    expect(agari.yakuNameList()).to(contain("honroutou"))
                    expect(agari.yakuNameList()).to(contain("sanankou"))
                    expect(agari.yakuNameList()).to(contain("toitoihou"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/223mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "j5tj5tp1tp1lp1tj6tj6lj6tj6tj7tj7tj7tj7lj2tj2tj2tj2l"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.score.total).to(equal(48000))
                    expect(agari.yakuNameList()).to(contain("bakazenan"))
                    expect(agari.yakuNameList()).to(contain("hatsu"))
                    expect(agari.yakuNameList()).to(contain("chun"))
                    expect(agari.yakuNameList()).to(contain("shousangen"))
                    expect(agari.yakuNameList()).to(contain("honitsu"))
                    expect(agari.yakuNameList()).to(contain("honroutou"))
                    expect(agari.yakuNameList()).to(contain("toitoihou"))
                    expect(agari.yakuNameList()).to(contain("sankantsu"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/224mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m1tm2tm3tj5tj5tj5tj6tj6tj6tj7tj7tj7tj3tj3t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.score.total).to(equal(48000))
                    expect(agari.yakuNameList()).to(contain("daisangen"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/225mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m1tm1tm9ts1ts9tp1tp9tj1tj2tj4tj5tj6tj7tj3t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.score.total).to(equal(48000))
                    expect(agari.yakuNameList()).to(contain("kokushimuso"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/226mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = false
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "j6tj6tj7tj7tj2tj2tj2tj3tj3tj3tj7tj1lj1tj1t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.score.total).to(equal(48000))
                    expect(agari.yakuNameList()).to(contain("tsuisou"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/227mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m3tm3tm4tm4tm5tm5tm6tm6ts3ts3ts4ts4ts5ts5t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.score.total).to(equal(18000))
                    expect(agari.yakuNameList()).to(contain("tsumo"))
                    expect(agari.yakuNameList()).to(contain("tanyao"))
                    expect(agari.yakuNameList()).to(contain("pinfu"))
                    expect(agari.yakuNameList()).to(contain("ryanpeikou"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/228mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.TON
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = false
                kyoku.doraNum = 0
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "p2tp2tp2tp5tp5tp8tp8tp8tj1tj1lj1tj4tj4tj4l"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.score.total).to(equal(18000))
                    expect(agari.yakuNameList()).to(contain("jikazeton"))
                    expect(agari.yakuNameList()).to(contain("bakazeton"))
                    expect(agari.yakuNameList()).to(contain("honitsu"))
                    expect(agari.yakuNameList()).to(contain("toitoihou"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/229mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = false
                kyoku.doraNum = 1
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m6tm6tm7tm7tm8tm8ts6ts7ts8tp2tp2tp6tp7tp8t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.score.total).to(equal(18000))
                    expect(agari.yakuNameList()).to(contain("tsumo"))
                    expect(agari.yakuNameList()).to(contain("tanyao"))
                    expect(agari.yakuNameList()).to(contain("pinfu"))
                    expect(agari.yakuNameList()).to(contain("sansyoku"))
                    expect(agari.yakuNameList()).to(contain("iipeikou"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }


            it("ttp://dora12.com/2/yakuten/230mon.php"){
                var kyoku = Kyoku()
                kyoku.bakaze = Kaze.NAN
                kyoku.jikaze = Kaze.TON
                kyoku.honbaNum = 0
                kyoku.isTsumo = true
                kyoku.isReach = false
                kyoku.doraNum = 2
                kyoku.isIppatsu = false
                kyoku.finishType = FinishType.NORMAL
                let paiStr = "m1tm1tm2tm2tm3tm3tm9tm9tj1tj1lj1tj7tj7lj7t"
                let scr : ScoreCalcResult = ScoreCalculator.calcFromStr(paiStr, kyoku: kyoku)
                switch scr{
                case let .SUCCESS(agari):
                    expect(agari.score.total).to(equal(18000))
                    expect(agari.yakuNameList()).to(contain("jikazeton"))
                    expect(agari.yakuNameList()).to(contain("chun"))
                    expect(agari.yakuNameList()).to(contain("chanta"))
                    expect(agari.yakuNameList()).to(contain("honitsu"))

                case let .ERROR(msg):
                    //ここにきたらテスト失敗
                    println(msg)
                    expect(true).to(beFalsy())
                }
            }

        }
    }
}



