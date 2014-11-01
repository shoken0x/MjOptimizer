//
//  LogView.swift
//  MjOptimizer
//
//  Created by fetaro on 2014/08/29.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

import Foundation

class LogView: UITextView{
    let st = Stats()
    override init(){
        super.init(frame: CGRect(x: 460, y: 20, width: 150, height: 100), textContainer: nil)
        
        self.scrollEnabled = true
        self.editable = false
        self.textAlignment = NSTextAlignment.Left
        self.font = UIFont(name: "Courier", size: 13)
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.0)
        self.textColor = UIColor.greenColor()
        self.text = "START SCAN..."
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(){
        self.text = self.text.stringByAppendingString(self.st.updateStates())
        var range = self.selectedRange
        range.location = self.text.length
        self.scrollRangeToVisible(range)
        self.scrollEnabled = true
        
    }
}