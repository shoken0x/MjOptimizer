//
//  PointCalculatorSpec.swift
//  MjOptimizer
//
//  Created by fetaro on 2014/08/08.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

import MjOptimizer
import Quick
import Nimble

class PointCalculatorSpec: QuickSpec {
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
                expect(PointCalculator.calcFuNum(agari,kyoku:kyoku)).to(equal(20))
            }
        }
        describe("calcPoint"){
            it("returns child ron"){
                var s : Score = PointCalculator.calcPoint(30,hanNum:3,isParent:false,isTsumo:false)
                expect(s.c).to(equal(0))
                expect(s.p).to(equal(0))
                expect(s.t).to(equal(3900))
                s = PointCalculator.calcPoint(70,hanNum:2,isParent:false,isTsumo:false)
                expect(s.c).to(equal(0))
                expect(s.p).to(equal(0))
                expect(s.t).to(equal(4500))
                s = PointCalculator.calcPoint(25,hanNum:2,isParent:false,isTsumo:false)
                expect(s.c).to(equal(0))
                expect(s.p).to(equal(0))
                expect(s.t).to(equal(1600))
                expect(s.m).to(equal(0.0))
                s = PointCalculator.calcPoint(30,hanNum:4,isParent:false,isTsumo:false)
                expect(s.c).to(equal(0))
                expect(s.p).to(equal(0))
                expect(s.t).to(equal(7700))
                s = PointCalculator.calcPoint(70,hanNum:3,isParent:false,isTsumo:false)
                expect(s.c).to(equal(0))
                expect(s.p).to(equal(0))
                expect(s.t).to(equal(8000))
                expect(s.m).to(equal(1.0))
                s = PointCalculator.calcPoint(70,hanNum:6,isParent:false,isTsumo:false)
                expect(s.c).to(equal(0))
                expect(s.p).to(equal(0))
                expect(s.t).to(equal(12000))
                expect(s.m).to(equal(1.5))
            }
            it("returns child tsumo"){
                var s : Score = PointCalculator.calcPoint(30,hanNum:3,isParent:false,isTsumo:true)
                expect(s.c).to(equal(1000))
                expect(s.p).to(equal(2000))
                expect(s.t).to(equal(4000))
                s = PointCalculator.calcPoint(70,hanNum:2,isParent:false,isTsumo:true)
                expect(s.c).to(equal(1200))
                expect(s.p).to(equal(2300))
                expect(s.t).to(equal(4700))
                s = PointCalculator.calcPoint(25,hanNum:2,isParent:false,isTsumo:true)
                expect(s.c).to(equal(400))
                expect(s.p).to(equal(800))
                expect(s.t).to(equal(1600))
                s = PointCalculator.calcPoint(30,hanNum:4,isParent:false,isTsumo:true)
                expect(s.c).to(equal(2000))
                expect(s.p).to(equal(3900))
                expect(s.t).to(equal(7900))
                s = PointCalculator.calcPoint(70,hanNum:3,isParent:false,isTsumo:true)
                expect(s.c).to(equal(2000))
                expect(s.p).to(equal(4000))
                expect(s.t).to(equal(8000))
                expect(s.m).to(equal(1.0))
                s = PointCalculator.calcPoint(70,hanNum:6,isParent:false,isTsumo:true)
                expect(s.c).to(equal(3000))
                expect(s.p).to(equal(6000))
                expect(s.t).to(equal(12000))
                expect(s.m).to(equal(1.5))
            }
            it("returns parent true"){
                var s : Score = PointCalculator.calcPoint(30,hanNum:3,isParent:true,isTsumo:false)
                expect(s.c).to(equal(0))
                expect(s.p).to(equal(0))
                expect(s.t).to(equal(5800))
                s = PointCalculator.calcPoint(70,hanNum:2,isParent:true,isTsumo:false)
                expect(s.c).to(equal(0))
                expect(s.p).to(equal(0))
                expect(s.t).to(equal(6800))
                s = PointCalculator.calcPoint(25,hanNum:2,isParent:true,isTsumo:false)
                expect(s.c).to(equal(0))
                expect(s.p).to(equal(0))
                expect(s.t).to(equal(2400))
                s = PointCalculator.calcPoint(30,hanNum:4,isParent:true,isTsumo:false)
                expect(s.c).to(equal(0))
                expect(s.p).to(equal(0))
                expect(s.t).to(equal(11600))
                s = PointCalculator.calcPoint(70,hanNum:3,isParent:true,isTsumo:false)
                expect(s.c).to(equal(0))
                expect(s.p).to(equal(0))
                expect(s.t).to(equal(12000))
                expect(s.m).to(equal(1.0))
                s = PointCalculator.calcPoint(70,hanNum:6,isParent:true,isTsumo:false)
                expect(s.c).to(equal(0))
                expect(s.p).to(equal(0))
                expect(s.t).to(equal(18000))
                expect(s.m).to(equal(1.5))
            }
            it("returns"){
                var s : Score = PointCalculator.calcPoint(30,hanNum:3,isParent:true,isTsumo:true)
                expect(s.c).to(equal(2000))
                expect(s.p).to(equal(0))
                expect(s.t).to(equal(6000))
                s = PointCalculator.calcPoint(70,hanNum:2,isParent:true,isTsumo:true)
                expect(s.c).to(equal(2300))
                expect(s.p).to(equal(0))
                expect(s.t).to(equal(6900))
                s = PointCalculator.calcPoint(25,hanNum:2,isParent:true,isTsumo:true)
                expect(s.c).to(equal(800))
                expect(s.p).to(equal(0))
                expect(s.t).to(equal(2400))
                s = PointCalculator.calcPoint(30,hanNum:4,isParent:true,isTsumo:true)
                expect(s.c).to(equal(3900))
                expect(s.p).to(equal(0))
                expect(s.t).to(equal(11700))
                s = PointCalculator.calcPoint(70,hanNum:3,isParent:true,isTsumo:true)
                expect(s.c).to(equal(4000))
                expect(s.p).to(equal(0))
                expect(s.t).to(equal(12000))
                expect(s.m).to(equal(1.0))
                s = PointCalculator.calcPoint(70,hanNum:6,isParent:true,isTsumo:true)
                expect(s.c).to(equal(6000))
                expect(s.p).to(equal(0))
                expect(s.t).to(equal(18000))
                expect(s.m).to(equal(1.5))
            }
        }
    }
}