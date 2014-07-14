//
//  Agari.swift
//  MjOptimizer
//
//  Created by fetaro on 2014/07/23.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

class Agari{
    var atama: ToitsuMentsu
    var mentsuList: MentsuList
    init(atama :ToitsuMentsu,mentsuList:MentsuList) {
        self.mentsuList = mentsuList
        self.atama = atama
    }
    func toString() -> String{
        return "雀頭" + atama.toString() + "; 面子リスト：" + mentsuList.toString()
    }
}
