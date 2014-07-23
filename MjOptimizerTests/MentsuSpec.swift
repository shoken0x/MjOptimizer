//
//  MentsuSpec.swift
//  MjOptimizer
//
//  Created by fetaro on 2014/06/23.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

import MjOptimizer
import Quick
import Nimble

class MentsuSpec: QuickSpec {
    override func spec() {
        describe("=="){
            it("returns true when compare same toitsu mentsu"){
                var m1:Mentsu = ToitsuMentsu(pai: Pai.parse("m1t")!)
                var m2:Mentsu = ToitsuMentsu(pai: Pai.parse("m1t")!)
                expect(m1 == m2).to.beTrue()
            }
            it("returns true when compare same shuntsu mentsu"){
                var m1:Mentsu = ShuntsuMentsu(paiList: Pai.parseList("m1tm2tm3t")!)
                var m2:Mentsu = ShuntsuMentsu(paiList: Pai.parseList("m1tm2tm3t")!)
                expect(m1 == m2).to.beTrue()
            }
            it("returns true when compare different toitsu mentsu"){
                var m1:Mentsu = ToitsuMentsu(pai: Pai.parse("m1t")!)
                var m2:Mentsu = ToitsuMentsu(pai: Pai.parse("m2t")!)
                expect(m1 == m2).to.beFalse()
            }
            it("returns false when compare different shuntsu mentsu"){
                var m1:Mentsu = ShuntsuMentsu(paiList: Pai.parseList("m1tm2tm3t")!)
                var m2:Mentsu = ShuntsuMentsu(paiList: Pai.parseList("m2tm3tm4t")!)
                expect(m1 == m2).to.beFalse()
            }
            it("returns false when compare different type mentsu"){
                var m1:Mentsu = ToitsuMentsu(pai: Pai.parse("m1t")!)
                var m2:Mentsu = ShuntsuMentsu(paiList: Pai.parseList("m2tm3tm4t")!)
                expect(m1 == m2).to.beFalse()
            }
        }
        describe("<"){
            it("returns true when compare different toitsu mentsu"){
                var m1:Mentsu = ToitsuMentsu(pai: Pai.parse("m1t")!)
                var m2:Mentsu = ToitsuMentsu(pai: Pai.parse("m2t")!)
                expect(m1 < m2).to.beTrue()
            }
            it("returns true when compare different type mentsu"){
                var m1:Mentsu = ToitsuMentsu(pai: Pai.parse("m1t")!)
                var m2:Mentsu = ShuntsuMentsu(paiList: Pai.parseList("m1tm2tm3t")!)
                expect(m1 < m2).to.beTrue()
            }
        }
        describe("MentsuFactory.createMentsu"){
            it("makes シュンツ"){
                var pl:Pai[] = Pai.parseList("m1tm2tm3t")!
                var m:Mentsu = MentsuFactory.createMentsu(pl)!
                expect(m.toString()).to.equal("シュンツ:m1m2m3")
                expect(m.isFuro()).to.beFalse()
                expect(m.size()).to.equal(3)
            }
            it("makes シュンツ2"){
                var pl:Pai[] = Pai.parseList("m2tm1tm3t")!
                var m:Mentsu = MentsuFactory.createMentsu(pl)!
                expect(m.toString()).to.equal("シュンツ:m1m2m3")
                expect(m.isFuro()).to.beFalse()
                expect(m.size()).to.equal(3)
            }
            it("makes チー"){
                var pl:Pai[] = Pai.parseList("m1tm2lm3t")!
                var m:Mentsu = MentsuFactory.createMentsu(pl)!
                expect(m.toString()).to.equal("チー:m1m2m3")
                expect(m.isFuro()).to.beTrue()
                expect(m.size()).to.equal(3)
            }
            it("makes トイツ"){
                var pl:Pai[] = Pai.parseList("m1tm1t")!
                var m:Mentsu = MentsuFactory.createMentsu(pl)!
                expect(m.toString()).to.equal("トイツ:m1")
                expect(m.isFuro()).to.beFalse()
                expect(m.size()).to.equal(2)
            }
            it("makes アンコウ"){
                var pl:Pai[] = Pai.parseList("m1tm1tm1t")!
                var m:Mentsu = MentsuFactory.createMentsu(pl)!
                expect(m.toString()).to.equal("アンコウ:m1")
                expect(m.isFuro()).to.beFalse()
                expect(m.size()).to.equal(3)
            }
            it("makes ポン"){
                var pl:Pai[] = Pai.parseList("m1tm1tm1l")!
                var m:Mentsu = MentsuFactory.createMentsu(pl)!
                expect(m.toString()).to.equal("ポン:m1")
                expect(m.isFuro()).to.beTrue()
                expect(m.size()).to.equal(3)
            }
            it("makes アンカン"){
                var pl:Pai[] = Pai.parseList("m1tm1tm1tm1t")!
                var m:Mentsu = MentsuFactory.createMentsu(pl)!
                expect(m.toString()).to.equal("アンカン:m1")
                expect(m.isFuro()).to.beFalse()
                expect(m.size()).to.equal(4)
            }
            it("makes ミンカン"){
                var pl:Pai[] = Pai.parseList("m1tm1tm1tm1l")!
                var m:Mentsu = MentsuFactory.createMentsu(pl)!
                expect(m.toString()).to.equal("ミンカン:m1")
                expect(m.isFuro()).to.beTrue()
                expect(m.size()).to.equal(4)
            }
            it("makes 特殊面子"){
                var pl:Pai[] = Pai.parseList("m1tm9ts1ts9tp1tp9tj1tj2tj3tj4tj5tj6tj7tj7t")!
                var m:Mentsu = MentsuFactory.createMentsu(pl)!
                expect(m.isFuro()).to.beFalse()
                expect(m.size()).to.equal(14)
           }
            it("return nil if invalid mentsu"){
                var pl:Pai[] = Pai.parseList("m1tm2tm5t")!
                expect(MentsuFactory.createMentsu(pl) == nil).to.beTrue()
            }
        }
        describe("MentsuFactory.isChi"){
            it("workds"){
                expect(MentsuFactory.isChi(Pai.parseList("m1tm2tm3l")!)).to.beTrue()
                expect(MentsuFactory.isChi(Pai.parseList("m1lm2tm3t")!)).to.beTrue()
                expect(MentsuFactory.isChi(Pai.parseList("m2tm1lm3t")!)).to.beTrue()
                expect(MentsuFactory.isChi(Pai.parseList("m4lm2tm3t")!)).to.beTrue()
                
                expect(MentsuFactory.isChi(Pai.parseList("m1lm2lm3t")!)).to.beFalse()
                expect(MentsuFactory.isChi(Pai.parseList("m1lm2lm3l")!)).to.beFalse()
                expect(MentsuFactory.isChi(Pai.parseList("m1ts2tm3l")!)).to.beFalse()
                expect(MentsuFactory.isChi(Pai.parseList("j1tj2tj3l")!)).to.beFalse()
                expect(MentsuFactory.isChi(Pai.parseList("r1tr2tr3l")!)).to.beFalse()
                expect(MentsuFactory.isChi(Pai.parseList("s1ts2tm3l")!)).to.beFalse()
            }
        }
    }
}
