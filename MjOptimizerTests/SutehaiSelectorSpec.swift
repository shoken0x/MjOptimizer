//
//  SutehaiSelectorSpec.swift
//  MjOptimizer
//
//  Created by fetaro on 2014/06/21.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

import MjOptimizer
import Quick
import Nimble


class SutehaiSelectorSpec: QuickSpec {
    override func spec() {
        describe("SutehaiSelectorSpec") {
            beforeEach { }
            describe("#select") {
//                it("#agari") {
//                    let paiList:Pai[] = Pai.parseList("m1tm2tm3tm4tm5tm6tm7tm8tm9tj1tj1tj1tj2tj2t")!
//                    let ss = SutehaiSelector()
//                    let ssr : SutehaiSelectResult = ss.select(paiList)
//                    expect(ssr.getTehaiShantenNum()).to.equal(0)
//                    
//                    
//                    let scList : SutehaiCandidate[] = ssr.getSutehaiCandidateList()
//                    expect(scList.count).to.equal(2)
//                }
                it("case1") {
                    let paiList:Pai[] = Pai.parseList("m1tm2tm3tm4tm5tm6tm7tm8tm9tj7tj7tj1tj2tj3t")!
                    let ss = SutehaiSelector()
                    let ssr : SutehaiSelectResult = ss.select(paiList)
                    expect(ssr.getTehaiShantenNum()).to.equal(2)
                    
                    let scList : SutehaiCandidate[] = ssr.getSutehaiCandidateList()
                    expect(scList.count).to.equal(3)
                    expect(scList[0].getPai().toString()).to.equal("j1t")
                    
                    //print DEBUG
                    println("")
                    println("■■■■■■■")
                    for sc in scList{
                        println("捨て牌候補：" + sc.getPai().toString())
                        for ukeirePai in sc.getUkeirePaiList(){
                            println("　受け入れ牌：" + ukeirePai.getPai().toString() )
                        }
                    }
                    println("■■■■■■■")
                    
                }
                it("case2") {
                    let paiList:Pai[] = Pai.parseList("s2ts3ts3ts3ts4ts4tm4tm5tm6tm7tp5tp6tj2tj2t")!
                    let ss = SutehaiSelector()
                    let ssr : SutehaiSelectResult = ss.select(paiList)
                    expect(ssr.getTehaiShantenNum()).to.equal(3)
                    
                    let scList : SutehaiCandidate[] = ssr.getSutehaiCandidateList()
                    expect(scList.count).to.equal(3)
                    expect(scList[0].getPai().toString()).to.equal("m7t")
                    
                    //print DEBUG
                    println("")
                    println("■■■■■■■")
                    for sc in scList{
                        println("捨て牌候補：" + sc.getPai().toString())
                        for ukeirePai in sc.getUkeirePaiList(){
                            println("　受け入れ牌：" + ukeirePai.getPai().toString() )
                        }
                    }
                    println("■■■■■■■")
                    
                }
                it("should be return p4") {
                    let paiList:Pai[] = Pai.parseList("s3ts3ts3ts4ts4tm3tm4tm5tm5tm6tm7tp5tp4tp4t")!
                    let ss = SutehaiSelector()
                    let ssr : SutehaiSelectResult = ss.select(paiList)
                    //expect(ssr.getTehaiShantenNum()).to.equal(1)
                    
                    let scList : SutehaiCandidate[] = ssr.getSutehaiCandidateList()
                    //expect(scList.count).to.equal(0)
                    expect(scList[0].getPai().toString()).to.equal("p4t")
                    
                    //print DEBUG
                    println("")
                    println("■■■■■■■")
                    for sc in scList{
                        println("捨て牌候補：" + sc.getPai().toString())
                        for ukeirePai in sc.getUkeirePaiList(){
                            println("　受け入れ牌：" + ukeirePai.getPai().toString() )
                        }
                    }
                    println("■■■■■■■")
                    
                }

            }
        }
    }
}
