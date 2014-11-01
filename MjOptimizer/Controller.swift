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
        self.tmAnalyzer = TMAnalyzer()
        self.sutehaiSelector = SutehaiSelector()
        self.lastAnalyzeResult = nil
    }
    func sutehaiSelect(image : CMSampleBuffer, targetFrame : CGRect) -> SutehaiSelectResult{
        //画像解析
        let analyzeResult : AnalyzeResultProtocol = self.tmAnalyzer.analyze(
            image,
            targetFrame : targetFrame,
            lastAnalyzerResult : nil
        )
        if !analyzeResult.isSuccess(){
            //解析失敗
            debugPrint("NG loop")
            return SutehaiSelectResult(
                sutehaiCandidateList : nil,
                tehaiShantenNum : nil,
                tehai : analyzeResult.getPaiList(),
                isFinishAnalyze : false,
                successNum : analyzeResult.getAnalyzeSuccessNum()
            )
        }else{
            //解析成功
            //何きる計算
            debugPrint("call  sutehaiSelector.select")
            return sutehaiSelector.select(analyzeResult.getPaiList());
        }
    }
}
