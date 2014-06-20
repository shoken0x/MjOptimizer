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
    let headerLabel = UILabel(frame: CGRectMake(10, 10, 300, 30))
    let footerLabel = UILabel(frame: CGRectMake(10, 10, 300, 30))
    let totalNumLabel =   UILabel(frame: CGRectMake(10, 10, 30, 30))
    let shantenNumLabel = UILabel(frame: CGRectMake(10, 10, 30, 30))
    let debugButton = UIButton.buttonWithType(UIButtonType.DetailDisclosure) as UIButton
    let rescanButton = UIButton.buttonWithType(UIButtonType.DetailDisclosure) as UIButton
    let logView = UITextView(frame: CGRectMake(400, 20, 190, 100))
    let filterView = UIView(frame: CGRectMake(0, 0, 568, 320))
    let animationView = UIImageView(frame: CGRectMake(24, 100, 100, 100))
    
    var log = "START SCAN..."
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
        debugPrintln("bounds.size.height = \(view.bounds.size.height)")
        debugPrintln("bounds.size.width = \(view.bounds.size.width)")
        if findCamera() {
            setuptAVCapture(captureDevice)
            setPreview(session)
        }
        setFilterView()
        setOverlayView()
        focusOn()
        setLogView()

    }
    
    func setPreview(session: AVCaptureSession) {
        let previewLayer: AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer.layerWithSession(session) as AVCaptureVideoPreviewLayer
        previewLayer.connection.videoOrientation = AVCaptureVideoOrientation.LandscapeLeft
        previewLayer.frame = view.bounds
        view.layer.addSublayer(previewLayer)
    }
        
    func setOverlayView() {
        let overlayImageView: UIImageView = UIImageView(image: UIImage(named: "redrect.png"))
        overlayImageView.frame = CGRectMake(24, 130, 520, 100)
        
        debugButton.frame = CGRectMake(240, 30, 200, 100)
        debugButton.setTitle("DisplayResults", forState: UIControlState.Normal)
        debugButton.addTarget(self, action: "debugButtonDidPush", forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(debugButton)
        
        rescanButton.frame = CGRectMake(240, 50, 200, 100)
        rescanButton.setTitle("RESCAN", forState: UIControlState.Normal)
        rescanButton.addTarget(self, action: "rescanButtonDidPush", forControlEvents: UIControlEvents.TouchUpInside)
        rescanButton.hidden = true
        view.addSubview(rescanButton)
        
        label.center = CGPointMake(420, 270)
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
        
        var queue: dispatch_queue_t = dispatch_queue_create("com.mjoptimizer.myQueue", nil)
        videoDataOutput.alwaysDiscardsLateVideoFrames = true
        videoDataOutput.setSampleBufferDelegate(self, queue: queue)
       

        //var videoConnection: AVCaptureConnection = videoDataOutput.connectionWithMediaType(AVMediaTypeVideo)
        //videoConnection.videoMinFrameDuration = CMTimeMake(1, 4);
        
        //session.sessionPreset = AVCaptureSessionPresetMedium
        session.sessionPreset = AVCaptureSessionPresetHigh
        //session.sessionPreset = AVCaptureSessionPresetPhoto
        //session.sessionPreset = AVCaptureSessionPreset1280x720
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
    
    func debugButtonDidPush() {
        isFinishAnalyze = true
        animationView.removeFromSuperview()
        filterView.removeFromSuperview()
        setHeaderLabel()
        setFooterLabel()
        setBody()
        viewMjImages()
        debugButton.hidden = true
        rescanButton.hidden = false
    }
    
    func rescanButtonDidPush() {
        isFinishAnalyze = false
        for subview: UIView! in view.subviews {
            subview.removeFromSuperview()
        }
        setFilterView()
        setOverlayView()
        focusOn()
        setLogView()
        rescanButton.hidden = true
        debugButton.hidden = false
    }
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, fromConnection connection: AVCaptureConnection!) {
        NSThread.sleepForTimeInterval(0.2)
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
                
                self.logView.text = self.logView.text.stringByAppendingString("\n\(now.description)")
                var range = self.logView.selectedRange
                range.location = self.logView.text.length
                self.logView.scrollEnabled = false
                self.logView.scrollRangeToVisible(range)
                self.logView.scrollEnabled = true
                self.logView.setNeedsDisplay()
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
        totalNumLabel.textColor = UIColor.whiteColor()
        totalNumLabel.text = "15"
        view.addSubview(totalNumLabel)
        
        shantenNumLabel.center = CGPointMake(270, 70)
        shantenNumLabel.textColor = UIColor.whiteColor()
        shantenNumLabel.text = "3"
        view.addSubview(shantenNumLabel)
        
    }
    
    func setLogView() {
        logView.scrollEnabled = false
        logView.editable = false
        logView.textAlignment = NSTextAlignment.Left
        logView.font = UIFont(name: "Helvetica", size: 14)
        logView.backgroundColor = UIColor(red: 1.0, green: 0, blue: 0, alpha: 0.3)
        logView.textColor = UIColor.whiteColor()
        logView.text = log
        view.addSubview(logView)
    }
    
    func viewMjImages() {
        let paiStrArray = ["MJw1", "MJw2", "MJw3",
                            "MJw4", "MJw5", "MJw6",
                            "MJs1", "MJs2", "MJs3",
                            "MJd1", "MJd1", "MJd1",
                            "MJf1", "MJf1"]
        drowMjImages(27, 180, paiStrArray, 0.8)
    }
    
    func drowMjImages(x: CGFloat, _ y: CGFloat, _ strArray: String[], _ rate: CGFloat = 0.5) {
        var width:  CGFloat = 700
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
        backImage.frame = CGRectMake(x, y, width * rate, height * rate)
        view.addSubview(backImage)
    }
    
    func focusOn() {
        let imgArray = NSArray(array: [UIImage(named:"circle01.png"),
                                       UIImage(named:"circle02.png"),
                                       UIImage(named:"circle03.png")])
        
        animationView.animationImages = imgArray
        animationView.animationDuration = 0.5
        animationView.startAnimating()
        view.addSubview(animationView)
    }
    
    func setFilterView() {
        filterView.backgroundColor = UIColor(red: 1.0, green: 0, blue: 0, alpha: 0.1)
        view.addSubview(filterView)
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
}