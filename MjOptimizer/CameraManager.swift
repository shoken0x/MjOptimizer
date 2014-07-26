//
//  CameraManager.swift
//  mjoptimizer
//
//  Created by Shoken Fujisaki on 6/12/14.
//  Copyright (c) 2014 Shoken Fujisaki. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import CoreMedia

public class CameraManager: NSObject, AVCaptureVideoDataOutputSampleBufferDelegate {
    public init() {
        return super.init()
    }
    
    // for just test
    public func getClassName() -> NSString {
        return "CameraManager"
    }
}
