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
                let atama = ToitsuMentsu(pai: Pai.parse("m2t")!)
                let menzenMentsuList:[Mentsu] = [
                    Mentsu.parseStr("m2tm3tm4t")!,
                    Mentsu.parseStr("s5ts3ts4t")!,
                    Mentsu.parseStr("p2tp3tp4t")!,
                    atama
                ]
                let furoMentsuList:[Mentsu] = [
                    Mentsu.parseStr("s2ts2ts2l")!
                ]
                let tsumoPai = Pai.parse("m2t")!
                let agari = Agari(tsumoPai: tsumoPai, atama: atama, menzenMentsuList: menzenMentsuList,furoMentsuList:furoMentsuList)
                expect(YakuTanyao().isConcluded(agari)).to(beTruthy())
            }
            it("return false"){
                let atama = ToitsuMentsu(pai: Pai.parse("j1t")!)
                let menzenMentsuList:[Mentsu] = [
                    Mentsu.parseStr("m2tm3tm4t")!,
                    Mentsu.parseStr("s5ts3ts4t")!,
                    Mentsu.parseStr("p2tp3tp4t")!,
                    atama
                ]
                let furoMentsuList:[Mentsu] = [
                    Mentsu.parseStr("s2ts2ts2l")!
                ]
                let tsumoPai = Pai.parse("m2t")!
                let agari = Agari(tsumoPai: tsumoPai, atama: atama, menzenMentsuList: menzenMentsuList,furoMentsuList:furoMentsuList)
                expect(YakuTanyao().isConcluded(agari)).to(beFalsy())
            }
        }
    }
}

