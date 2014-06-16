//
//  Array+Each.swift
//
//  Created by Omar Abdelhafith on 03/06/2014.
//  Copyright (c) 2014 Omar Abdelhafith. All rights reserved.
//

import Foundation

extension Array {
    func eachWithIndex (iterator: (T, Int) -> Void ) -> Array {
        var i = 0
        for item in self {
            iterator(item, i++)
        }
        
        return self
    }
}

extension Int {
    func timesWithIndex(iterator: (Int) -> Void) -> Int{
        for i in 0..self {
            iterator(i)
        }
        
        return self
    }
}