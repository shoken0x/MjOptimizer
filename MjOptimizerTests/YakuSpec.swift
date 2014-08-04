//
//  YakuSpec.swift
//  MjOptimizer
//
//  Created by fetaro on 2014/07/30.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

import MjOptimizer
import Quick
import Nimble

class YakuSpec: QuickSpec {
    override func spec() {
        describe("YCTanyao"){
            it("returns Yaku"){
                let mentsuList:[Mentsu] = [
                    Mentsu.parseStr("m2tm2t")!,
                    Mentsu.parseStr("m2tm3tm4t")!,
                    Mentsu.parseStr("s5ts3ts4t")!,
                    Mentsu.parseStr("p2tp3tp4t")!,
                    Mentsu.parseStr("s2ts2ts2l")!
                ]
                let agari = Agari(mentsuList: mentsuList)
                let kyoku = Kyoku()
                expect(YCTanyao().check(agari,kyoku: kyoku)!.kanji).to(equal("断么九"))
            }
            it("returns nil"){
                let mentsuList:[Mentsu] = [
                    Mentsu.parseStr("j1tj1t")!,
                    Mentsu.parseStr("m2tm3tm4t")!,
                    Mentsu.parseStr("s5ts3ts4t")!,
                    Mentsu.parseStr("p2tp3tp4t")!,
                    Mentsu.parseStr("s2ts2ts2l")!
                ]
                let agari = Agari(mentsuList: mentsuList)
                let kyoku = Kyoku()
                expect(YCTanyao().check(agari,kyoku: kyoku)).to(beNil())
            }
        }
        describe("YCPinfu"){
            it("returns Yaku"){
                let agariPai = PaiMaster.pais["m2t"]!
                var m = Mentsu.parseStr("m2tm3tm4t")!
                m.agariPai = agariPai
                let mentsuList:[Mentsu] = [
                    m,
                    Mentsu.parseStr("j3tj3t")!,
                    Mentsu.parseStr("s5ts3ts4t")!,
                    Mentsu.parseStr("p2tp3tp4t")!,
                    Mentsu.parseStr("p7tp8tp9t")!,
                ]
                let agari = Agari(mentsuList: mentsuList)
                let kyoku = Kyoku()
                expect(YCPinfu().check(agari,kyoku: kyoku)!.kanji).to(equal("平和"))
            }
            it("returns nil because there are not-shuntsu Mentsu"){
                let agariPai = PaiMaster.pais["m2t"]!
                var m = Mentsu.parseStr("m2tm3tm4t")!
                m.agariPai = agariPai
                let mentsuList:[Mentsu] = [
                    m,
                    Mentsu.parseStr("j3tj3t")!,
                    Mentsu.parseStr("s5ts3ts4t")!,
                    Mentsu.parseStr("p2tp3tp4t")!,
                    Mentsu.parseStr("p9tp9tp9t")!,
                ]
                let agari = Agari(mentsuList: mentsuList)
                let kyoku = Kyoku()
                expect(YCPinfu().check(agari,kyoku: kyoku)).to(beNil())
            }
            it("returns ni because machi is canchan"){
                let agariPai = PaiMaster.pais["m3t"]!
                var m = Mentsu.parseStr("m2tm3tm4t")!
                m.agariPai = agariPai
                let mentsuList:[Mentsu] = [
                    m,
                    Mentsu.parseStr("j3tj3t")!,
                    Mentsu.parseStr("s5ts3ts4t")!,
                    Mentsu.parseStr("p2tp3tp4t")!,
                    Mentsu.parseStr("p7tp8tp9t")!,
                ]
                let agari = Agari(mentsuList: mentsuList)
                let kyoku = Kyoku()
                expect(YCPinfu().check(agari,kyoku: kyoku)).to(beNil())
            }
            it("returns nil because atama is yakuhai"){
                let agariPai = PaiMaster.pais["m2t"]!
                var m = Mentsu.parseStr("m2tm3tm4t")!
                m.agariPai = agariPai
                let mentsuList:[Mentsu] = [
                    m,
                    Mentsu.parseStr("j1tj1t")!,
                    Mentsu.parseStr("s5ts3ts4t")!,
                    Mentsu.parseStr("p2tp3tp4t")!,
                    Mentsu.parseStr("p7tp8tp9t")!,
                ]
                let agari = Agari(mentsuList: mentsuList)
                let kyoku = Kyoku()
                expect(YCPinfu().check(agari,kyoku: kyoku)).to(beNil())
            }
        }
        describe("YCPeikou"){
            it("returns 一盃口"){
                let mentsuList:[Mentsu] = [
                    Mentsu.parseStr("m2tm2t")!,
                    Mentsu.parseStr("m2tm3tm4t")!,
                    Mentsu.parseStr("s5ts3ts4t")!,
                    Mentsu.parseStr("p2tp3tp4t")!,
                    Mentsu.parseStr("p2tp3tp4t")!
                ]
                let agari = Agari(mentsuList: mentsuList)
                let kyoku = Kyoku()
                expect(YCPeikou().check(agari,kyoku: kyoku)!.kanji).to(equal("一盃口"))
            }
            it("returns 二盃口"){
                let mentsuList:[Mentsu] = [
                    Mentsu.parseStr("m2tm2t")!,
                    Mentsu.parseStr("m2tm3tm4t")!,
                    Mentsu.parseStr("m2tm3tm4t")!,
                    Mentsu.parseStr("p2tp3tp4t")!,
                    Mentsu.parseStr("p2tp3tp4t")!
                ]
                let agari = Agari(mentsuList: mentsuList)
                let kyoku = Kyoku()
                expect(YCPeikou().check(agari,kyoku: kyoku)!.kanji).to(equal("二盃口"))
            }
            it("returns nil"){
                let mentsuList:[Mentsu] = [
                    Mentsu.parseStr("m2tm2t")!,
                    Mentsu.parseStr("m2tm3tm4t")!,
                    Mentsu.parseStr("s5ts3ts4t")!,
                    Mentsu.parseStr("p2tp3tp4t")!,
                    Mentsu.parseStr("p5tp3tp4t")!
                ]
                let agari = Agari(mentsuList: mentsuList)
                let kyoku = Kyoku()
                expect(YCPeikou().check(agari,kyoku: kyoku)).to(beNil())
            }
            it("returns nil when agari has furo"){
                let mentsuList:[Mentsu] = [
                    Mentsu.parseStr("m2tm2t")!,
                    Mentsu.parseStr("m2tm3tm4t")!,
                    Mentsu.parseStr("s5ts3ts4t")!,
                    Mentsu.parseStr("p2tp3tp4t")!,
                    Mentsu.parseStr("p2tp3tp4l")!
                ]
                let agari = Agari(mentsuList: mentsuList)
                let kyoku = Kyoku()
                expect(YCPeikou().check(agari,kyoku: kyoku)).to(beNil())
            }
        }
    }
}
//テストクラスが長くなぎすぎるとよくXCodeが落ちるので、適当に分割
class YakuSpec2: QuickSpec {
    override func spec() {
        describe("YCChanta混全帯么九/混老頭/純全帯么九/清老頭"){
            it("returns 混全帯么九"){
                let mentsuList:[Mentsu] = [
                    Mentsu.parseStr("m1tm1t")!,
                    Mentsu.parseStr("m1tm2tm3t")!,
                    Mentsu.parseStr("s8ts7ts9t")!,
                    Mentsu.parseStr("p1tp1tp1t")!,
                    Mentsu.parseStr("j1tj1tj1l")!
                ]
                let agari = Agari(mentsuList: mentsuList)
                let kyoku = Kyoku()
                expect(YCChanta().check(agari,kyoku: kyoku)!.kanji).to(equal("混全帯么九"))
            }
            it("returns 混老頭"){
                let mentsuList:[Mentsu] = [
                    Mentsu.parseStr("m9tm9t")!,
                    Mentsu.parseStr("m1tm1tm1t")!,
                    Mentsu.parseStr("s9ts9ts9t")!,
                    Mentsu.parseStr("p1tp1tp1t")!,
                    Mentsu.parseStr("j1tj1tj1l")!
                ]
                let agari = Agari(mentsuList: mentsuList)
                let kyoku = Kyoku()
                expect(YCChanta().check(agari,kyoku: kyoku)!.kanji).to(equal("混老頭"))
            }
            it("returns 純全帯么九"){
                let mentsuList:[Mentsu] = [
                    Mentsu.parseStr("m1tm1t")!,
                    Mentsu.parseStr("m1tm2tm3t")!,
                    Mentsu.parseStr("s8ts7ts9t")!,
                    Mentsu.parseStr("p1tp1tp1t")!,
                    Mentsu.parseStr("s1ts1ts1l")!
                ]
                let agari = Agari(mentsuList: mentsuList)
                let kyoku = Kyoku()
                expect(YCChanta().check(agari,kyoku: kyoku)!.kanji).to(equal("純全帯么九"))
            }
            it("returns 清老頭"){
                let mentsuList:[Mentsu] = [
                    Mentsu.parseStr("m9tm9t")!,
                    Mentsu.parseStr("m1tm1tm1t")!,
                    Mentsu.parseStr("s9ts9ts9t")!,
                    Mentsu.parseStr("p1tp1tp1t")!,
                    Mentsu.parseStr("s1ts1ts1t")!
                ]
                let agari = Agari(mentsuList: mentsuList)
                let kyoku = Kyoku()
                expect(YCChanta().check(agari,kyoku: kyoku)!.kanji).to(equal("清老頭"))
            }
        }
        describe("YCIkkitsukan"){
            it("returns 一気通貫"){
                let mentsuList:[Mentsu] = [
                    Mentsu.parseStr("m1tm1t")!,
                    Mentsu.parseStr("m1tm2tm3t")!,
                    Mentsu.parseStr("m4tm5tm6t")!,
                    Mentsu.parseStr("p1tp1tp1t")!,
                    Mentsu.parseStr("m7tm8tm9l")!
                ]
                let agari = Agari(mentsuList: mentsuList)
                let kyoku = Kyoku()
                expect(YCIkkitsukan().check(agari,kyoku: kyoku)!.kanji).to(equal("一気通貫"))
            }
            it("returns nil"){
                let mentsuList:[Mentsu] = [
                    Mentsu.parseStr("m1tm1t")!,
                    Mentsu.parseStr("m1tm2tm3t")!,
                    Mentsu.parseStr("s8ts7ts9t")!,
                    Mentsu.parseStr("p1tp1tp1t")!,
                    Mentsu.parseStr("s1ts1ts1l")!
                ]
                let agari = Agari(mentsuList: mentsuList)
                let kyoku = Kyoku()
                expect(YCIkkitsukan().check(agari,kyoku: kyoku)).to(beNil())
            }
        }
        describe("YCSansyoku"){
            it("returns 三色同順"){
                let mentsuList:[Mentsu] = [
                    Mentsu.parseStr("m1tm1t")!,
                    Mentsu.parseStr("m1tm2tm3t")!,
                    Mentsu.parseStr("s1ts2ts3t")!,
                    Mentsu.parseStr("p1tp1tp1t")!,
                    Mentsu.parseStr("p1tp2tp3t")!
                ]
                let agari = Agari(mentsuList: mentsuList)
                let kyoku = Kyoku()
                expect(YCSansyoku().check(agari,kyoku: kyoku)!.kanji).to(equal("三色同順"))
            }
            it("returns nil because agari is 2 syoku"){
                let mentsuList:[Mentsu] = [
                    Mentsu.parseStr("m1tm1t")!,
                    Mentsu.parseStr("m1tm2tm3t")!,
                    Mentsu.parseStr("s1ts2ts3t")!,
                    Mentsu.parseStr("p1tp1tp1t")!,
                    Mentsu.parseStr("s1ts1ts1l")!
                ]
                let agari = Agari(mentsuList: mentsuList)
                let kyoku = Kyoku()
                expect(YCSansyoku().check(agari,kyoku: kyoku)).to(beNil())
            }
        }
        describe("YCSansyokudouko"){
            it("returns 三色同刻"){
                let mentsuList:[Mentsu] = [
                    Mentsu.parseStr("m1tm1t")!,
                    Mentsu.parseStr("m2tm2tm2t")!,
                    Mentsu.parseStr("s2ts2ts2t")!,
                    Mentsu.parseStr("p1tp2tp3t")!,
                    Mentsu.parseStr("p2tp2tp2t")!
                ]
                let agari = Agari(mentsuList: mentsuList)
                let kyoku = Kyoku()
                expect(YCSansyokudouko().check(agari,kyoku: kyoku)!.kanji).to(equal("三色同刻"))
            }
            it("returns nil because agari is 2 syoku"){
                let mentsuList:[Mentsu] = [
                    Mentsu.parseStr("m1tm1t")!,
                    Mentsu.parseStr("m2tm2tm2t")!,
                    Mentsu.parseStr("p1tp2tp3t")!,
                    Mentsu.parseStr("p1tp2tp3t")!,
                    Mentsu.parseStr("p2tp2tp2t")!
                ]
                let agari = Agari(mentsuList: mentsuList)
                let kyoku = Kyoku()
                expect(YCSansyokudouko().check(agari,kyoku: kyoku)).to(beNil())
            }
        }
        describe("YCToitoihou"){
            it("returns 対々和"){
                let mentsuList:[Mentsu] = [
                    Mentsu.parseStr("m1tm1t")!,
                    Mentsu.parseStr("m2tm2rm2t")!,
                    Mentsu.parseStr("s2bs2ts2t")!,
                    Mentsu.parseStr("p5tp5tp5l")!,
                    Mentsu.parseStr("p2rp2tp2t")!
                ]
                let agari = Agari(mentsuList: mentsuList)
                let kyoku = Kyoku()
                expect(YCToitoihou().check(agari,kyoku: kyoku)!.kanji).to(equal("対々和"))
            }
            it("returns nil because there are shuntsu"){
                let mentsuList:[Mentsu] = [
                    Mentsu.parseStr("m1tm1t")!,
                    Mentsu.parseStr("m2tm2tm2t")!,
                    Mentsu.parseStr("s2ts2ts2t")!,
                    Mentsu.parseStr("p1tp2tp3t")!,
                    Mentsu.parseStr("p2tp2tp2t")!
                ]
                let agari = Agari(mentsuList: mentsuList)
                let kyoku = Kyoku()
                expect(YCToitoihou().check(agari,kyoku: kyoku)).to(beNil())
            }
        }
        describe("YCAnkou三暗刻//四暗刻"){
            it("returns 三暗刻"){
                let mentsuList:[Mentsu] = [
                    Mentsu.parseStr("m1tm1t")!,
                    Mentsu.parseStr("m2tm2tm2t")!,
                    Mentsu.parseStr("s2ts2ts2t")!,
                    Mentsu.parseStr("p1tp2tp3t")!,
                    Mentsu.parseStr("p2tp2tp2t")!
                ]
                let agari = Agari(mentsuList: mentsuList)
                let kyoku = Kyoku()
                expect(YCAnkou().check(agari,kyoku: kyoku)!.kanji).to(equal("三暗刻"))
            }
            it("returns 四暗刻"){
                let mentsuList:[Mentsu] = [
                    Mentsu.parseStr("m1tm1t")!,
                    Mentsu.parseStr("m2tm2tm2t")!,
                    Mentsu.parseStr("s2ts2ts2t")!,
                    Mentsu.parseStr("p5tp5tp5t")!,
                    Mentsu.parseStr("p2tp2tp2t")!
                ]
                let agari = Agari(mentsuList: mentsuList)
                let kyoku = Kyoku()
                expect(YCAnkou().check(agari,kyoku: kyoku)!.kanji).to(equal("四暗刻"))
            }
            it("returns nil because ron"){
                let agariPai = PaiMaster.pais["m2t"]!
                var m = Mentsu.parseStr("m2tm2tm2t")!
                m.agariPai = agariPai
                let mentsuList:[Mentsu] = [
                    m,
                    Mentsu.parseStr("m1tm1t")!,
                    Mentsu.parseStr("s2ts2ts2t")!,
                    Mentsu.parseStr("p1tp2tp3t")!,
                    Mentsu.parseStr("p2tp2tp2t")!
                ]
                let agari = Agari(mentsuList: mentsuList)
                let kyoku = Kyoku()
                kyoku.isTsumo = false
                expect(YCAnkou().check(agari,kyoku: kyoku)).to(beNil())
            }
        }
    }
}
//テストクラスが長くなぎすぎるとよくXCodeが落ちるので、適当に分割
class YakuSpec3: QuickSpec {
    override func spec() {
        describe("YCKantsu"){
            it("returns 三槓子"){
                let mentsuList:[Mentsu] = [
                    Mentsu.parseStr("j5tj5t")!,
                    Mentsu.parseStr("j7tj7tj7tj7l")!,
                    Mentsu.parseStr("j6rj6tj6tj6t")!,
                    Mentsu.parseStr("p1tp2tp3t")!,
                    Mentsu.parseStr("p2tp2tp2tp2t")!
                ]
                let agari = Agari(mentsuList: mentsuList)
                let kyoku = Kyoku()
                expect(YCKantsu().check(agari,kyoku: kyoku)!.kanji).to(equal("三槓子"))
            }
            it("returns 四槓子"){
                let mentsuList:[Mentsu] = [
                    Mentsu.parseStr("j5tj5t")!,
                    Mentsu.parseStr("j7tj7tj7tj7l")!,
                    Mentsu.parseStr("j6rj6tj6tj6t")!,
                    Mentsu.parseStr("m1tm1tm1tm1t")!,
                    Mentsu.parseStr("p2tp2tp2tp2t")!
                ]
                let agari = Agari(mentsuList: mentsuList)
                let kyoku = Kyoku()
                expect(YCKantsu().check(agari,kyoku: kyoku)!.kanji).to(equal("四槓子"))
            }
            it("returns nil because 2 kantsu"){
                let mentsuList:[Mentsu] = [
                    Mentsu.parseStr("j5tj5t")!,
                    Mentsu.parseStr("j7tj7tj7t")!,
                    Mentsu.parseStr("j6rj6tj6t")!,
                    Mentsu.parseStr("m1tm1tm1tm1t")!,
                    Mentsu.parseStr("p2tp2tp2tp2t")!
                ]
                let agari = Agari(mentsuList: mentsuList)
                let kyoku = Kyoku()
                expect(YCKantsu().check(agari,kyoku: kyoku)).to(beNil())
            }
        }
        describe("YCSangen"){
            it("returns 小三元"){
                let mentsuList:[Mentsu] = [
                    Mentsu.parseStr("j5tj5t")!,
                    Mentsu.parseStr("j7tj7tj7t")!,
                    Mentsu.parseStr("j6tj6tj6t")!,
                    Mentsu.parseStr("p1tp2tp3t")!,
                    Mentsu.parseStr("p2tp2tp2t")!
                ]
                let agari = Agari(mentsuList: mentsuList)
                let kyoku = Kyoku()
                expect(YCSangen().check(agari,kyoku: kyoku)!.kanji).to(equal("小三元"))
            }
            it("returns 大三元"){
                let mentsuList:[Mentsu] = [
                    Mentsu.parseStr("j5tj5tj5l")!,
                    Mentsu.parseStr("j7tj7tj7t")!,
                    Mentsu.parseStr("j6tj6tj6t")!,
                    Mentsu.parseStr("p1tp2tp3t")!,
                    Mentsu.parseStr("p2tp2t")!
                ]
                let agari = Agari(mentsuList: mentsuList)
                let kyoku = Kyoku()
                expect(YCSangen().check(agari,kyoku: kyoku)!.kanji).to(equal("大三元"))
            }
            it("returns nil because chitoitsu"){
                let mentsuList:[Mentsu] = [
                    Mentsu.parseStr("j5tj5t")!,
                    Mentsu.parseStr("j7tj7t")!,
                    Mentsu.parseStr("j6tj6t")!,
                    Mentsu.parseStr("p2tp2t")!,
                    Mentsu.parseStr("p3tp3t")!,
                    Mentsu.parseStr("p4tp4t")!,
                    Mentsu.parseStr("p5tp5t")!
                ]
                let agari = Agari(mentsuList: mentsuList)
                let kyoku = Kyoku()
                expect(YCSangen().check(agari,kyoku: kyoku)).to(beNil())
            }
        }
        describe("YCSushihou"){
            it("returns 小四喜"){
                let mentsuList:[Mentsu] = [
                    Mentsu.parseStr("j1tj1t")!,
                    Mentsu.parseStr("j2tj2tj2t")!,
                    Mentsu.parseStr("j3tj3tj3t")!,
                    Mentsu.parseStr("j4tj4tj4t")!,
                    Mentsu.parseStr("p2tp2tp2t")!
                ]
                let agari = Agari(mentsuList: mentsuList)
                let kyoku = Kyoku()
                expect(YCSushihou().check(agari,kyoku: kyoku)!.kanji).to(equal("小四喜"))
            }
            it("returns 大四喜"){
                let mentsuList:[Mentsu] = [
                    Mentsu.parseStr("j1tj1tj1t")!,
                    Mentsu.parseStr("j2tj2tj2t")!,
                    Mentsu.parseStr("j3tj3tj3t")!,
                    Mentsu.parseStr("j4tj4tj4t")!,
                    Mentsu.parseStr("p2tp2t")!
                ]
                let agari = Agari(mentsuList: mentsuList)
                let kyoku = Kyoku()
                expect(YCSushihou().check(agari,kyoku: kyoku)!.kanji).to(equal("大四喜"))
            }
            it("returns nil because chitoitsu"){
                let mentsuList:[Mentsu] = [
                    Mentsu.parseStr("j1tj1t")!,
                    Mentsu.parseStr("j2tj2t")!,
                    Mentsu.parseStr("j3tj3t")!,
                    Mentsu.parseStr("j4tj4t")!,
                    Mentsu.parseStr("p3tp3t")!,
                    Mentsu.parseStr("p4tp4t")!,
                    Mentsu.parseStr("p5tp5t")!
                ]
                let agari = Agari(mentsuList: mentsuList)
                let kyoku = Kyoku()
                expect(YCSushihou().check(agari,kyoku: kyoku)).to(beNil())
            }
        }
        describe("YCSomete"){
            it("returns 清一色"){
                let mentsuList:[Mentsu] = [
                    Mentsu.parseStr("s3ts3t")!,
                    Mentsu.parseStr("s3ts4ts5t")!,
                    Mentsu.parseStr("s6ts6ts6t")!,
                    Mentsu.parseStr("s8ts8ts8t")!,
                    Mentsu.parseStr("s2ts2ts2t")!
                ]
                let agari = Agari(mentsuList: mentsuList)
                let kyoku = Kyoku()
                expect(YCSomete().check(agari,kyoku: kyoku)!.kanji).to(equal("清一色"))
            }
            it("returns 文一色"){
                let mentsuList:[Mentsu] = [
                    Mentsu.parseStr("j1tj1tj1tj1t")!,
                    Mentsu.parseStr("j2rj2tj2t")!,
                    Mentsu.parseStr("j3rj3tj3t")!,
                    Mentsu.parseStr("j5tj5tj5tj5l")!,
                    Mentsu.parseStr("j7tj7t")!
                ]
                let agari = Agari(mentsuList: mentsuList)
                let kyoku = Kyoku()
                expect(YCSomete().check(agari,kyoku: kyoku)!.kanji).to(equal("文一色"))
            }
            it("returns 混一色"){
                let mentsuList:[Mentsu] = [
                    Mentsu.parseStr("j6tj6t")!,
                    Mentsu.parseStr("s3ts4ts5t")!,
                    Mentsu.parseStr("s6ts6ts6t")!,
                    Mentsu.parseStr("s8ts8ts8t")!,
                    Mentsu.parseStr("s2ts2ts2t")!
                ]
                let agari = Agari(mentsuList: mentsuList)
                let kyoku = Kyoku()
                expect(YCSomete().check(agari,kyoku: kyoku)!.kanji).to(equal("混一色"))
            }
            it("returns 緑一色"){
                let mentsuList:[Mentsu] = [
                    Mentsu.parseStr("j6tj6t")!,
                    Mentsu.parseStr("s2ts3ts4t")!,
                    Mentsu.parseStr("s6ts6ts6t")!,
                    Mentsu.parseStr("s8ts8ts8t")!,
                    Mentsu.parseStr("s4ts3ts2t")!
                ]
                let agari = Agari(mentsuList: mentsuList)
                let kyoku = Kyoku()
                expect(YCSomete().check(agari,kyoku: kyoku)!.kanji).to(equal("緑一色"))
            }
            it("returns 九蓮宝燈"){
                let mentsuList:[Mentsu] = [
                    Mentsu.parseStr("s1ts1ts1t")!,
                    Mentsu.parseStr("s1ts2ts3t")!,
                    Mentsu.parseStr("s4ts5ts6t")!,
                    Mentsu.parseStr("s7ts8ts9t")!,
                    Mentsu.parseStr("s9ts9t")!
                ]
                let agari = Agari(mentsuList: mentsuList)
                let kyoku = Kyoku()
                expect(YCSomete().check(agari,kyoku: kyoku)!.kanji).to(equal("九蓮宝燈"))
            }
            it("returns nil"){
                let mentsuList:[Mentsu] = [
                    Mentsu.parseStr("s1ts1t")!,
                    Mentsu.parseStr("m2tm3tm4t")!,
                    Mentsu.parseStr("m5tm6tm7t")!,
                    Mentsu.parseStr("m3tm4tm5t")!,
                    Mentsu.parseStr("m9tm9tm9l")!
                ]
                let agari = Agari(mentsuList: mentsuList)
                let kyoku = Kyoku()
                expect(YCSomete().check(agari,kyoku: kyoku)).to(beFalsy())
            }
        }
    }
}
//テストクラスが長くなぎすぎるとよくXCodeが落ちるので、適当に分割
class YakuSpec4: QuickSpec {
    override func spec() {
        describe("YCChitoitsu"){
            it("returns 七対子"){
                let mentsuList:[Mentsu] = [
                    Mentsu.parseStr("j5tj5t")!,
                    Mentsu.parseStr("p1tp1t")!,
                    Mentsu.parseStr("m3tm3t")!,
                    Mentsu.parseStr("s3ts3t")!,
                    Mentsu.parseStr("s5ts5t")!,
                    Mentsu.parseStr("m5tm5t")!,
                    Mentsu.parseStr("j1tj1t")!
                ]
                let agari = Agari(mentsuList: mentsuList)
                let kyoku = Kyoku()
                expect(YCChitoitsu().check(agari,kyoku: kyoku)!.kanji).to(equal("七対子"))
            }
        }
    }
}


