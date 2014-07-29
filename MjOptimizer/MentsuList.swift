//
//  MentsuList.swift
//  MjOptimizer
//
//  Created by fetaro on 2014/07/24.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

public class MentsuList:Equatable{
    var array : [Mentsu]
    public init(){self.array = []}
    public init(list : [Mentsu]){ self.array = list }
    public func append(mentsu : Mentsu){self.array.append(mentsu)}
    public func toString() -> String{
        return "面子リスト:" + join(",",self.array.map({ m in m.toString() }))
    }
    public subscript(index:Int)->Mentsu{
        get{ return self.array[index] }
        set(mentsu){ self.array[index] = mentsu }
    }
    public func sortting(){
        sort(&self.array){return $0 < $1}
    }
    //含まれる牌の総数を返す
    public func paiCount() -> Int{
        var sum = 0
        for mentsu in self.array{
            sum += mentsu.size()
        }
        return sum
    }
    public func union(mentsuList:MentsuList){
        for mentsu in mentsuList.array{
            self.array.append(mentsu)
        }
    }
}

public func == (lhs: MentsuList, rhs: MentsuList) -> Bool {
    return lhs.toString() == rhs.toString()
}
