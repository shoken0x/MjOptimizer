import MjOptimizer
import Quick
import Nimble

class PaiNumListSpec: QuickSpec {
    override func spec() {
        describe("init"){
            it("works"){
                var pnl : PaiNumList = PaiNumList(paiList: Pai.parseList("m1tm1tm2tm3t")!)
                expect(pnl.list[0].toString()).to(equal("m1=2"))
                expect(pnl.list[1].toString()).to(equal("m2=1"))
                expect(pnl.list[2].toString()).to(equal("m3=1"))
                expect(pnl.list[3].toString()).to(equal("m4=0"))
                expect(pnl.count()).to(equal(4))
            }
        }
        describe("remove"){
            it("works"){
                var pnl : PaiNumList = PaiNumList(paiList: Pai.parseList("m1tm1tm2tm3t")!)
                var pnl2 : PaiNumList = pnl.remove(Pai.parse("m1t")!,num:2)!
                expect(pnl2.list[0].toString()).to(equal("m1=0"))
                expect(pnl.list[0].toString()).to(equal("m1=2"))
            }
        }
        describe("includeAnkouOf"){
            it("works"){
                var pnl : PaiNumList = PaiNumList(paiList: Pai.parseList("m1tm1tm1tm2tm3t")!)
                expect(pnl.includeAnkouOf(Pai.parse("m1t")!)).to(beTruthy())
                expect(pnl.includeAnkouOf(Pai.parse("m2t")!)).to(beFalsy())
            }
        }
        describe("includeShuntsuFrom"){
            it("works"){
                var pnl : PaiNumList = PaiNumList(paiList: Pai.parseList("m1tm1tm2tm3t")!)
                expect(pnl.includeShuntsuFrom(Pai.parse("m1t")!)).to(beTruthy())
                expect(pnl.includeShuntsuFrom(Pai.parse("m2t")!)).to(beFalsy())
            }
        }
        describe("removeAnkouOf"){
            it("works"){
                var pnl : PaiNumList = PaiNumList(paiList: Pai.parseList("m1tm1tm1tm2tm3t")!)
                var pnl2 : PaiNumList = pnl.removeAnkouOf(Pai.parse("m1t")!)!
                expect(pnl2.getNum(Pai.parse("m1t")!)).to(equal(0))
                expect(pnl2.getNum(Pai.parse("m2t")!)).to(equal(1))
                expect(pnl2.getNum(Pai.parse("m3t")!)).to(equal(1))
            }
            it("returns nil"){
                var pnl : PaiNumList = PaiNumList(paiList: Pai.parseList("m1tm1tm2tm3t")!)
                expect(pnl.removeAnkouOf(Pai.parse("m1t")!)).to(beNil())
            }
        }
        describe("removeShuntsuFrom"){
            it("works"){
                var pnl : PaiNumList = PaiNumList(paiList: Pai.parseList("m7tm8tm9t")!)
                var pnl2 : PaiNumList = pnl.removeShuntsuFrom(Pai.parse("m7t")!)!
                expect(pnl2.count()).to(equal(0))
            }
            it("works2"){
                var pnl : PaiNumList = PaiNumList(paiList: Pai.parseList("m1tm1tm2tm3t")!)
                var pnl2 : PaiNumList = pnl.removeShuntsuFrom(Pai.parse("m1t")!)!
                expect(pnl2.getNum(Pai.parse("m1t")!)).to(equal(1))
                expect(pnl2.getNum(Pai.parse("m2t")!)).to(equal(0))
                expect(pnl2.getNum(Pai.parse("m3t")!)).to(equal(0))
            }
            it("returns nil"){
                var pnl : PaiNumList = PaiNumList(paiList: Pai.parseList("m8tm9ts1tp1t")!)
                expect(pnl.removeShuntsuFrom(Pai.parse("m8t")!)).to(beNil())
            }
        }
    }
}