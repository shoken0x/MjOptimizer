//
//  CvView.swift
//  MjOptimizer
//
//  Created by gino on 2014/06/21.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

import UIKit
import QuartzCore

class CvView: UIView {
    
    var tmResultList: [TMResult]

    init(frame: CGRect, background: UIImage) {
        tmResultList = [TMResult]()
        super.init(frame: frame)
        self.backgroundColor = UIColor(patternImage:background)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addRect(result:TMResult) {
        tmResultList.append(result)
    }
    
    func imageFromView() -> UIImage {
        UIGraphicsBeginImageContext(self.frame.size)
        let context = UIGraphicsGetCurrentContext()
        self.layer.renderInContext(context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect)
    {
        var context = UIGraphicsGetCurrentContext()
        CGContextSetRGBStrokeColor(context, 0, 1.0, 0.2, 1.0)
        for tmResult : TMResult in tmResultList {
            CGContextAddRect(context, tmResult.place)
        }
        CGContextStrokePath(context)
    }
}
