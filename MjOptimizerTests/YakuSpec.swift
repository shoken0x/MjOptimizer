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
                let atama = ToitsuMentsu(pai: PaiMaster.pais["m2t"]!)
                let menzenMentsuList:[Mentsu] = [
                    Mentsu.parseStr("m2tm3tm4t")!,
                    Mentsu.parseStr("s5ts3ts4t")!,
                    Mentsu.parseStr("p2tp3tp4t")!,
                    atama
                ]
                let furoMentsuList:[Mentsu] = [
                    Mentsu.parseStr("s2ts2ts2l")!
                ]
                let tsumoPai = PaiMaster.pais["m2t"]!
                let agari = Agari(tsumoPai: tsumoPai, atama: atama, menzenMentsuList: menzenMentsuList,furoMentsuList:furoMentsuList)
                let kyoku = Kyoku()
                expect(YakuTanyao().isConcluded(agari,kyoku: kyoku)).to(beTruthy())
            }
            it("return false"){
                let atama = ToitsuMentsu(pai: PaiMaster.pais["j1t"]!)
                let menzenMentsuList:[Mentsu] = [
                    Mentsu.parseStr("m2tm3tm4t")!,
                    Mentsu.parseStr("s5ts3ts4t")!,
                    Mentsu.parseStr("p2tp3tp4t")!,
                    atama
                ]
                let furoMentsuList:[Mentsu] = [
                    Mentsu.parseStr("s2ts2ts2l")!
                ]
                let tsumoPai = PaiMaster.pais["m2t"]!
                let agari = Agari(tsumoPai: tsumoPai, atama: atama, menzenMentsuList: menzenMentsuList,furoMentsuList:furoMentsuList)
                let kyoku = Kyoku()
                expect(YakuTanyao().isConcluded(agari,kyoku: kyoku)).to(beFalsy())
            }
        }
        describe("PinfuYaku"){
            it("return true"){
                let atama = ToitsuMentsu(pai: PaiMaster.pais["j3t"]!)
                let menzenMentsuList:[Mentsu] = [
                    Mentsu.parseStr("m2tm3tm4t")!,
                    Mentsu.parseStr("s5ts3ts4t")!,
                    Mentsu.parseStr("p2tp3tp4t")!,
                    Mentsu.parseStr("p7tp8tp9t")!,
                    atama
                ]
                let furoMentsuList:[Mentsu] = [
                ]
                let tsumoPai = PaiMaster.pais["m2t"]!
                let agari = Agari(tsumoPai: tsumoPai, atama: atama, menzenMentsuList: menzenMentsuList,furoMentsuList:furoMentsuList)
                let kyoku = Kyoku()
                expect(YakuPinfu().isConcluded(agari,kyoku: kyoku)).to(beTruthy())
            }
            it("return false because there are not-shuntsu Mentsu"){
                let atama = ToitsuMentsu(pai: PaiMaster.pais["j3t"]!)
                let menzenMentsuList:[Mentsu] = [
                    Mentsu.parseStr("m2tm3tm4t")!,
                    Mentsu.parseStr("s5ts3ts4t")!,
                    Mentsu.parseStr("p2tp3tp4t")!,
                    Mentsu.parseStr("p9tp9tp9t")!,
                    atama
                ]
                let furoMentsuList:[Mentsu] = [
                ]
                let tsumoPai = PaiMaster.pais["m2t"]!
                let agari = Agari(tsumoPai: tsumoPai, atama: atama, menzenMentsuList: menzenMentsuList,furoMentsuList:furoMentsuList)
                let kyoku = Kyoku()
                expect(YakuPinfu().isConcluded(agari,kyoku: kyoku)).to(beFalsy())
            }
            it("return false because machi is canchan"){
                let atama = ToitsuMentsu(pai: PaiMaster.pais["j3t"]!)
                let menzenMentsuList:[Mentsu] = [
                    Mentsu.parseStr("m2tm3tm4t")!,
                    Mentsu.parseStr("s5ts3ts4t")!,
                    Mentsu.parseStr("p2tp3tp4t")!,
                    Mentsu.parseStr("p7tp8tp9t")!,
                    atama
                ]
                let furoMentsuList:[Mentsu] = [
                ]
                let tsumoPai = PaiMaster.pais["p3t"]!
                let agari = Agari(tsumoPai: tsumoPai, atama: atama, menzenMentsuList: menzenMentsuList,furoMentsuList:furoMentsuList)
                let kyoku = Kyoku()
                expect(YakuPinfu().isConcluded(agari,kyoku: kyoku)).to(beFalsy())
            }
            it("return false because atama is yakuhai"){
                let atama = ToitsuMentsu(pai: PaiMaster.pais["j1t"]!)
                let menzenMentsuList:[Mentsu] = [
                    Mentsu.parseStr("m2tm3tm4t")!,
                    Mentsu.parseStr("s5ts3ts4t")!,
                    Mentsu.parseStr("p2tp3tp4t")!,
                    Mentsu.parseStr("p7tp8tp9t")!,
                    atama
                ]
                let furoMentsuList:[Mentsu] = [
                ]
                let tsumoPai = PaiMaster.pais["m2t"]!
                let agari = Agari(tsumoPai: tsumoPai, atama: atama, menzenMentsuList: menzenMentsuList,furoMentsuList:furoMentsuList)
                let kyoku = Kyoku()
                expect(YakuPinfu().isConcluded(agari,kyoku: kyoku)).to(beFalsy())
            }
        }
        describe("YakuIipeikou"){
            it("return true"){
                let atama = ToitsuMentsu(pai: PaiMaster.pais["m2t"]!)
                let menzenMentsuList:[Mentsu] = [
                    Mentsu.parseStr("m2tm3tm4t")!,
                    Mentsu.parseStr("s5ts3ts4t")!,
                    Mentsu.parseStr("p2tp3tp4t")!,
                    Mentsu.parseStr("p3tp2tp4t")!,
                    atama
                ]
                let furoMentsuList:[Mentsu] = [
                ]
                let tsumoPai = PaiMaster.pais["m2t"]!
                let agari = Agari(tsumoPai: tsumoPai, atama: atama, menzenMentsuList: menzenMentsuList,furoMentsuList:furoMentsuList)
                let kyoku = Kyoku()
                expect(YakuIipeikou().isConcluded(agari,kyoku: kyoku)).to(beTruthy())
            }
            it("return false"){
                let atama = ToitsuMentsu(pai: PaiMaster.pais["m2t"]!)
                let menzenMentsuList:[Mentsu] = [
                    Mentsu.parseStr("m2tm3tm4t")!,
                    Mentsu.parseStr("s5ts3ts4t")!,
                    Mentsu.parseStr("p2tp3tp4t")!,
                    Mentsu.parseStr("p5tp3tp4t")!,
                    atama
                ]
                let furoMentsuList:[Mentsu] = [
                ]
                let tsumoPai = PaiMaster.pais["m2t"]!
                let agari = Agari(tsumoPai: tsumoPai, atama: atama, menzenMentsuList: menzenMentsuList,furoMentsuList:furoMentsuList)
                let kyoku = Kyoku()
                expect(YakuIipeikou().isConcluded(agari,kyoku: kyoku)).to(beFalsy())
            }
            it("return false when agari has furo"){
                let atama = ToitsuMentsu(pai: PaiMaster.pais["m2t"]!)
                let menzenMentsuList:[Mentsu] = [
                    Mentsu.parseStr("m2tm3tm4t")!,
                    Mentsu.parseStr("s5ts3ts4t")!,
                    Mentsu.parseStr("p2tp3tp4t")!,
                    atama
                ]
                let furoMentsuList:[Mentsu] = [
                    Mentsu.parseStr("p2tp3tp4l")!
                ]
                let tsumoPai = PaiMaster.pais["m2t"]!
                let agari = Agari(tsumoPai: tsumoPai, atama: atama, menzenMentsuList: menzenMentsuList,furoMentsuList:furoMentsuList)
                let kyoku = Kyoku()
                expect(YakuIipeikou().isConcluded(agari,kyoku: kyoku)).to(beFalsy())
            }
        }
        describe("YakuChanta"){
            it("return true"){
                let atama = ToitsuMentsu(pai: PaiMaster.pais["m1t"]!)
                let menzenMentsuList:[Mentsu] = [
                    Mentsu.parseStr("m1tm2tm3t")!,
                    Mentsu.parseStr("s8ts7ts9t")!,
                    Mentsu.parseStr("p1tp1tp1t")!,
                    atama
                ]
                let furoMentsuList:[Mentsu] = [
                    Mentsu.parseStr("j1tj1tj1l")!,
                ]
                let tsumoPai = PaiMaster.pais["m1t"]!
                let agari = Agari(tsumoPai: tsumoPai, atama: atama, menzenMentsuList: menzenMentsuList,furoMentsuList:furoMentsuList)
                let kyoku = Kyoku()
                expect(YakuChanta().isConcluded(agari,kyoku: kyoku)).to(beTruthy())
            }
            it("return false because agari is junchan"){
                let atama = ToitsuMentsu(pai: PaiMaster.pais["m1t"]!)
                let menzenMentsuList:[Mentsu] = [
                    Mentsu.parseStr("m1tm2tm3t")!,
                    Mentsu.parseStr("s8ts7ts9t")!,
                    Mentsu.parseStr("p1tp1tp1t")!,
                    atama
                ]
                let furoMentsuList:[Mentsu] = [
                    Mentsu.parseStr("s1ts1ts1l")!,
                ]
                let tsumoPai = PaiMaster.pais["m1t"]!
                let agari = Agari(tsumoPai: tsumoPai, atama: atama, menzenMentsuList: menzenMentsuList,furoMentsuList:furoMentsuList)
                let kyoku = Kyoku()
                expect(YakuChanta().isConcluded(agari,kyoku: kyoku)).to(beFalsy())
            }
            it("return false because agari is honroutou"){
                let atama = ToitsuMentsu(pai: PaiMaster.pais["m9t"]!)
                let menzenMentsuList:[Mentsu] = [
                    Mentsu.parseStr("m1tm1tm1t")!,
                    Mentsu.parseStr("s9ts9ts9t")!,
                    Mentsu.parseStr("p1tp1tp1t")!,
                    atama
                ]
                let furoMentsuList:[Mentsu] = [
                    Mentsu.parseStr("j1tj1tj1l")!,
                ]
                let tsumoPai = PaiMaster.pais["m9t"]!
                let agari = Agari(tsumoPai: tsumoPai, atama: atama, menzenMentsuList: menzenMentsuList,furoMentsuList:furoMentsuList)
                let kyoku = Kyoku()
                expect(YakuChanta().isConcluded(agari,kyoku: kyoku)).to(beFalsy())
            }
        }
        describe("YakuIkkitsukan"){
            it("return true"){
                let atama = ToitsuMentsu(pai: PaiMaster.pais["m1t"]!)
                let menzenMentsuList:[Mentsu] = [
                    Mentsu.parseStr("m1tm2tm3t")!,
                    Mentsu.parseStr("m4tm5tm6t")!,
                    Mentsu.parseStr("p1tp1tp1t")!,
                    atama
                ]
                let furoMentsuList:[Mentsu] = [
                    Mentsu.parseStr("m7tm8tm9l")!,
                ]
                let tsumoPai = PaiMaster.pais["m1t"]!
                let agari = Agari(tsumoPai: tsumoPai, atama: atama, menzenMentsuList: menzenMentsuList,furoMentsuList:furoMentsuList)
                let kyoku = Kyoku()
                expect(YakuIkkitsukan().isConcluded(agari,kyoku: kyoku)).to(beTruthy())
            }
            it("return false"){
                let atama = ToitsuMentsu(pai: PaiMaster.pais["m1t"]!)
                let menzenMentsuList:[Mentsu] = [
                    Mentsu.parseStr("m1tm2tm3t")!,
                    Mentsu.parseStr("s8ts7ts9t")!,
                    Mentsu.parseStr("p1tp1tp1t")!,
                    atama
                ]
                let furoMentsuList:[Mentsu] = [
                    Mentsu.parseStr("s1ts1ts1l")!,
                ]
                let tsumoPai = PaiMaster.pais["m1t"]!
                let agari = Agari(tsumoPai: tsumoPai, atama: atama, menzenMentsuList: menzenMentsuList,furoMentsuList:furoMentsuList)
                let kyoku = Kyoku()
                expect(YakuIkkitsukan().isConcluded(agari,kyoku: kyoku)).to(beFalsy())
            }
        }
        describe("YakuSansyoku"){
            it("return true"){
                let atama = ToitsuMentsu(pai: PaiMaster.pais["m1t"]!)
                let menzenMentsuList:[Mentsu] = [
                    Mentsu.parseStr("m1tm2tm3t")!,
                    Mentsu.parseStr("s1ts2ts3t")!,
                    Mentsu.parseStr("p1tp1tp1t")!,
                    atama
                ]
                let furoMentsuList:[Mentsu] = [
                    Mentsu.parseStr("p1tp2tp3t")!,
                ]
                let tsumoPai = PaiMaster.pais["m1t"]!
                let agari = Agari(tsumoPai: tsumoPai, atama: atama, menzenMentsuList: menzenMentsuList,furoMentsuList:furoMentsuList)
                let kyoku = Kyoku()
                expect(YakuSansyoku().isConcluded(agari,kyoku: kyoku)).to(beTruthy())
            }
            it("return false because agari is 2 syoku"){
                let atama = ToitsuMentsu(pai: PaiMaster.pais["m1t"]!)
                let menzenMentsuList:[Mentsu] = [
                    Mentsu.parseStr("m1tm2tm3t")!,
                    Mentsu.parseStr("s1ts2ts3t")!,
                    Mentsu.parseStr("p1tp1tp1t")!,
                    atama
                ]
                let furoMentsuList:[Mentsu] = [
                    Mentsu.parseStr("s1ts1ts1l")!,
                ]
                let tsumoPai = PaiMaster.pais["m1t"]!
                let agari = Agari(tsumoPai: tsumoPai, atama: atama, menzenMentsuList: menzenMentsuList,furoMentsuList:furoMentsuList)
                let kyoku = Kyoku()
                expect(YakuSansyoku().isConcluded(agari,kyoku: kyoku)).to(beFalsy())
            }
        }
    }
}

