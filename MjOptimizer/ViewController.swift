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
    
    let videoDataOutput = AVCaptureVideoDataOutput()
    let session = AVCaptureSession()
    //let controller = Controller()
    var captureDevice: AVCaptureDevice!
    
    //UI部品
    let startButton = UIButton.buttonWithType(UIButtonType.DetailDisclosure) as UIButton
    let rescanButton = UIButton.buttonWithType(UIButtonType.DetailDisclosure) as UIButton
    let statusLabel = UILabel(frame: CGRectMake(100, 60, 300, 30))
    let filterView = UIView(frame: CGRectMake(0, 0, 568, 320))
    let targetRect = CGRectMake(24, 130, 520, 50)
    let focusView = FocusView()
    let logView = LogView()
    
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
        debugPrintln("bounds.size.height = \(view.bounds.size.height)")
        debugPrintln("bounds.size.width = \(view.bounds.size.width)")
        if findCamera() {
            setuptAVCapture(captureDevice)
            setPreview(session)
        }
        //setOverlayView()
        //view.addSubview(logView)
        //view.addSubview(self.focusView)
        
        //局状況入力
        //view.addSubview(KyokuView())
        
        //得点計算
        let scr : ScoreCalcResult = ScoreCalculator.calcFromStr("m1tm1tj5tj5tm1tj6lj6tj6tj7tj7lj7tp9tp9tp9l", kyoku: Kyoku())
        switch scr{
        case let .SUCCESS(score):
            view.addSubview(ScoreView(score:score))
        case let .ERROR(msg):
            println(msg)
        }

    }
    
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
            println("Success finding Camera")
            println("Camera name = " + captureDevice!.localizedName)
            println(captureDevice!.modelID)
            return true
        } else {
            println("Missing Camera")
            return false
        }
    }

    func setuptAVCapture(captureDevice: AVCaptureDevice) {
        // init device input
        var error: NSErrorPointer!
        let deviceInput: AVCaptureInput = AVCaptureDeviceInput.deviceInputWithDevice(captureDevice, error: error) as AVCaptureInput
        
        var queue: dispatch_queue_t = dispatch_queue_create("com.mjoptimizer.myQueue", nil)
        //TODO:コンパイルを通すために一旦コメントアウト
        //        let settings = [kCVPixelBufferPixelFormatTypeKey: kCVPixelFormatType_32BGRA]
        //        videoDataOutput.videoSettings = settings
        
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
    
    
    //ボタンを押したときの挙動
    
    func startButtonDidPush() {
        isStartScan = true
        startButton.hidden = true
        statusLabel.text = "scanning ..."
        view.addSubview(self.filterView)
        view.addSubview(self.focusView)
        view.addSubview(self.logView)
    }
    
    func rescanButtonDidPush() {
        debugPrintln("RESCAN START")
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
        println(now)
        println("update from captureOutput()")
        var sutehaiSelectResult: SutehaiSelectResult!
        
    
        dispatch_async( dispatch_get_main_queue() ) {//メインスレッドの処理
            if self.isStartScan {//スタートボタンが押されて開始している場合
                //捨て牌選択
//                var sutehaiSelectResult = self.controller.sutehaiSelect(sampleBuffer, targetFrame: self.targetRect)
//                self.isFinishAnalyze = sutehaiSelectResult.isFinishAnalyze
//                if self.isFinishAnalyze {
//                    // Display SutehaiSelectResult
//                    var sutehaiCandidateList = sutehaiSelectResult.getSutehaiCandidateList()
//                    self.statusLabel.text = "Finish scan."
//                    self.focusView.removeFromSuperview()
//                    self.filterView.removeFromSuperview()
//                    self.session.stopRunning()
//                    self.startButton.hidden = true
//                    self.rescanButton.hidden = false
//                } else {
//                    self.statusLabel.text = now.description
//                    
//                }
            }
        }
    }
}
