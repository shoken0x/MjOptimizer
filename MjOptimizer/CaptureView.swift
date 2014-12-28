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
    //キャプチャエリアの表示上の大きさ。実際の画像の解像度は640x480
    let CAPTURE_AREA_WIDTH : CGFloat = 400
    let CAPTURE_AREA_HEIGHT : CGFloat = 300
    
    //デバイス周り
    let videoDataOutput = AVCaptureVideoDataOutput()
    let session = AVCaptureSession()
    var captureDevice: AVCaptureDevice!

    //UI部品
    let redFilterView : UIView
    let focusView : FocusView
    let statusLabel : UILabel
    
    //キャプチャ画像内のトリミング対象範囲
    //キャプチャ画像は640x480になるため、その中の座標を示す
    let targetRect = CGRectMake(0, 190, 640, 80)
    
    //フラグ
    var isFinishAnalyze = false
    var isStartScan = false

    //親画面
    var topView: TopView? = nil
    
    init(x:CGFloat,y:CGFloat){
        self.redFilterView = UIView(frame: CGRectMake(0, 0, CAPTURE_AREA_WIDTH, CAPTURE_AREA_HEIGHT))
        self.redFilterView.backgroundColor = UIColor(red: 1.0, green: 0, blue: 0, alpha: 0.1)
        self.statusLabel = UILabel(frame: CGRectMake(100, 60, 300, 30))
        self.focusView = FocusView()
      
        super.init(frame: CGRectMake(x, y, CAPTURE_AREA_WIDTH, CAPTURE_AREA_HEIGHT))
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
        
        videoDataOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey : kCVPixelFormatType_32BGRA]//32bit RGBAで画像を取得
        videoDataOutput.alwaysDiscardsLateVideoFrames = true
        videoDataOutput.setSampleBufferDelegate(self, queue: queue)
        session.sessionPreset = AVCaptureSessionPreset640x480//キャプチャする画像の解像度は640x480
        session.addInput(deviceInput as AVCaptureInput)
        session.addOutput(videoDataOutput)
        session.beginConfiguration()
        var videoConnection: AVCaptureConnection = videoDataOutput.connectionWithMediaType(AVMediaTypeVideo)
        videoConnection.videoOrientation = AVCaptureVideoOrientation.LandscapeLeft
        //videoConnection.videoMinFrameDuration = CMTimeMake(1, 1);
        session.commitConfiguration()
        session.startRunning()
        
        //カメラプレビュー
        let previewLayer: AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer.layerWithSession(session) as AVCaptureVideoPreviewLayer
        previewLayer.connection.videoOrientation = AVCaptureVideoOrientation.LandscapeLeft
        previewLayer.frame = self.bounds
        self.layer.addSublayer(previewLayer)

        //赤枠
        //キャプチャする画像の解像度と、キャプチャエリアのサイズの比率を計算
        let rateX = CAPTURE_AREA_WIDTH / 640
        let rateY = CAPTURE_AREA_HEIGHT / 480
        var redRect:UIView = UIView(frame: CGRectMake(targetRect.minX * rateX , targetRect.minY * rateY, targetRect.width * rateX, targetRect.height * rateY))
        redRect.layer.borderWidth = 2.0
        redRect.layer.borderColor = UIColor.redColor().CGColor
        self.addSubview(redRect)
        
        
        //statusLabel
        self.statusLabel.center = CGPointMake(420, 300)
        self.statusLabel.textAlignment = NSTextAlignment.Center
        self.statusLabel.textColor = UIColor.redColor()
        self.statusLabel.text = "I'm waiting for..."
        self.addSubview(statusLabel)
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startCapture(){
        self.statusLabel.text = "Scanning..."
        self.addSubview(self.focusView)
        self.addSubview(self.redFilterView)
        self.isStartScan = true
    }
    
    
    //キャプチャした際に呼ばれる関数
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, fromConnection connection: AVCaptureConnection!) {
        NSThread.sleepForTimeInterval(0.5)
        let now: NSDate = NSDate()
        dispatch_async( dispatch_get_main_queue() ) {//メインスレッドの処理
            if(!self.isStartScan) {
                //スタートボタンが押されて開始していない場合
                Log.info("スタートボタン押し待ち")
                return
            }
            //キャプチャした画像からUIImageを作成
            var uiimage : UIImage = self.uiimageFromCMSampleBuffer(sampleBuffer)
            //トリミング
            uiimage = self.trimUIImage(uiimage)
            //画像解析
            let tmAnalyzer : TMAnalyzer = TMAnalyzer()
            let analyzeResult : AnalyzeResult = tmAnalyzer.analyze(uiimage,lastAnalyzerResult : nil )
            
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
            self.isStartScan = false
            
            //top画面に解析結果を貸す
            self.topView!.showResult(analyzeResult.getPaiList(), capturedImage:uiimage)
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

    //トリミング
    private func trimUIImage(inputUIImage:UIImage)->UIImage{
        //Trim image
        let trimArea : CGRect = targetRect;
        let srcImageRef : CGImageRef = inputUIImage.CGImage
        let trimmedImageRef : CGImageRef = CGImageCreateWithImageInRect(srcImageRef, trimArea)
        return UIImage(CGImage: trimmedImageRef)!
    }
}