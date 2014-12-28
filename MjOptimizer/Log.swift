//
//  Log.swift
//  MjOptimizer
//
//  Created by fetaro on 2014/06/30.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

import Foundation

class Log{
    class func debug(str:String){
       // println("[MJ][DEBUG]" + str)
    }
    class func info(str:String){ println("[MJ][INFO]" + str)}
    class func warn(str:String){ println("[MJ][WARN]" + str)}
    class func error(str:String){ println("[MJ][ERROR]" + str)}
}