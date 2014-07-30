//
//  AgariSpec.swift
//  MjOptimizer
//
//  Created by fetaro on 2014/07/30.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

import MjOptimizer
import Quick
import Nimble

class AgariSpec: QuickSpec {
    override func spec() {
        describe("isRyanmenMachi"){
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
                expect(agari.isRyanmenMachi()).to(beTruthy())
            }
            it("return false"){
                let atama = ToitsuMentsu(pai: PaiMaster.m2)
                let menzenMentsuList:[Mentsu] = [
                    Mentsu.parseStr("m2tm3tm4t")!,
                    Mentsu.parseStr("m3tm3tm3t")!,
                    Mentsu.parseStr("p2tp3tp4t")!,
                    atama
                ]
                let furoMentsuList:[Mentsu] = [
                    Mentsu.parseStr("s2ts2ts2l")!
                ]
                let tsumoPai = PaiMaster.m3
                let agari = Agari(tsumoPai: tsumoPai, atama: atama, menzenMentsuList: menzenMentsuList,furoMentsuList:furoMentsuList)
                expect(agari.isRyanmenMachi()).to(beFalsy())
            }
        }
    }
}

