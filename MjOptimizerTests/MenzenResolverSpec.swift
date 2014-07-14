//
//  MenzenResolverSpec.swift
//  MjOptimizer
//
//  Created by fetaro on 2014/07/02.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

import MjOptimizer
import Quick
import Nimble

class MenzenResolverSpec: QuickSpec {
    override func spec() {
        describe("resolve"){
            it("works1"){
                var paiList : Pai[] = Pai.parseList("m1tm2tm3tm4tm5tm6tm7tm8tm9tm9tm9tm9tj1tj1t")!
                var agariList :Agari[] = MenzenResolver.resolve(paiList)!
                expect(agariList.count).to.equal(1)
                expect(agariList[0].atama.toString()).to.equal("トイツ:j1")
                expect(agariList[0].mentsuList.get(0).toString()).to.equal("シュンツ:m1m2m3")
                expect(agariList[0].mentsuList.get(1).toString()).to.equal("シュンツ:m4m5m6")
                expect(agariList[0].mentsuList.get(2).toString()).to.equal("シュンツ:m7m8m9")
                expect(agariList[0].mentsuList.get(3).toString()).to.equal("アンコウ:m9")
                expect(agariList[0].mentsuList.get(4).toString()).to.equal("トイツ:j1")
            }
            it("works2"){
                var paiList : Pai[] = Pai.parseList("m1tm2tm3tm4tm5tm6tm7tm8tm9tm9tm9tm9tj1tj1t")!
                var agariList :Agari[] = MenzenResolver.resolve(paiList)!
                expect(agariList.count).to.equal(1)
                expect(agariList[0].atama.toString()).to.equal("トイツ:j1")
            }
        }
        describe("makeMentsuList"){
            it("return 1 ankou"){
                let pnl : PaiNumList = PaiNumList(paiList: Pai.parseList("m1tm1tm1t")!)
                var mmr : MakeMentsuResult = MenzenResolver.makeMentsuList(pnl)
                switch mmr{
                case let .SUCCESS(mentsuListList):
                    expect(mentsuListList.count).to.equal(1)
                    expect(mentsuListList[0].toString()).to.equal("面子リスト:アンコウ:m1")
                default:
                    //この分岐にきたらテスト失敗
                    expect(false).to.beTrue()
                }
            }
            it("return 1 shuntsu"){
                let pnl : PaiNumList = PaiNumList(paiList: Pai.parseList("m1tm2tm3t")!)
                var mmr : MakeMentsuResult = MenzenResolver.makeMentsuList(pnl)
                switch mmr{
                case let .SUCCESS(mentsuListList):
                    expect(mentsuListList.count).to.equal(1)
                    expect(mentsuListList[0].toString()).to.equal("面子リスト:シュンツ:m1m2m3")
                default:
                    //この分岐にきたらテスト失敗
                    expect(false).to.beTrue()
                }
            }
            it("return 2 ankou"){
                let pnl : PaiNumList = PaiNumList(paiList: Pai.parseList("m1tm1tm1tm2tm2tm2t")!)
                var mmr : MakeMentsuResult = MenzenResolver.makeMentsuList(pnl)
                switch mmr{
                case let .SUCCESS(mentsuListList):
                    expect(mentsuListList.count).to.equal(1)
                    expect(mentsuListList[0].toString()).to.equal("面子リスト:アンコウ:m1,アンコウ:m2")
                default:
                    //この分岐にきたらテスト失敗
                    expect(false).to.beTrue()
                }
            }
            it("return 1 shuntsu 1 ankou"){
                let pnl : PaiNumList = PaiNumList(paiList: Pai.parseList("m1tm1tm1tm1tm2tm3t")!)
                var mmr : MakeMentsuResult = MenzenResolver.makeMentsuList(pnl)
                switch mmr{
                case let .SUCCESS(mentsuListList):
                    //TODO　重複を削除して結果を１つにすべき
                    expect(mentsuListList.count).to.equal(2)
                    expect(mentsuListList[0].toString()).to.equal("面子リスト:シュンツ:m1m2m3,アンコウ:m1")
                    expect(mentsuListList[1].toString()).to.equal("面子リスト:シュンツ:m1m2m3,アンコウ:m1")
                default:
                    //この分岐にきたらテスト失敗
                    expect(false).to.beTrue()
                }
            }
            it("return 2 mentsu list"){
                let pnl : PaiNumList = PaiNumList(paiList: Pai.parseList("m1tm1tm1tm2tm2tm2tm3tm3tm3t")!)
                var mmr : MakeMentsuResult = MenzenResolver.makeMentsuList(pnl)
                switch mmr{
                case let .SUCCESS(mentsuListList):
                    expect(mentsuListList.count).to.equal(2)
                    expect(mentsuListList[0].toString()).to.equal("面子リスト:アンコウ:m1,アンコウ:m2,アンコウ:m3")
                    expect(mentsuListList[1].toString()).to.equal("面子リスト:シュンツ:m1m2m3,シュンツ:m1m2m3,シュンツ:m1m2m3")
                default:
                    //この分岐にきたらテスト失敗
                    expect(false).to.beTrue()
                }
            }
            it("return 2 mentsu list"){
                let pnl : PaiNumList = PaiNumList(paiList: Pai.parseList("m1tm1tm1tm1t2tm2tm2tm2tm3tm3tm3tm3t")!)
                var mmr : MakeMentsuResult = MenzenResolver.makeMentsuList(pnl)
                switch mmr{
                case let .SUCCESS(mentsuListList):
                    expect(mentsuListList.count).to.equal(2)
                    expect(mentsuListList[0].toString()).to.equal("面子リスト:シュンツ:m1m2m3,アンコウ:m3,アンコウ:m2,アンコウ:m1")
                    expect(mentsuListList[1].toString()).to.equal("面子リスト:シュンツ:m1m2m3,シュンツ:m1m2m3,シュンツ:m1m2m3,シュンツ:m1m2m3")
                default:
                    //この分岐にきたらテスト失敗
                    expect(false).to.beTrue()
                }
            }
            it("return MakeMentsuResult.CONFLICT"){
                let pnl : PaiNumList = PaiNumList(paiList: Pai.parseList("m1tm2tm3tm4tm5tm6tm7tm8tm9tm9tj1tj1t")!)
                var mmr : MakeMentsuResult = MenzenResolver.makeMentsuList(pnl)
                switch mmr{
                case let .CONFLICT:
                    expect(true).to.beTrue()
                default:
                    //この分岐にきたらテスト失敗
                    expect(false).to.beTrue()
                }
            }
            it("return MakeMentsuResult.FINISH"){
                let pnl : PaiNumList = PaiNumList(paiList: Pai.parseList("")!)
                var mmr : MakeMentsuResult = MenzenResolver.makeMentsuList(pnl)
                switch mmr{
                case let .FINISH:
                    expect(true).to.beTrue()
                default:
                    //この分岐にきたらテスト失敗
                    expect(false).to.beTrue()
                }
            }
            it("return MakeMentsuResult.ERROR"){
                let pnl : PaiNumList = PaiNumList(paiList: Pai.parseList("m1tm2t")!)
                var mmr : MakeMentsuResult = MenzenResolver.makeMentsuList(pnl)
                switch mmr{
                case let .ERROR(msg):
                    expect(true).to.beTrue()
                default:
                    //この分岐にきたらテスト失敗
                    expect(false).to.beTrue()
                }
            }
        }
    }
}