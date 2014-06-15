//
//  ControllerProtocol.swift
//  MjOptimizer
//
//  Created by fetaro on 2014/06/16.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

import Foundation
import UIKit
import CoreMedia

protocol ControllerProtocol {
    //TODO てつたろうが実装する
    
    //@image 手牌の画像
    //@targetFrame カメラで映し出す枠。この中に手牌が映っている
    func sutehaiSelect(image : CMSampleBuffer, targetFrame : CGRect) -> SutehaiSelectResult
    
}