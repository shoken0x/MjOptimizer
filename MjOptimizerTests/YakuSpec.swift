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
                let atama = ToitsuMentsu(pai: PaiMaster.m2)
                let menzenMentsuList:[Mentsu] = [
                    Mentsu.parseStr("m2tm3tm4t")!,
                    Mentsu.parseStr("s5ts3ts4t")!,
                    Mentsu.parseStr("p2tp3tp4t")!,
                    atama
                ]
                let furoMentsuList:[Mentsu] = [
                    Mentsu.parseStr("s2ts2ts2l")!
                ]
                let tsumoPai = PaiMaster.m2
                let agari = Agari(tsumoPai: tsumoPai, atama: atama, menzenMentsuList: menzenMentsuList,furoMentsuList:furoMentsuList)
                let kyoku = Kyoku()
                expect(YakuTanyao().isConcluded(agari,kyoku: kyoku)).to(beTruthy())
            }
            it("return false"){
                let atama = ToitsuMentsu(pai: PaiMaster.j1)
                let menzenMentsuList:[Mentsu] = [
                    Mentsu.parseStr("m2tm3tm4t")!,
                    Mentsu.parseStr("s5ts3ts4t")!,
                    Mentsu.parseStr("p2tp3tp4t")!,
                    atama
                ]
                let furoMentsuList:[Mentsu] = [
                    Mentsu.parseStr("s2ts2ts2l")!
                ]
                let tsumoPai = PaiMaster.m2
                let agari = Agari(tsumoPai: tsumoPai, atama: atama, menzenMentsuList: menzenMentsuList,furoMentsuList:furoMentsuList)
                let kyoku = Kyoku()
                expect(YakuTanyao().isConcluded(agari,kyoku: kyoku)).to(beFalsy())
            }
        }
        describe("PinfuYaku"){
            it("return true"){
                let atama = ToitsuMentsu(pai: PaiMaster.sha)
                let menzenMentsuList:[Mentsu] = [
                    Mentsu.parseStr("m2tm3tm4t")!,
                    Mentsu.parseStr("s5ts3ts4t")!,
                    Mentsu.parseStr("p2tp3tp4t")!,
                    Mentsu.parseStr("p7tp8tp9t")!,
                    atama
                ]
                let furoMentsuList:[Mentsu] = [
                ]
                let tsumoPai = PaiMaster.m2
                let agari = Agari(tsumoPai: tsumoPai, atama: atama, menzenMentsuList: menzenMentsuList,furoMentsuList:furoMentsuList)
                let kyoku = Kyoku()
                expect(YakuPinfu().isConcluded(agari,kyoku: kyoku)).to(beTruthy())
            }
            it("return false because there are not-shuntsu Mentsu"){
                let atama = ToitsuMentsu(pai: PaiMaster.sha)
                let menzenMentsuList:[Mentsu] = [
                    Mentsu.parseStr("m2tm3tm4t")!,
                    Mentsu.parseStr("s5ts3ts4t")!,
                    Mentsu.parseStr("p2tp3tp4t")!,
                    Mentsu.parseStr("p9tp9tp9t")!,
                    atama
                ]
                let furoMentsuList:[Mentsu] = [
                ]
                let tsumoPai = PaiMaster.m2
                let agari = Agari(tsumoPai: tsumoPai, atama: atama, menzenMentsuList: menzenMentsuList,furoMentsuList:furoMentsuList)
                let kyoku = Kyoku()
                expect(YakuPinfu().isConcluded(agari,kyoku: kyoku)).to(beFalsy())
            }
            it("return false because machi is canchan"){
                let atama = ToitsuMentsu(pai: PaiMaster.sha)
                let menzenMentsuList:[Mentsu] = [
                    Mentsu.parseStr("m2tm3tm4t")!,
                    Mentsu.parseStr("s5ts3ts4t")!,
                    Mentsu.parseStr("p2tp3tp4t")!,
                    Mentsu.parseStr("p7tp8tp9t")!,
                    atama
                ]
                let furoMentsuList:[Mentsu] = [
                ]
                let tsumoPai = PaiMaster.p3
                let agari = Agari(tsumoPai: tsumoPai, atama: atama, menzenMentsuList: menzenMentsuList,furoMentsuList:furoMentsuList)
                let kyoku = Kyoku()
                expect(YakuPinfu().isConcluded(agari,kyoku: kyoku)).to(beFalsy())
            }
            it("return false because atama is yakuhai"){
                let atama = ToitsuMentsu(pai: PaiMaster.ton)
                let menzenMentsuList:[Mentsu] = [
                    Mentsu.parseStr("m2tm3tm4t")!,
                    Mentsu.parseStr("s5ts3ts4t")!,
                    Mentsu.parseStr("p2tp3tp4t")!,
                    Mentsu.parseStr("p7tp8tp9t")!,
                    atama
                ]
                let furoMentsuList:[Mentsu] = [
                ]
                let tsumoPai = PaiMaster.m2
                let agari = Agari(tsumoPai: tsumoPai, atama: atama, menzenMentsuList: menzenMentsuList,furoMentsuList:furoMentsuList)
                let kyoku = Kyoku()
                expect(YakuPinfu().isConcluded(agari,kyoku: kyoku)).to(beFalsy())
            }
        }
    }
}

