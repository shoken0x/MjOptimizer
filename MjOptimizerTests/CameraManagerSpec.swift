//
//  CameraManagerSpec.swift
//  MjOptimizer
//
//  Created by Shoken Fujisaki on 6/14/14.
//  Copyright (c) 2014 Shoken Fujisaki. All rights reserved.
//

import MjOptimizer
import Quick
import Nimble

class CameraManagerSpec: QuickSpec {
    override func spec() {
        describe("CameraManager") {
            var cameraManager = CameraManager()
            beforeEach { }
            
            describe("get class name") {
                it("returns class name") {
                    expect(cameraManager.getClassName()).to.equal("CameraManager")
                }
            }
        }
    }
}