//
//  ClockFaceView.swift
//  ClockSliderLibraryClientiOS
//
//  Created by Jason Cross on 2024-10-27.
//

import UIKit
import ClockSliderLibrary

class ClockFaceView: UIView {
    var underlyingClockFaceView: CrossPlatformClockFaceView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.underlyingClockFaceView = CrossPlatformClockFaceView(_frame: self.bounds, _ringWidth: 44.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.underlyingClockFaceView = CrossPlatformClockFaceView(_frame: self.bounds, _ringWidth: 44.0)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
                
        guard let ctx = UIGraphicsGetCurrentContext(),
              let underlyingView = self.underlyingClockFaceView else {
            return
        }
        
        underlyingView.draw(rect, context: ctx)
    }
}
