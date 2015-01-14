//
//  TopView.swift
//  MjOptimizer
//
//  Created by fetaro on 2014/12/28.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

import Foundation
import AVFoundation
import CoreMedia

class TopView:UIView{
    var captureDevice: AVCaptureDevice!
    var captureView : CaptureView = CaptureView(x: 40,y: 0)
    let startButton = UIButton.buttonWithType(UIButtonType.DetailDisclosure) as UIButton

    //局状態の変数
    let kyoku = Kyoku()//起動時はデフォルトの局状態で計算し、局に局状態を更新する

    override init(){
        super.init(frame:CGRectMake(0, 0, 480, 320))
        
        if findCamera() {
            //captureView
            self.captureView.setTopView(self)
            self.addSubview(self.captureView)
            
            //startButton
            startButton.frame = CGRectMake(0, 0, 200, 100)
            startButton.setTitle("START SCAN...", forState: UIControlState.Normal)
            startButton.addTarget(self, action: "startButtonDidPush", forControlEvents: UIControlEvents.TouchUpInside)
            self.addSubview(startButton)

            self.captureView.captureInit(captureDevice)
        }else{
            //カメラがないのでテスト画面を出す
            Log.info("カメラがないからテスト画面を出す")
            
            //ダミー画像で画像解析
            let uiimage = UIImage(named:"dummyphoto3")!
            let uiview = UIImageView(image:uiimage)
            uiview.frame = CGRectMake(40, 00, 300,40)
            self.addSubview(uiview)

            //二値化
            let cvUtil = CvUtil()
            let width = Int(uiimage.size.width);
            let height = Int(uiimage.size.height);
            //cのポインタを扱うのでallocする
            var binaryArrayPtr :UnsafeMutablePointer<Int32> = UnsafeMutablePointer.alloc( width * height * sizeof(Int32))
            //画像を0,1の二値の配列にする
            cvUtil.toBinaryArray(uiimage, result: binaryArrayPtr)
            
            //コンソールに二値画像を出す
            for(var y=0;y<height;y++){
                for(var x=0;x<width;x++){
                    if(binaryArrayPtr[x + y * width] == 0){
                        print("0")
                    }else{
                        print(" ")
                    }
                }
                print("\n")
            }
            
            //debug view
            let binaryImage : UIImage = cvUtil.changeDepth(uiimage,matchType:2)
            let capturedImage = UIImageView(image:binaryImage)
            capturedImage.frame = CGRectMake(40, 40, 300,40)
            self.addSubview(capturedImage)

            //長方形検出
            let paiNo = 14;
            let paiHeight = 48;
            let paiRectsPtr : UnsafeMutablePointer<pai_rect_t> = UnsafeMutablePointer.alloc(paiNo * sizeof(pai_rect_t))
            let detectNo :Int = Int(
                detect_rects(
                    binaryArrayPtr,
                    Int32(width),
                    Int32(height),
                    Int32(paiHeight),
                    Int32(paiNo),
                    paiRectsPtr
                )
            );

            //結果をコンソールに表示
            for(var i=0;i<detectNo;i++){
                let paiRect : pai_rect_t = paiRectsPtr[i]
                Log.info("検出した白い長方形：[\(paiRect.x),\(paiRect.y)] \(paiRect.w)x\(paiRect.h)(\(paiRect.type))")
            }

            //結果を描画
//            let detectView : UIView = UIView(frame:CGRectMake(40,80, uiimage.size.width, uiimage.size.height))
//            detectView.backgroundColor = UIColor(patternImage:uiimage)
//            var context = UIGraphicsGetCurrentContext()
//            CGContextSetRGBStrokeColor(context, 0, 1.0, 0.2, 1.0)
//            for(var i=0;i<detectNo;i++){
//                let paiRect : pai_rect_t = paiRectsPtr[i]
//                CGContextAddRect(context, CGRectMake(CGFloat(paiRect.x),CGFloat(paiRect.y),CGFloat(paiRect.w),CGFloat(paiRect.h)))
//            }
//            CGContextStrokePath(context)
//            
//            UIGraphicsBeginImageContext(detectView.frame.size)
//            detectView.layer.renderInContext(context)
//            let detectImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
//            UIGraphicsEndImageContext()
//            
//            let detectImageView = UIImageView(image:detectImage)
//            detectImageView.frame = CGRectMake(40, 100, 300,40)
//            self.addSubview(detectImageView)

            
            //メモリ解放
            binaryArrayPtr.dealloc(width * height * sizeof(Int32))
            paiRectsPtr.dealloc(paiNo * sizeof(pai_rect_t))

            


            
            //テンプレートマッチ
//            let tmAnalyzer = TMAnalyzer()
//            let analyzeResult = tmAnalyzer.analyze(uiimage)
//            showResult(analyzeResult)
            
            //直接牌リストを指定する場合は以下をコメントアウト
//            let paiList = Pai.parseList("p1tp2tp3tp4tp5tp6tp7tp8tp9tj4tj4tj4ts9ts9t")!
//            let scoreCalcResult :ScoreCalcResult =  ScoreCalculator.calc(paiList, kyoku: Kyoku())
//            switch scoreCalcResult{
//            case let .SUCCESS(score):
//                self.addSubview(
//                    ScoreView(
//                        score:score,
//                        paiList:paiList,
//                        capturedImage:uiimage
//                    )
//                )
//            case let .ERROR(msg):
//                Log.error(msg)
//            }
        }
    }
    
    //スタートボタンを押したとき
    func startButtonDidPush() {
        self.captureView.startCapture()
    }
    
    //画像解析が終わったときにコールバックされる
    func showResult(analyzeResult:AnalyzeResult){
        Log.info("画像解析結果：\(analyzeResult.toString())")
        //キャプチャ画面を消す
        self.captureView.removeFromSuperview()
        if(analyzeResult.resultList.count >= 14){
            //画像解析成功
            //得点計算
            let scoreCalcResult :ScoreCalcResult = ScoreCalculator.calc(analyzeResult.paiList, kyoku: self.kyoku)
            switch scoreCalcResult{
            case let .SUCCESS(score):
                self.addSubview(ScoreView(score:score,paiList:analyzeResult.paiList,capturedImage:analyzeResult.debugImage))
            case let .ERROR(msg):
                //得点計算に失敗
                Log.info(msg)
                //画像解析失敗。画像解析デバッグビューを出す
                self.addSubview(DebugView(analyzeResult: analyzeResult, msg:msg))
            }
        }else{
            //画像解析失敗。画像解析デバッグビューを出す
            self.addSubview(DebugView(analyzeResult: analyzeResult, msg:"検出できた牌が14枚未満"))
        }
    }
    
    
    //カメラが見つかったら真を返す
    private func findCamera() -> Bool {
        let devices: NSArray = AVCaptureDevice.devices()
        
        // find back camera
        for device: AnyObject in devices {
            if device.position == AVCaptureDevicePosition.Back {
                captureDevice = device as? AVCaptureDevice
            }
        }
        
        if (captureDevice != nil) {
            // Debug
            Log.info("Success finding Camera")
            Log.info("Camera name = " + captureDevice!.localizedName)
            Log.info(captureDevice!.modelID)
            return true
        } else {
            Log.info("Missing Camera")
            return false
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}