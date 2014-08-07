//
//  PointCalculator.swift
//  MjOptimizer
//
//  Created by fetaro on 2014/08/08.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

import Foundation

public struct Score{
    public var c:Int
    public var p:Int
    public var t:Int
    public var m:Float
    public init(c:Int,p:Int,t:Int,m:Float){
        self.c = c
        self.p = p
        self.t = t
        self.m = m
    }
}

public class PointCalculator{
    public class func calcFuNum(agari:Agari,kyoku:Kyoku)->Int{
        //チートイツ
        if (agari.mentsuList.filter{$0.type() == MentsuType.TOITSU}.count == 7 ){
            return 25
        }else{
            var fuNum = 20
            for mentsu in agari.mentsuList{
                println(mentsu.toString() + String(mentsu.fuNum(kyoku)))
                fuNum += mentsu.fuNum(kyoku)
            }
            return ((fuNum % 10) == 0 ) ? fuNum : (fuNum + 10) //1の位切り上げ
        }
    }
    //3値の配列 [子の支払い、親の支払い、取得合計] を返す
    public class func calcPoint(fuNum:Int,hanNum:Int,isParent:Bool,isTsumo:Bool)->Score{
        var c:Int = 0
        var p:Int = 0
        var t:Int = 0
        var m:Float = 0
        var base:Int = 0
        if hanNum >= 5 {
            if hanNum >= 39 {
                m = 12.0 //トリプル役満
            }else if hanNum >= 26 {
                m = 8.0 //ダブル役満
            }else if hanNum >= 13 {
                m = 4.0 //役満
            }else if hanNum >= 11 {
                m = 3.0
            }else if hanNum >= 8 {
                m = 2.0
            }else if hanNum >= 6 {
                m = 1.5
            }else{
                m = 1.0
            }
            base = Int(m * 2000)
        }else{
            var tmp = 4 //下駄
            hanNum.times{ tmp = tmp * 2 }
            base = fuNum * tmp
            if(base > 2000){ //満貫
                base = 2000
                m = 1.0
            }
        }
        
        if isParent{
            if isTsumo{
                c = ceil10(base*2)
                t = ceil10(base*2) * 3
            }else{
                t = ceil10(base*6)
            }
        }else{
            if isTsumo{
                c = ceil10(base)
                p = ceil10(base*2)
                t = ceil10(base)*2 + ceil10(base*2)
            }else{
                t = ceil10(base*4)
            }
        }
        return Score(c:c,p:p,t:t,m:m)
    }
    //10の位切り上げ
    private class func ceil10(i:Int) -> Int{return ( i % 100 == 0 ) ? i : (Int(i / 100) * 100 + 100)}
   // private class func pow(i:Int,power:Int) -> Int{var ret = 1 ; power.times(ret = ret*i);return ret}
}