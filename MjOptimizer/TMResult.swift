//
//  TMAResult.swift
//  MjOptimizer
//
//  Created by gino on 2014/06/21.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

import UIKit

class TMResult {
    var value: Double
    var place: CGRect
    var pai: Pai

    init(x: Int, y: Int, width: Int, height: Int, value: Double, pai: Pai) {
        self.place = CGRectMake(CGFloat(x), CGFloat(y), CGFloat(width), CGFloat(height))
        self.value = value
        self.pai = pai
    }
    
    func distance(other: TMResult) -> Double {
        return sqrt(
            pow(CDouble(self.place.origin.x - other.place.origin.x), 2) +
            pow(CDouble(self.place.origin.y - other.place.origin.y), 2)
        )
    }
}
