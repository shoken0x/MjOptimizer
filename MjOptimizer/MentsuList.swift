//
//  MentsuList.swift
//  MjOptimizer
//
//  Created by fetaro on 2014/07/24.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

public class MentsuList:Equatable{
    var list : [MentsuBase]
    public init(){self.list = []}
    public init(list : [MentsuBase]){ self.list = list }
    public func append(mentsu : MentsuBase){self.list.append(mentsu)}
    public func toString() -> String{
        return "面子リスト:" + join(",",self.list.map({ m in m.toString() }))
    }
    public subscript(index:Int)->MentsuBase{
        get{ return self.list[index] }
        set(mentsu){ self.list[index] = mentsu }
    }
    public func sortting(){
        sort(&self.list){return $0 < $1}
    }
    //含まれる牌の総数を返す
    public func paiCount() -> Int{
        var sum = 0
        for mentsu in self.list{
            sum += mentsu.size()
        }
        return sum
    }
    public func union(mentsuList:MentsuList){
        for mentsu in mentsuList.list{
            self.list.append(mentsu)
        }
    }
}

public func == (lhs: MentsuList, rhs: MentsuList) -> Bool {
    return lhs.toString() == rhs.toString()
}
