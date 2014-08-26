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
    let label = UILabel(frame: CGRectMake(100, 60, 300, 30))
    let headerLabel = UILabel(frame: CGRectMake(0, 0, 500, 30))
    let footerLabel = UILabel(frame: CGRectMake(200, 200, 300, 30))
    let debugButton = UIButton.buttonWithType(UIButtonType.DetailDisclosure) as UIButton
    let startButton = UIButton.buttonWithType(UIButtonType.DetailDisclosure) as UIButton
    let rescanButton = UIButton.buttonWithType(UIButtonType.DetailDisclosure) as UIButton
    let logView = UITextView(frame: CGRectMake(460, 20, 150, 100))
    let filterView = UIView(frame: CGRectMake(0, 0, 568, 320))
    let resultView = UIView(frame: CGRectMake(0, 0, 568, 130))
    let animationView = UIImageView(frame: CGRectMake(24, 100, 100, 100))
    let targetFrame = CGRectMake(24, 130, 520, 50)
    let systemStats = Stats()
    let controller = Controller()
    
    var scanCounter = 0
    var log = "START SCAN..."
    var captureDevice: AVCaptureDevice!
    var isFinishAnalyze = false
    var isScan = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        debugPrintln("bounds.size.height = \(view.bounds.size.height)")
        debugPrintln("bounds.size.width = \(view.bounds.size.width)")
        if findCamera() {
            setuptAVCapture(captureDevice)
            setPreview(session)
        }
        setOverlayView()
        
        //局状況入力
        view.addSubview(KyokuView())

    }
    
    func setPreview(session: AVCaptureSession) {
        let previewLayer: AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer.layerWithSession(session) as AVCaptureVideoPreviewLayer
        previewLayer.connection.videoOrientation = AVCaptureVideoOrientation.LandscapeLeft
        previewLayer.frame = view.bounds
        view.layer.addSublayer(previewLayer)
    }
        
    func setOverlayView() {
        let overlayImageView: UIImageView = UIImageView(image: UIImage(named:"RedRectangle"))
        overlayImageView.frame = targetFrame
        
        debugButton.frame = CGRectMake(290, 0, 200, 100)
        debugButton.setTitle("DisplayResults", forState: UIControlState.Normal)
        debugButton.addTarget(self, action: "debugButtonDidPush", forControlEvents: UIControlEvents.TouchUpInside)
        //view.addSubview(debugButton)
        
        startButton.frame = CGRectMake(290, 30, 200, 100)
        startButton.setTitle("START SCAN...", forState: UIControlState.Normal)
        startButton.addTarget(self, action: "startButtonDidPush", forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(startButton)
        
        rescanButton.frame = CGRectMake(385, 165, 200, 100)
        rescanButton.setTitle("RESCAN", forState: UIControlState.Normal)
        rescanButton.addTarget(self, action: "rescanButtonDidPush", forControlEvents: UIControlEvents.TouchUpInside)
        rescanButton.hidden = true
        view.addSubview(rescanButton)
        
        label.center = CGPointMake(420, 300)
        label.textAlignment = NSTextAlignment.Center
        label.textColor = UIColor.redColor()
        label.text = "I'm waiting for..."
        
        view.addSubview(label)
        view.addSubview(overlayImageView)
    }
    
    func setuptAVCapture(captureDevice: AVCaptureDevice) {
        // init device input
        var error: NSErrorPointer!
        let deviceInput: AVCaptureInput = AVCaptureDeviceInput.deviceInputWithDevice(captureDevice, error: error) as AVCaptureInput
        
        var queue: dispatch_queue_t = dispatch_queue_create("com.mjoptimizer.myQueue", nil)
        let settings = [kCVPixelBufferPixelFormatTypeKey: kCVPixelFormatType_32BGRA]
        videoDataOutput.videoSettings = settings
        
        videoDataOutput.alwaysDiscardsLateVideoFrames = true
        videoDataOutput.setSampleBufferDelegate(self, queue: queue)
        
       

        //var videoConnection: AVCaptureConnection = videoDataOutput.connectionWithMediaType(AVMediaTypeVideo)
        //videoConnection.videoMinFrameDuration = CMTimeMake(1, 4);
        
        //session.sessionPreset = AVCaptureSessionPresetMedium
        //session.sessionPreset = AVCaptureSessionPresetHigh
        //session.sessionPreset = AVCaptureSessionPresetPhoto
        //session.sessionPreset = AVCaptureSessionPreset1280x720
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


    func debugButtonDidPush() {
        isFinishAnalyze = true
        animationView.removeFromSuperview()
        filterView.removeFromSuperview()
        setHeaderLabel()
        setFooterLabel(99)
        debugButton.hidden = true
        rescanButton.hidden = false
    }
    
    func startButtonDidPush() {
        isScan = true
        startButton.hidden = true
        label.text = "scanning ..."
        setFilterView()
        focusOn()
        setLogView()
    }
    
    func rescanButtonDidPush() {
        debugPrintln("RESCAN START")
        rescanButton.hidden = true
        debugButton.hidden = false
        isFinishAnalyze = false
        for subview in view.subviews as [UIView] {
            subview.removeFromSuperview()
        }
        setFilterView()
        setOverlayView()
        focusOn()
        setLogView()
        session.startRunning()
    }
    
    func imageSaved() {
        debugPrintln("image saved!")
    }
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, fromConnection connection: AVCaptureConnection!) {
        NSThread.sleepForTimeInterval(0.5)
        let now: NSDate = NSDate()
        println(now)
        println("update from captureOutput()")
        var sutehaiSelectResult: SutehaiSelectResult!
        
//        dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0)) {
//            if self.isScan {
//                sutehaiSelectResult = self.controller.sutehaiSelect(sampleBuffer, targetFrame: self.targetFrame)
//                self.isFinishAnalyze = sutehaiSelectResult.isFinishAnalyze
//            }
//        }
        dispatch_async( dispatch_get_main_queue() ) {
            if self.isScan {
                var sutehaiSelectResult = self.controller.sutehaiSelect(sampleBuffer, targetFrame: self.targetFrame)
                self.isFinishAnalyze = sutehaiSelectResult.isFinishAnalyze
                if self.isFinishAnalyze {
                    // Display SutehaiSelectResult
                    var sutehaiCandidateList = sutehaiSelectResult.getSutehaiCandidateList()
                    self.label.text = "Finish scan."
                    self.drawMjImages(27, 205, sutehaiSelectResult.tehai, 0.8)
                    self.setBody(sutehaiCandidateList)
                    self.animationView.removeFromSuperview()
                    self.filterView.removeFromSuperview()
                    self.setHeaderLabel()
                    //self.setFooterLabel(sutehaiSelectResult.tehaiShantenNum!)
                
                    self.session.stopRunning()
                    self.startButton.hidden = true
                    self.rescanButton.hidden = false
                } else {
                    println("update view")
                    self.label.text = now.description
                    self.logView.text = self.logView.text.stringByAppendingString("\(self.systemStats.updateStates())")
                    var range = self.logView.selectedRange
                    range.location = self.logView.text.length
                    self.logView.scrollEnabled = false
                    self.logView.scrollRangeToVisible(range)
                    self.logView.scrollEnabled = true
                }
            }
        }
    }
    
    func setBody(sutehaiCandidateList: [SutehaiCandidate]) {
        setResultView()
        var x: CGFloat = 5
        var y: CGFloat = 15
        var limit = 3
        var i = 0
        for sutehaiCandidate: SutehaiCandidate in sutehaiCandidateList {
            drawMjImages(x, y, [sutehaiCandidate.pai])
            drawMjImages(x + 50, y,
                sutehaiCandidate.getUkeirePaiToPaiList())
            let totalNumLabel =   UILabel(frame: CGRectMake(x + 215, y + 15, 20, 20))
            totalNumLabel.textColor = UIColor.greenColor()
            totalNumLabel.text = String(sutehaiCandidate.getUkeireTotalNum())
            view.addSubview(totalNumLabel)
            
            let shantenNumLabel = UILabel(frame: CGRectMake(x + 305, y + 15, 20, 20))
            shantenNumLabel.textColor = UIColor.greenColor()
            shantenNumLabel.text = String(sutehaiCandidate.getShantenNum())
            view.addSubview(shantenNumLabel)
            y += 30
            i += 1
            if i > limit { break }
        }
    }
    
    func setLogView() {
        logView.scrollEnabled = false
        logView.editable = false
        logView.textAlignment = NSTextAlignment.Left
        logView.font = UIFont(name: "Courier", size: 13)
        logView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.0)
        logView.textColor = UIColor.greenColor()
        logView.text = log
        view.addSubview(logView)
    }
    
    
    func drawMjImages(x: CGFloat, _ y: CGFloat, _ paiArray: [Pai], _ rate: CGFloat = 0.5) {
        var width:  CGFloat = 700
        var height: CGFloat = 200
        var imageX: CGFloat = 10
        var imageY: CGFloat = 30
        var deltaX: CGFloat = 44
        
        UIGraphicsBeginImageContext(CGSizeMake(width, height))
        
        for pai in paiArray  {
            let image: UIImage = UIImage(named:pai.toString())
            image.drawAtPoint(CGPointMake(imageX, imageY))
            imageX += deltaX
        }
        let paiImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        let backImage = UIImageView(image: paiImage)
        backImage.frame = CGRectMake(x, y, width * rate, height * rate)
        view.addSubview(backImage)
    }
    
    func focusOn() {
        let imgArray = NSArray(array: [UIImage(named:"circle01"),
                                       UIImage(named:"circle02"),
                                       UIImage(named:"circle03")])
        
        animationView.animationImages = imgArray
        animationView.animationDuration = 0.5
        animationView.startAnimating()
        view.addSubview(animationView)
    }
    
    func setFilterView() {
        filterView.backgroundColor = UIColor(red: 1.0, green: 0, blue: 0, alpha: 0.1)
        view.addSubview(filterView)
    }
    
    func setResultView() {
        resultView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        view.addSubview(resultView)
    }
    
    func setHeaderLabel() {
        headerLabel.font = UIFont(name: "HiraKakuProN-W6", size: 15)
        headerLabel.textColor = UIColor.redColor()
        headerLabel.text = "  捨牌      受入牌種                総枚数         シャンテン数"
        
        view.addSubview(headerLabel)
    }
    
    func setFooterLabel(shantenNum: Int) {
        footerLabel.font = UIFont(name: "HiraKakuProN-W6", size: 15)
        footerLabel.textAlignment = NSTextAlignment.Center
        footerLabel.textColor = UIColor.redColor()
        footerLabel.text = "現在のシャンテン数は \(shantenNum)"
        
        view.addSubview(footerLabel)
    }
}