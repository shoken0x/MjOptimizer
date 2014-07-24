//
//  MentsuList.swift
//  MjOptimizer
//
//  Created by fetaro on 2014/07/24.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

class MentsuList:Equatable{
    var list : Mentsu[]
    init(){self.list = []}
    init(list : Mentsu[]){ self.list = list }
    func append(mentsu : Mentsu){self.list.append(mentsu)}
    func toString() -> String{
        return "面子リスト:" + join(",",self.list.map({ m in m.toString() }))
    }
    subscript(index:Int)->Mentsu{
        get{ return self.list[index] }
        set(mentsu){ self.list[index] = mentsu }
    }
    func sortting(){
        sort(self.list){return $0 < $1}
    }
    //含まれる牌の総数を返す
    func paiCount() -> Int{
        var sum = 0
        for mentsu in self.list{
            sum += mentsu.size()
        }
        return sum
    }
    func union(mentsuList:MentsuList){
        for mentsu in mentsuList.list{
            self.list.append(mentsu)
        }
    }
}

func == (lhs: MentsuList, rhs: MentsuList) -> Bool {
    return lhs.toString() == rhs.toString()
}
