//
//  DebugView.swift
//  MjOptimizer
//
//  Created by fetaro on 2014/12/30.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

import Foundation

class DebugView:UIView{
    init(analyzeResult:AnalyzeResult,msg:String){
        super.init(frame: UIScreen.mainScreen().bounds)
        let debugImage = UIImageView(image:analyzeResult.debugImage)
        debugImage.frame = CGRectMake(0, 40, 500,50)
        self.addSubview(debugImage)
        let logview = UITextView(frame: CGRectMake(0, 100, 500,500))
        logview.text = msg + "\n画像解析結果:" + analyzeResult.toString()
        self.addSubview(logview)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}