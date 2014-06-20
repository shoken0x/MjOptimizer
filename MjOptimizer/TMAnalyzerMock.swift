//
//  TMAnalyzer.swift
//  MjOptimizer
//
//  Created by fetaro on 2014/06/21.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

import Foundation
import UIKit
import CoreMedia

class TMAnalyzerMock : TMAnalyzerProtocol{
    init(){}
    
    func analyze(image : CMSampleBuffer, targetFrame : CGRect, lastAnalyzerResult : AnalyzeResultProtocol) -> AnalyzeResultProtocol{
        return AnalyzeResultMock()
    }
}