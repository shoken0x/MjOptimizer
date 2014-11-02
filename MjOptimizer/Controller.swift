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
    var lastAnalyzeResult : AnalyzeResultProtocol?
    init (){
        self.tmAnalyzer = TMAnalyzer()
        self.lastAnalyzeResult = nil
    }
    
    //得点計算
    func scoreCalc(image : CMSampleBuffer, targetFrame : CGRect, kyoku: Kyoku) -> ScoreCalcResult{
        let analyzeResult : AnalyzeResultProtocol = self.tmAnalyzer.analyze(
            image,
            targetFrame : targetFrame,
            lastAnalyzerResult : nil
        )
        if !analyzeResult.isSuccess(){
            debugPrint("NG loop")
            return ScoreCalcResult.ERROR("画像解析に失敗しました")
        }else{
            //得点計算
            return ScoreCalculator.calc(analyzeResult.getPaiList(), kyoku: kyoku)
        }
    }
    
    
    //捨て牌選択（今は使っていない）
//    func sutehaiSelect(image : CMSampleBuffer, targetFrame : CGRect) -> SutehaiSelectResult{
//        let sutehaiSelector : SutehaiSelector = SutehaiSelector()
//        //画像解析
//        let analyzeResult : AnalyzeResultProtocol = self.tmAnalyzer.analyze(
//            image,
//            targetFrame : targetFrame,
//            lastAnalyzerResult : nil
//        )
//        if !analyzeResult.isSuccess(){
//            //解析失敗
//            debugPrint("NG loop")
//            return SutehaiSelectResult(
//                sutehaiCandidateList : nil,
//                tehaiShantenNum : nil,
//                tehai : analyzeResult.getPaiList(),
//                isFinishAnalyze : false,
//                successNum : analyzeResult.getAnalyzeSuccessNum()
//            )
//        }else{
//            //解析成功
//            //何きる計算
//            debugPrint("call  sutehaiSelector.select")
//            return sutehaiSelector.select(analyzeResult.getPaiList());
//        }
//    }
}
