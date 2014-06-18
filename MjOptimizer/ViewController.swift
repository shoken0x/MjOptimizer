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
    
    var videoInput: AVCaptureDeviceInput!
    var videoDataOutput: AVCaptureVideoDataOutput!
    var session: AVCaptureSession!
    var previewImageView: UIImageView!
    var captureDevice: AVCaptureDevice!
    var label: UILabel = UILabel(frame: CGRectMake(100, 50, 220, 30))
    
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
    }
    
    func setPreview(session: AVCaptureSession) {
        var previewLayer: AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer.layerWithSession(session) as AVCaptureVideoPreviewLayer
        previewLayer.frame = view.bounds
        
        view.layer.addSublayer(previewLayer)
    }
    
    func setOverlayView() {
        var overlayImageView: UIImageView = UIImageView(image: UIImage(named: "overlaygraphic.png"))
        overlayImageView.frame = CGRectMake(30, 250, 260, 200)
        
        label.center = CGPointMake(160, 184)
        label.textAlignment = NSTextAlignment.Center
        label.textColor = UIColor.redColor()
        label.text = "scanning ..."
        
        label.setNeedsDisplay()
        view.addSubview(label)
        view.addSubview(overlayImageView)
        view.updateConstraints()
    }
    
    func setuptAVCapture(captureDevice: AVCaptureDevice) {
        // init device input
        // init device input
        var error: NSErrorPointer!
        var deviceInput: AVCaptureInput = AVCaptureDeviceInput.deviceInputWithDevice(captureDevice, error: error) as AVCaptureInput
        
        
        // ビデオ出力のキャプチャの画像情報のキューを設定
        var queue: dispatch_queue_t = dispatch_queue_create("com.mjoptimizer.myQueue", nil)
        videoDataOutput = AVCaptureVideoDataOutput()
        videoDataOutput.alwaysDiscardsLateVideoFrames = true
        videoDataOutput.setSampleBufferDelegate(self, queue: queue)
       
        // ビデオ入力のAVCaptureConnectionを取得
        //var videoConnection: AVCaptureConnection = videoDataOutput.connectionWithMediaType(AVMediaTypeVideo)
        // 1秒あたり4回画像をキャプチャ
        //videoConnection.videoMinFrameDuration = CMTimeMake(1, 4);
        
        // 入力と出力からキャプチャーセッションを作成
        session = AVCaptureSession()
        //session.sessionPreset = AVCaptureSessionPresetMedium
        session.sessionPreset = AVCaptureSessionPresetPhoto
        session.addInput(deviceInput as AVCaptureInput)
        session.addOutput(videoDataOutput)
        
        session.startRunning()
    }
    
    func findCamera() -> Bool {
        var devices: NSArray = AVCaptureDevice.devices()
        
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
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, fromConnection connection: AVCaptureConnection!) {
        
        NSThread.sleepForTimeInterval(1)
        dispatch_async( dispatch_get_main_queue() ) {
            var now: NSDate = NSDate()
            println(now)
            println("update from captureOutput()")
            self.label.text = now.description
            self.label.setNeedsDisplay()
        }
    }
}