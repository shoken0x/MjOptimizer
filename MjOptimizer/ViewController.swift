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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var cameraManager = CameraManager()
        var session: AVCaptureSession
        
        if cameraManager.configureCamera() {
            session = cameraManager.session
            self.setPreview(session)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setPreview(session: AVCaptureSession) {
        var previewLayer: AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer.layerWithSession(session) as AVCaptureVideoPreviewLayer
        previewLayer.frame = self.view.bounds
        self.view.layer.addSublayer(previewLayer)
    }
}

