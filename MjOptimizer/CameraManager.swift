//
//  CameraManager.swift
//  mjoptimizer
//
//  Created by Shoken Fujisaki on 6/12/14.
//  Copyright (c) 2014 Shoken Fujisaki. All rights reserved.
//

import Foundation
import AVFoundation
import CoreMedia

class CameraManager: NSObject, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    var stillImageOutput: AVCaptureStillImageOutput!
    var videoDataOutput: AVCaptureVideoDataOutput!
    var session: AVCaptureSession!
    
    init() { }
    
    func configureCamera() -> Bool {
        // init camera device
        var captureDevice: AVCaptureDevice?
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
        } else {
            println("Missing Camera")
            return false
        }
        
        // init device input
        var error: NSErrorPointer!
        var deviceInput: AVCaptureInput = AVCaptureDeviceInput.deviceInputWithDevice(captureDevice, error: error) as AVCaptureInput
        
        self.videoDataOutput = AVCaptureVideoDataOutput()
        
        self.videoDataOutput.alwaysDiscardsLateVideoFrames = true
        var queue: dispatch_queue_t = dispatch_queue_create("com.overout223.myQueue", nil)
        videoDataOutput.setSampleBufferDelegate(self, queue: queue)
        //dispatch_release(queue)
        
        // init session
        self.session = AVCaptureSession()
        self.session.sessionPreset = AVCaptureSessionPresetPhoto
        self.session.addInput(deviceInput as AVCaptureInput)
        self.session.addOutput(self.videoDataOutput)
        
        self.session.startRunning()
        
        return true
    }
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, fromConnection connection: AVCaptureConnection!) {
        
        NSThread.sleepForTimeInterval(1)
        println("update")
    }
    
    func getClassName() -> NSString {
        return "CameraManager"
    }
}
