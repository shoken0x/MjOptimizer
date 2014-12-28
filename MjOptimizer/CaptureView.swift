//
//  CaptureView.swift
//  MjOptimizer
//
//  Created by fetaro on 2014/12/28.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

import Foundation
import AVFoundation
import CoreMedia

class CaptureView: UIView, AVCaptureVideoDataOutputSampleBufferDelegate{
    //デバイス周り
    let videoDataOutput = AVCaptureVideoDataOutput()
    let session = AVCaptureSession()
    var captureDevice: AVCaptureDevice!

    //UI部品
    let filterView = UIView(frame: CGRectMake(20, 0, 400, 320))
    let focusView = FocusView()
    let logView = LogView()
    
    //切り取り対象
    let targetRect = CGRectMake(24, 130, 520, 50)
    
    //フラグ
    var isFinishAnalyze = false
    var isStartScan = false

    //親画面
    var topView: TopView? = nil
    
    override init(){
        super.init(frame: CGRectMake(20, 0, 400, 320))
    }
    func setTopView(topView:TopView){
        self.topView = topView
    }
    func captureInit(captureDevice:AVCaptureDevice){
        self.captureDevice = captureDevice
        
        //setuptAVCapture
        var error: NSErrorPointer = nil
        let deviceInput: AVCaptureInput = AVCaptureDeviceInput.deviceInputWithDevice(captureDevice, error: error) as AVCaptureInput
        var queue: dispatch_queue_t = dispatch_queue_create("com.mjoptimizer.myQueue", nil)
        videoDataOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey : kCVPixelFormatType_32BGRA]
        videoDataOutput.alwaysDiscardsLateVideoFrames = true
        videoDataOutput.setSampleBufferDelegate(self, queue: queue)
        session.sessionPreset = AVCaptureSessionPreset640x480
        session.addInput(deviceInput as AVCaptureInput)
        session.addOutput(videoDataOutput)
        session.beginConfiguration()
        var videoConnection: AVCaptureConnection = videoDataOutput.connectionWithMediaType(AVMediaTypeVideo)
        videoConnection.videoOrientation = AVCaptureVideoOrientation.LandscapeLeft
        //videoConnection.videoMinFrameDuration = CMTimeMake(1, 1);
        session.commitConfiguration()
        session.startRunning()
        
        //setPreview
        let previewLayer: AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer.layerWithSession(session) as AVCaptureVideoPreviewLayer
        previewLayer.connection.videoOrientation = AVCaptureVideoOrientation.LandscapeLeft
        previewLayer.frame = self.bounds
        self.layer.addSublayer(previewLayer)

        //OverlayView
        var overlayImageView: UIImageView = UIImageView(image: UIImage(named:"RedRectangle"))
        overlayImageView.frame = targetRect
        self.addSubview(overlayImageView)
        

        
        //statusLabel
        //self.statusLabel.center = CGPointMake(420, 300)
        //self.statusLabel.textAlignment = NSTextAlignment.Center
        //self.statusLabel.textColor = UIColor.redColor()
        //self.statusLabel.text = "I'm waiting for..."
        //self.addSubview(statusLabel)
        
        //TODO filterview
        //self.filterView.backgroundColor = UIColor(red: 1.0, green: 0, blue: 0, alpha: 0.1)
        
        //TODO logview
        //self.addSubview(self.logView)
        
        //TODO focusView
        //self.addSubview(self.focusView)

    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startCapture(){
        self.isStartScan = true
    }
    
    
    //キャプチャした際に呼ばれる関数
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, fromConnection connection: AVCaptureConnection!) {
        NSThread.sleepForTimeInterval(0.5)
        let now: NSDate = NSDate()
        Log.info("update from captureOutput()")
        dispatch_async( dispatch_get_main_queue() ) {//メインスレッドの処理
            if(!self.isStartScan) {
                //スタートボタンが押されて開始していない場合
                return
            }
            //キャプチャした画像からUIImageを作成
            let uiimage : UIImage = self.uiimageFromCMSampleBuffer(sampleBuffer)
            //画像解析
            let tmAnalyzer : TMAnalyzer = TMAnalyzer()
            let analyzeResult : AnalyzeResultProtocol = tmAnalyzer.analyze(uiimage ,targetFrame : self.targetRect, lastAnalyzerResult : nil )
            
            if !analyzeResult.isSuccess(){
                Log.info("画像解析に失敗しました")
                return
            }
            Log.info("画像解析に成功しました")
            Log.info("画像解析結果：" + join(",",analyzeResult.getPaiList().map({$0.toString() })))
            
            //TODO
            //self.focusView.removeFromSuperview()
            //self.filterView.removeFromSuperview()

            Log.info("スキャンストップ")
            self.session.stopRunning()
            
            //top画面に解析結果を貸す
            self.topView!.showResult(analyzeResult.getPaiList())
        }
    }
    
    //カメラの画像からUIImageを作る
    private func uiimageFromCMSampleBuffer(image:CMSampleBuffer) -> UIImage{
        // イメージバッファの取得
        let imageBuffer : CVImageBufferRef  = CMSampleBufferGetImageBuffer(image)
        
        // ピクセルバッファのベースアドレスをロックする
        //ロックしないと、カメラから送られてくるデータで次々と書き換えられてしまう事になる。
        CVPixelBufferLockBaseAddress(imageBuffer, 0)
        
        //CVImageBufferの各種情報を取得する。
        let baseAddress : UnsafeMutablePointer<Void> = CVPixelBufferGetBaseAddressOfPlane(imageBuffer, 0)
        let width : UInt = CVPixelBufferGetWidth(imageBuffer)
        let height : UInt = CVPixelBufferGetHeight(imageBuffer)
        let bytesPerRow : UInt = CVPixelBufferGetBytesPerRow(imageBuffer)
        //カラースペースとBPCの設定
        let colorSpace : CGColorSpaceRef = CGColorSpaceCreateDeviceRGB()
        let bitsPerComponent : UInt = 8
        //ビットマップがアルファチャンネルを含む場合、ピクセル内におけるアルファチャンネルの相対的な位置と、
        //ピクセル成分が浮動小数点または整数値かどうかの情報を定数で指定します。
        //objective-c では kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst としていた
        let bitmapInfo : CGBitmapInfo = CGBitmapInfo.ByteOrder32Little | CGBitmapInfo(CGImageAlphaInfo.PremultipliedFirst.rawValue)
        
        //BitmapContectの作成
        let newContext : CGContextRef = CGBitmapContextCreate(baseAddress,width,height,bitsPerComponent,bytesPerRow,colorSpace,bitmapInfo)
        
        //
        let imageRef : CGImageRef = CGBitmapContextCreateImage(newContext)
        let uiimage : UIImage = UIImage(CGImage: imageRef)!
        Log.debug("UIImage width=\(uiimage.size.width) height=\(uiimage.size.height)")
        //UIImageの取得ができたら、CVImageBufferを忘れずにアンロックしておこう。これで次のデータが送られてくる。
        CVPixelBufferUnlockBaseAddress(imageBuffer, 0);
        return uiimage;
    }

}