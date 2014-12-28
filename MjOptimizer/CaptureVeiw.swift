//
//  CaptureView.swift
//  MjOptimizer
//
//  Created by fetaro on 2014/12/28.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

import Foundation

class CaptureView:UIView{
    
    //カメラの上にかぶせるUI部品の設置
    //赤い枠など
    func init() {
        
        let overlayImageView: UIImageView = UIImageView(image: UIImage(named:"RedRectangle"))
        overlayImageView.frame = targetRect
        
        startButton.frame = CGRectMake(290, 30, 200, 100)
        startButton.setTitle("START SCAN...", forState: UIControlState.Normal)
        startButton.addTarget(self, action: "startButtonDidPush", forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(startButton)
        
        rescanButton.frame = CGRectMake(385, 165, 200, 100)
        rescanButton.setTitle("RESCAN", forState: UIControlState.Normal)
        rescanButton.addTarget(self, action: "rescanButtonDidPush", forControlEvents: UIControlEvents.TouchUpInside)
        rescanButton.hidden = true
        view.addSubview(rescanButton)
        
        statusLabel.center = CGPointMake(420, 300)
        statusLabel.textAlignment = NSTextAlignment.Center
        statusLabel.textColor = UIColor.redColor()
        statusLabel.text = "I'm waiting for..."
        
        view.addSubview(statusLabel)
        view.addSubview(overlayImageView)
    }
    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}