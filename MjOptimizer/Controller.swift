//
//  Controller.swift
//  MjOptimizer
//
//  Created by fetaro on 2014/06/21.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

import Foundation
import UIKit
import CoreMedia

class Controller:ControllerProtocol{
    let tmAnalyzer : TMAnalyzerProtocol
    let sutehaiSelector : SutehaiSelector
    var lastAnalyzeResult : AnalyzeResultProtocol?
    init (){
        // TMAnalyzerProtocol()
        self.tmAnalyzer = TMAnalyzerMock()
        self.sutehaiSelector = SutehaiSelector()
        self.lastAnalyzeResult = nil
    }
    func sutehaiSelect(image : CMSampleBuffer, targetFrame : CGRect) -> SutehaiSelectResult{
        let analyzeResult = self.tmAnalyzer.analyze(
            image,
            targetFrame : targetFrame,
            lastAnalyzerResult : self.lastAnalyzeResult!
        )
        return sutehaiSelector.select(analyzeResult.getPaiList());
    }
}
