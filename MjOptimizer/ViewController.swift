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
    let label = UILabel(frame: CGRectMake(100, 50, 300, 30))
    let headerLabel = UILabel(frame: CGRectMake(10, 10, 300, 30))
    let footerLabel = UILabel(frame: CGRectMake(10, 10, 300, 30))
    let totalNumLabel =   UILabel(frame: CGRectMake(10, 10, 30, 30))
    let shantenNumLabel = UILabel(frame: CGRectMake(10, 10, 30, 30))
    let debugButton = UIButton.buttonWithType(UIButtonType.DetailDisclosure) as UIButton
    
    var captureDevice: AVCaptureDevice!
    var isFinishAnalyze = false
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        if findCamera() {
            setuptAVCapture(captureDevice)
            setPreview(session)
        }
        setOverlayView()
        //viewMjImages()
    }
    
    func setPreview(session: AVCaptureSession) {
        let previewLayer: AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer.layerWithSession(session) as AVCaptureVideoPreviewLayer
        previewLayer.frame = view.bounds
        
        view.layer.addSublayer(previewLayer)
    }
        
    func setOverlayView() {
        let overlayImageView: UIImageView = UIImageView(image: UIImage(named: "overlaygraphic.png"))
        overlayImageView.frame = CGRectMake(30, 250, 260, 200)
        
        debugButton.frame = CGRectMake(70, 100, 200, 100)
        debugButton.setTitle("Display Results", forState: UIControlState.Normal)
        debugButton.addTarget(self, action: "buttonDidPush", forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(debugButton)
        
        label.center = CGPointMake(160, 184)
        label.textAlignment = NSTextAlignment.Center
        label.textColor = UIColor.redColor()
        label.text = "scanning ..."
        
        view.addSubview(label)
        view.addSubview(overlayImageView)
    }
    
    func setuptAVCapture(captureDevice: AVCaptureDevice) {
        // init device input
        var error: NSErrorPointer!
        let deviceInput: AVCaptureInput = AVCaptureDeviceInput.deviceInputWithDevice(captureDevice, error: error) as AVCaptureInput
        
        
        // ビデオ出力のキャプチャの画像情報のキューを設定
        var queue: dispatch_queue_t = dispatch_queue_create("com.mjoptimizer.myQueue", nil)
        videoDataOutput.alwaysDiscardsLateVideoFrames = true
        videoDataOutput.setSampleBufferDelegate(self, queue: queue)
       
        // ビデオ入力のAVCaptureConnectionを取得
        //var videoConnection: AVCaptureConnection = videoDataOutput.connectionWithMediaType(AVMediaTypeVideo)
        // 1秒あたり4回画像をキャプチャ
        //videoConnection.videoMinFrameDuration = CMTimeMake(1, 4);
        
        // 入力と出力からキャプチャーセッションを作成
        //session.sessionPreset = AVCaptureSessionPresetMedium
        session.sessionPreset = AVCaptureSessionPresetPhoto
        session.addInput(deviceInput as AVCaptureInput)
        session.addOutput(videoDataOutput)
        
        session.startRunning()
    }
    
    func findCamera() -> Bool {
        let devices: NSArray = AVCaptureDevice.devices()
        
        // find back camera
        for device: AnyObject in devices {
            if device.position == AVCaptureDevicePosition.Back {
                captureDevice = device as? AVCaptureDevice
            }
        }
        
        if captureDevice {
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
    
    func buttonDidPush() {
        println("buttonDidPudh")
        isFinishAnalyze = true
        println("isFinishAnalyze = \(isFinishAnalyze)")
        setHeaderLabel()
        setFooterLabel()
        setBody()
        viewMjImages()
    }
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, fromConnection connection: AVCaptureConnection!) {
        NSThread.sleepForTimeInterval(1)
        dispatch_async( dispatch_get_main_queue() ) {
            
            if self.isFinishAnalyze {
                // Display SutehaiSelectResult
                var targetFrame = CGRectMake(30, 250, 260, 200)
                var sutehaiSelectResult = ControllerMock().sutehaiSelect(sampleBuffer, targetFrame: targetFrame)
                var sutehaiCandidateList = sutehaiSelectResult.getSutehaiCandidateList()
                
                self.label.text = "\(sutehaiCandidateList[0].pai.type.toRaw()) の \(sutehaiCandidateList[0].pai.number) を切ると向聴数は \(String(sutehaiSelectResult.getTehaiShantenNum()))になります"
                self.label.setNeedsDisplay()
            } else {
                let now: NSDate = NSDate()
                println(now)
                println("update from captureOutput()")
                self.label.text = now.description
                self.label.setNeedsDisplay()
            }
        }
    }
    
    func setBody() {
        let pai1 = Pai(type: PaiType.MANZU, number: 3)
        let pai2 = Pai(type: PaiType.MANZU, number: 6)
        let pai3 = Pai(type: PaiType.MANZU, number: 9)
        
        let paiStrArray = [ViewUtils.convertImageFromPai(pai1),
                           ViewUtils.convertImageFromPai(pai2),
                           ViewUtils.convertImageFromPai(pai3)]
        
        drowMjImages(15, 45, paiStrArray)
        
        totalNumLabel.center = CGPointMake(150, 70)
        totalNumLabel.textColor = UIColor.blackColor()
        totalNumLabel.text = "15"
        view.addSubview(totalNumLabel)
        
        shantenNumLabel.center = CGPointMake(270, 70)
        shantenNumLabel.textColor = UIColor.blackColor()
        shantenNumLabel.text = "3"
        view.addSubview(shantenNumLabel)
        
    }
    
    func setHeaderLabel() {
        headerLabel.font = UIFont(name: "HiraKakuProN-W6", size: 15)
        headerLabel.center = CGPointMake(150, 50)
        headerLabel.textAlignment = NSTextAlignment.Center
        headerLabel.textColor = UIColor.redColor()
        headerLabel.text = "受入牌種       総枚数   シャンテン数"
        
        view.addSubview(headerLabel)
    }
    
    func setFooterLabel() {
        var shantenNum = 3
        footerLabel.font = UIFont(name: "HiraKakuProN-W6", size: 15)
        footerLabel.center = CGPointMake(200, 520)
        footerLabel.textAlignment = NSTextAlignment.Center
        footerLabel.textColor = UIColor.redColor()
        footerLabel.text = "現在のシャンテン数は \(shantenNum)"
        
        view.addSubview(footerLabel)
    }
    
    func viewMjImages() {
        let paiStrArray = ["MJw1", "MJw2", "MJw3",
                            "MJw4", "MJw5", "MJw6",
                            "MJs1", "MJs2", "MJs3",
                            "MJd1", "MJd1", "MJd1",
                            "MJf1", "MJf1"]
        drowMjImages(5, 200, paiStrArray)
    }
    
    func drowMjImages(x: CGFloat, _ y: CGFloat, _ strArray: String[]) {
        var width: CGFloat = 700
        var height: CGFloat = 200
        var imageX: CGFloat = 10
        var imageY: CGFloat = 30
        var deltaX: CGFloat = 44
        
        UIGraphicsBeginImageContext(CGSizeMake(width, height))
        
        for pai in strArray  {
            let imagePath = NSBundle.mainBundle().pathForResource(pai, ofType: "png")
            let image: UIImage = UIImage(contentsOfFile: imagePath)
            image.drawAtPoint(CGPointMake(imageX, imageY))
            imageX += deltaX
        }
        let paiImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        let backImage = UIImageView(image: paiImage)
        // UIGraphicsBeginImageContextの半分の値を指定することで、牌画像を1/2に縮小する
        backImage.frame = CGRectMake(x, y, width / 2, height / 2)
        view.addSubview(backImage)
    }
}