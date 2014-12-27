//
//  ViewController.swift
//  mjoptimizer
//
//  Created by Shoken Fujisaki on 6/12/14.
//  Copyright (c) 2014 Shoken Fujisaki. All rights reserved.
//

import UIKit
import AVFoundation
import CoreMedia

class ViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {

    //デバイス周り
    let videoDataOutput = AVCaptureVideoDataOutput()
    let session = AVCaptureSession()
    var captureDevice: AVCaptureDevice!
    
    //局状態の変数
    let kyoku = Kyoku()//起動時はデフォルトの局状態で計算し、局に局状態を更新する

    //UI部品
    let startButton = UIButton.buttonWithType(UIButtonType.DetailDisclosure) as UIButton
    let rescanButton = UIButton.buttonWithType(UIButtonType.DetailDisclosure) as UIButton
    let statusLabel = UILabel(frame: CGRectMake(100, 60, 300, 30))
    let filterView = UIView(frame: CGRectMake(0, 0, 568, 320))
    let focusView = FocusView()
    let logView = LogView()
    
    //切り取り対象
    let targetRect = CGRectMake(24, 130, 520, 50)
    
    //フラグ
    var isFinishAnalyze = false
    var isStartScan = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //UI部品の初期化
        filterView.backgroundColor = UIColor(red: 1.0, green: 0, blue: 0, alpha: 0.1)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //メイン処理
    override func viewDidAppear(animated: Bool) {
        Log.debug("bounds.size.height = \(view.bounds.size.height)")
        Log.debug("bounds.size.width = \(view.bounds.size.width)")
        if findCamera() {
            setuptAVCapture(captureDevice)
            setPreview(session)
            setOverlayView()
            view.addSubview(logView)
            view.addSubview(self.focusView)
        }else{
            //カメラがないのでテスト画面を出す
            Log.info("カメラがないからテスト画面を出す")
            let scoreCalcResult :ScoreCalcResult =  ScoreCalculator.calcFromStr("m1tm1tj5tj5tm1tj6lj6tj6tj7tj7lj7tp9tp9tp9l", kyoku: Kyoku())
            switch scoreCalcResult{
            case let .SUCCESS(score):
                view.addSubview(
                    ScoreView(
                        score:score,
                        paiList:Pai.parseList("m1tm1tj5tj5tm1tj6lj6tj6tj7tj7lj7tp9tp9tp9l")!
                    )
                )
                
            case let .ERROR(msg):
                Log.error(msg)
            }
        }
    }
    
    //カメラが見つかろうかどうか
    func findCamera() -> Bool {
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

    //カメラ初期化
    func setuptAVCapture(captureDevice: AVCaptureDevice) {
        // init device input
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
    }
    
    func setPreview(session: AVCaptureSession) {
        let previewLayer: AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer.layerWithSession(session) as AVCaptureVideoPreviewLayer
        previewLayer.connection.videoOrientation = AVCaptureVideoOrientation.LandscapeLeft
        previewLayer.frame = view.bounds
        view.layer.addSublayer(previewLayer)
    }
    
    //カメラの上にかぶせるUI部品の設置
    //赤い枠など
    func setOverlayView() {
        let overlayImageView: UIImageView = UIImageView(image: UIImage(named:"RedRectangle"))
        overlayImageView.frame = targetRect
        
        startButton.frame = CGRectMake(290, 30, 200, 100)
        startButton.setTitle("START SCAN...", forState: UIControlState.Normal)
        startButton.addTarget(self, action: "startButtonDidPush", forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(startButton)
        
        rescanButton.frame = CGRectMake(385, 165, 200, 100)
        rescanButton.setTitle("RESCAN", forState: UIControlState.Normal)
        rescanButton.addTarget(self, action: "rescanButtonDidPush", forControlEvents: UIControlEvents.TouchUpInside)
        rescanButton.hidden = true
        view.addSubview(rescanButton)
        
        statusLabel.center = CGPointMake(420, 300)
        statusLabel.textAlignment = NSTextAlignment.Center
        statusLabel.textColor = UIColor.redColor()
        statusLabel.text = "I'm waiting for..."
        
        view.addSubview(statusLabel)
        view.addSubview(overlayImageView)
    }
    
    
    //スタートボタンを押したときの挙動
    func startButtonDidPush() {
        isStartScan = true
        startButton.hidden = true
        statusLabel.text = "scanning ..."
        view.addSubview(self.filterView)
        view.addSubview(self.focusView)
        view.addSubview(self.logView)
    }
    
    //リスキャンボタンを押したときの挙動
    func rescanButtonDidPush() {
        Log.debug("RESCAN START")
        rescanButton.hidden = true
        isFinishAnalyze = false
        for subview in view.subviews as [UIView] {
            subview.removeFromSuperview()
        }
        view.addSubview(self.filterView)
        setOverlayView()
        view.addSubview(self.focusView)
        view.addSubview(self.logView)
        session.startRunning()
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
            //得点計算
            let scoreCalcResult :ScoreCalcResult = ScoreCalculator.calc(analyzeResult.getPaiList(), kyoku: self.kyoku)
            switch scoreCalcResult{
            case let .SUCCESS(score):
                //得点計算に成功
                //得点画面の表示
                self.view.addSubview(ScoreView(score:score,paiList:analyzeResult.getPaiList()))
                self.statusLabel.text = "Finish scan."
                self.focusView.removeFromSuperview()
                self.filterView.removeFromSuperview()
                self.session.stopRunning()
                self.startButton.hidden = true
                self.rescanButton.hidden = false
            case let .ERROR(msg):
                //得点計算に失敗
                self.statusLabel.text = now.description
                Log.info(msg)
            }
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
