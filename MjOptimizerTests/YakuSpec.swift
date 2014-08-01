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
        describe("TanyaoYaku"){
            it("return true"){
                let mentsuList:[Mentsu] = [
                    Mentsu.parseStr("m2tm2t")!,
                    Mentsu.parseStr("m2tm3tm4t")!,
                    Mentsu.parseStr("s5ts3ts4t")!,
                    Mentsu.parseStr("p2tp3tp4t")!,
                    Mentsu.parseStr("s2ts2ts2l")!
                ]
                let agari = Agari(mentsuList: mentsuList)
                let kyoku = Kyoku()
                expect(YakuTanyao().isConcluded(agari,kyoku: kyoku)).to(beTruthy())
            }
            it("return false"){
                let mentsuList:[Mentsu] = [
                    Mentsu.parseStr("j1tj1t")!,
                    Mentsu.parseStr("m2tm3tm4t")!,
                    Mentsu.parseStr("s5ts3ts4t")!,
                    Mentsu.parseStr("p2tp3tp4t")!,
                    Mentsu.parseStr("s2ts2ts2l")!
                ]
                let agari = Agari(mentsuList: mentsuList)
                let kyoku = Kyoku()
                expect(YakuTanyao().isConcluded(agari,kyoku: kyoku)).to(beFalsy())
            }
        }
        describe("PinfuYaku"){
            it("return true"){
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
                expect(YakuPinfu().isConcluded(agari,kyoku: kyoku)).to(beTruthy())
            }
            it("return false because there are not-shuntsu Mentsu"){
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
                expect(YakuPinfu().isConcluded(agari,kyoku: kyoku)).to(beFalsy())
            }
            it("return false because machi is canchan"){
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
                expect(YakuPinfu().isConcluded(agari,kyoku: kyoku)).to(beFalsy())
            }
            it("return false because atama is yakuhai"){
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
                expect(YakuPinfu().isConcluded(agari,kyoku: kyoku)).to(beFalsy())
            }
        }
        describe("YakuIipeikou"){
            it("return true"){
                let mentsuList:[Mentsu] = [
                    Mentsu.parseStr("m2tm2t")!,
                    Mentsu.parseStr("m2tm3tm4t")!,
                    Mentsu.parseStr("s5ts3ts4t")!,
                    Mentsu.parseStr("p2tp3tp4t")!,
                    Mentsu.parseStr("p3tp2tp4t")!
                ]
                let agari = Agari(mentsuList: mentsuList)
                let kyoku = Kyoku()
                expect(YakuIipeikou().isConcluded(agari,kyoku: kyoku)).to(beTruthy())
            }
            it("return false"){
                let mentsuList:[Mentsu] = [
                    Mentsu.parseStr("m2tm2t")!,
                    Mentsu.parseStr("m2tm3tm4t")!,
                    Mentsu.parseStr("s5ts3ts4t")!,
                    Mentsu.parseStr("p2tp3tp4t")!,
                    Mentsu.parseStr("p5tp3tp4t")!
                ]
                let agari = Agari(mentsuList: mentsuList)
                let kyoku = Kyoku()
                expect(YakuIipeikou().isConcluded(agari,kyoku: kyoku)).to(beFalsy())
            }
            it("return false when agari has furo"){
                let mentsuList:[Mentsu] = [
                    Mentsu.parseStr("m2tm2t")!,
                    Mentsu.parseStr("m2tm3tm4t")!,
                    Mentsu.parseStr("s5ts3ts4t")!,
                    Mentsu.parseStr("p2tp3tp4t")!,
                    Mentsu.parseStr("p2tp3tp4l")!
                ]
                let agari = Agari(mentsuList: mentsuList)
                let kyoku = Kyoku()
                expect(YakuIipeikou().isConcluded(agari,kyoku: kyoku)).to(beFalsy())
            }
        }
        describe("YakuChanta"){
            it("return true"){
                let mentsuList:[Mentsu] = [
                    Mentsu.parseStr("m1tm1t")!,
                    Mentsu.parseStr("m1tm2tm3t")!,
                    Mentsu.parseStr("s8ts7ts9t")!,
                    Mentsu.parseStr("p1tp1tp1t")!,
                    Mentsu.parseStr("j1tj1tj1l")!
                ]
                let agari = Agari(mentsuList: mentsuList)
                let kyoku = Kyoku()
                expect(YakuChanta().isConcluded(agari,kyoku: kyoku)).to(beTruthy())
            }
            it("return false because agari is junchan"){
                let mentsuList:[Mentsu] = [
                    Mentsu.parseStr("m1tm1t")!,
                    Mentsu.parseStr("m1tm2tm3t")!,
                    Mentsu.parseStr("s8ts7ts9t")!,
                    Mentsu.parseStr("p1tp1tp1t")!,
                    Mentsu.parseStr("s1ts1ts1l")!
                ]
                let agari = Agari(mentsuList: mentsuList)
                let kyoku = Kyoku()
                expect(YakuChanta().isConcluded(agari,kyoku: kyoku)).to(beFalsy())
            }
            it("return false because agari is honroutou"){
                let mentsuList:[Mentsu] = [
                    Mentsu.parseStr("m9tm9t")!,
                    Mentsu.parseStr("m1tm1tm1t")!,
                    Mentsu.parseStr("s9ts9ts9t")!,
                    Mentsu.parseStr("p1tp1tp1t")!,
                    Mentsu.parseStr("j1tj1tj1l")!
                ]
                let agari = Agari(mentsuList: mentsuList)
                let kyoku = Kyoku()
                expect(YakuChanta().isConcluded(agari,kyoku: kyoku)).to(beFalsy())
            }
        }
        describe("YakuIkkitsukan"){
            it("return true"){
                let mentsuList:[Mentsu] = [
                    Mentsu.parseStr("m1tm1t")!,
                    Mentsu.parseStr("m1tm2tm3t")!,
                    Mentsu.parseStr("m4tm5tm6t")!,
                    Mentsu.parseStr("p1tp1tp1t")!,
                    Mentsu.parseStr("m7tm8tm9l")!
                ]
                let agari = Agari(mentsuList: mentsuList)
                let kyoku = Kyoku()
                expect(YakuIkkitsukan().isConcluded(agari,kyoku: kyoku)).to(beTruthy())
            }
            it("return false"){
                let mentsuList:[Mentsu] = [
                    Mentsu.parseStr("m1tm1t")!,
                    Mentsu.parseStr("m1tm2tm3t")!,
                    Mentsu.parseStr("s8ts7ts9t")!,
                    Mentsu.parseStr("p1tp1tp1t")!,
                    Mentsu.parseStr("s1ts1ts1l")!
                ]
                let agari = Agari(mentsuList: mentsuList)
                let kyoku = Kyoku()
                expect(YakuIkkitsukan().isConcluded(agari,kyoku: kyoku)).to(beFalsy())
            }
        }
        describe("YakuSansyoku"){
            it("return true"){
                let mentsuList:[Mentsu] = [
                    Mentsu.parseStr("m1tm1t")!,
                    Mentsu.parseStr("m1tm2tm3t")!,
                    Mentsu.parseStr("s1ts2ts3t")!,
                    Mentsu.parseStr("p1tp1tp1t")!,
                    Mentsu.parseStr("p1tp2tp3t")!
                ]
                let agari = Agari(mentsuList: mentsuList)
                let kyoku = Kyoku()
                expect(YakuSansyoku().isConcluded(agari,kyoku: kyoku)).to(beTruthy())
            }
            it("return false because agari is 2 syoku"){
                let mentsuList:[Mentsu] = [
                    Mentsu.parseStr("m1tm1t")!,
                    Mentsu.parseStr("m1tm2tm3t")!,
                    Mentsu.parseStr("s1ts2ts3t")!,
                    Mentsu.parseStr("p1tp1tp1t")!,
                    Mentsu.parseStr("s1ts1ts1l")!
                ]
                let agari = Agari(mentsuList: mentsuList)
                let kyoku = Kyoku()
                expect(YakuSansyoku().isConcluded(agari,kyoku: kyoku)).to(beFalsy())
            }
        }
        describe("YakuSansyokudouko"){
            it("return true"){
                let mentsuList:[Mentsu] = [
                    Mentsu.parseStr("m1tm1t")!,
                    Mentsu.parseStr("m2tm2tm2t")!,
                    Mentsu.parseStr("s2ts2ts2t")!,
                    Mentsu.parseStr("p1tp2tp3t")!,
                    Mentsu.parseStr("p2tp2tp2t")!
                ]
                let agari = Agari(mentsuList: mentsuList)
                let kyoku = Kyoku()
                expect(YakuSansyokudouko().isConcluded(agari,kyoku: kyoku)).to(beTruthy())
            }
            it("return false because agari is 2 syoku"){
                let mentsuList:[Mentsu] = [
                    Mentsu.parseStr("m1tm1t")!,
                    Mentsu.parseStr("m2tm2tm2t")!,
                    Mentsu.parseStr("p1tp2tp3t")!,
                    Mentsu.parseStr("p1tp2tp3t")!,
                    Mentsu.parseStr("p2tp2tp2t")!
                ]
                let agari = Agari(mentsuList: mentsuList)
                let kyoku = Kyoku()
                expect(YakuSansyokudouko().isConcluded(agari,kyoku: kyoku)).to(beFalsy())
            }
        }
        describe("YakuSananko"){
            it("return true"){
                let mentsuList:[Mentsu] = [
                    Mentsu.parseStr("m1tm1t")!,
                    Mentsu.parseStr("m2tm2tm2t")!,
                    Mentsu.parseStr("s2ts2ts2t")!,
                    Mentsu.parseStr("p1tp2tp3t")!,
                    Mentsu.parseStr("p2tp2tp2t")!
                ]
                let agari = Agari(mentsuList: mentsuList)
                let kyoku = Kyoku()
                expect(YakuSanankou().isConcluded(agari,kyoku: kyoku)).to(beTruthy())
            }
            it("return false because ron"){
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
                expect(YakuSanankou().isConcluded(agari,kyoku: kyoku)).to(beFalsy())
            }
        }
        describe("YakuSankantsu"){
            it("return true"){
                let mentsuList:[Mentsu] = [
                    Mentsu.parseStr("j5tj5t")!,
                    Mentsu.parseStr("j7tj7tj7tj7l")!,
                    Mentsu.parseStr("j6rj6tj6tj6t")!,
                    Mentsu.parseStr("p1tp2tp3t")!,
                    Mentsu.parseStr("p2tp2tp2tp2t")!
                ]
                let agari = Agari(mentsuList: mentsuList)
                let kyoku = Kyoku()
                expect(YakuSankantsu().isConcluded(agari,kyoku: kyoku)).to(beTruthy())
            }
            it("return false because sukantsu"){
                let mentsuList:[Mentsu] = [
                    Mentsu.parseStr("j5tj5t")!,
                    Mentsu.parseStr("j7tj7tj7tj7l")!,
                    Mentsu.parseStr("j6rj6tj6tj6t")!,
                    Mentsu.parseStr("m1tm1tm1tm1t")!,
                    Mentsu.parseStr("p2tp2tp2tp2t")!
                ]
                let agari = Agari(mentsuList: mentsuList)
                let kyoku = Kyoku()
                expect(YakuSankantsu().isConcluded(agari,kyoku: kyoku)).to(beFalsy())
            }
        }
        describe("YakuShousangen"){
            it("return true"){
                let mentsuList:[Mentsu] = [
                    Mentsu.parseStr("j5tj5t")!,
                    Mentsu.parseStr("j7tj7tj7t")!,
                    Mentsu.parseStr("j6tj6tj6t")!,
                    Mentsu.parseStr("p1tp2tp3t")!,
                    Mentsu.parseStr("p2tp2tp2t")!
                ]
                let agari = Agari(mentsuList: mentsuList)
                let kyoku = Kyoku()
                expect(YakuShousangen().isConcluded(agari,kyoku: kyoku)).to(beTruthy())
            }
            it("return false because daisangen"){
                let mentsuList:[Mentsu] = [
                    Mentsu.parseStr("j5tj5tj5t")!,
                    Mentsu.parseStr("j7tj7tj7t")!,
                    Mentsu.parseStr("j6tj6tj6t")!,
                    Mentsu.parseStr("p1tp2tp3t")!,
                    Mentsu.parseStr("p2tp2t")!
                ]
                let agari = Agari(mentsuList: mentsuList)
                let kyoku = Kyoku()
                expect(YakuShousangen().isConcluded(agari,kyoku: kyoku)).to(beFalsy())
            }
        }
        describe("YakuHonroutou"){
            it("return true"){
                let mentsuList:[Mentsu] = [
                    Mentsu.parseStr("j5tj5t")!,
                    Mentsu.parseStr("j7tj7tj7t")!,
                    Mentsu.parseStr("j6tj6tj6t")!,
                    Mentsu.parseStr("p1tp1tp1t")!,
                    Mentsu.parseStr("p9tp9tp9t")!
                ]
                let agari = Agari(mentsuList: mentsuList)
                let kyoku = Kyoku()
                expect(YakuHonroutou().isConcluded(agari,kyoku: kyoku)).to(beTruthy())
            }
            it("return true2"){
                let mentsuList:[Mentsu] = [
                    Mentsu.parseStr("j5tj5t")!,
                    Mentsu.parseStr("j7tj7t")!,
                    Mentsu.parseStr("j6tj6t")!,
                    Mentsu.parseStr("p1tp1t")!,
                    Mentsu.parseStr("p9tp9t")!,
                    Mentsu.parseStr("m1tm1t")!,
                    Mentsu.parseStr("m9tm9t")!
                ]
                let agari = Agari(mentsuList: mentsuList)
                let kyoku = Kyoku()
                expect(YakuHonroutou().isConcluded(agari,kyoku: kyoku)).to(beTruthy())
            }
            it("return false because chinroutou"){
                let mentsuList:[Mentsu] = [
                    Mentsu.parseStr("p1tp1tp1t")!,
                    Mentsu.parseStr("p9tp9tp9t")!,
                    Mentsu.parseStr("m1tm1tm1t")!,
                    Mentsu.parseStr("m9tm9tm9t")!,
                    Mentsu.parseStr("s1ts1t")!
                ]
                let agari = Agari(mentsuList: mentsuList)
                let kyoku = Kyoku()
                expect(YakuHonroutou().isConcluded(agari,kyoku: kyoku)).to(beFalsy())
            }
            it("return false because tsuiso"){
                let mentsuList:[Mentsu] = [
                    Mentsu.parseStr("j5tj5tj5t")!,
                    Mentsu.parseStr("j7tj7tj7t")!,
                    Mentsu.parseStr("j6tj6tj6t")!,
                    Mentsu.parseStr("j1tj1tj1t")!,
                    Mentsu.parseStr("j2tj2t")!
                ]
                let agari = Agari(mentsuList: mentsuList)
                let kyoku = Kyoku()
                expect(YakuHonroutou().isConcluded(agari,kyoku: kyoku)).to(beFalsy())
            }
        }
    }
}

