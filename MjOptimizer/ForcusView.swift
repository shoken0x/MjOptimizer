//
//  ForcusAnimationView.swift
//  MjOptimizer
//
//  Created by fetaro on 2014/08/29.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

import Foundation

class FocusView: UIImageView{

    init(){
        super.init(frame: CGRectMake(24, 100, 100, 100))
        let imgArray = NSArray(array: [UIImage(named:"circle01"),
            UIImage(named:"circle02"),
            UIImage(named:"circle03")])
        
        self.animationImages = imgArray
        self.animationDuration = 0.5
        self.startAnimating()
    }
}