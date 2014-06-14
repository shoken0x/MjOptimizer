//
//  ViewController.swift
//  mjoptimizer
//
//  Created by Shoken Fujisaki on 6/12/14.
//  Copyright (c) 2014 Shoken Fujisaki. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    var debugLabel: UILabel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        var cameraManager = CameraManager()
        var session: AVCaptureSession
        
        if cameraManager.configureCamera() {
            session = cameraManager.session
            self.setPreview(session)
        }
        self.setOverlayView()
        cameraManager.setLabel(self.debugLabel)
        self.setUILabel()
    }
    
    func setPreview(session: AVCaptureSession) {
        var previewLayer: AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer.layerWithSession(session) as AVCaptureVideoPreviewLayer
        previewLayer.frame = self.view.bounds
        
        println(NSStringFromCGRect(self.view.bounds))
        
        self.view.layer.addSublayer(previewLayer)
    }
    
    func setOverlayView() {
        var overlayImageView: UIImageView = UIImageView(image: UIImage(named: "overlaygraphic.png"))
        overlayImageView.frame = CGRectMake(30, 250, 260, 200)
        
        self.view.addSubview(overlayImageView)
    }
    
    func setUILabel() {
        self.debugLabel = UILabel(frame: CGRectMake(100, 50, 120, 30))
        self.debugLabel.center = CGPointMake(160, 184)
        self.debugLabel.textAlignment = NSTextAlignment.Center
        self.debugLabel.textColor = UIColor.redColor()
        self.debugLabel.text = "I'am a test label"
        
        self.view.addSubview(debugLabel)
    }
}