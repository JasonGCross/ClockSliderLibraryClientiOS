//
//  ThumbnailView.swift
//  ClockSliderLibraryClientiOS
//
//  Created by Jason Cross on 2024-10-29.
//

import UIKit
import ClockSliderLibrary

class ThumbnailView: UIView {
    var underlyingThumbnailView: CrossPlatformThumbnailView?
    
    init(_frame: CGRect,
         _ringWidth: CGFloat,
         _clockRadius: CGFloat,
         _thumnailImage: UIImage? = nil,
         _thumbnailColor: UIColor? = nil) {
        super.init(frame: _frame)
        self.isOpaque = false
        
        let thumnailImage: CGImage? = _thumnailImage?.cgImage
        let thumbnailColor: CGColor? = _thumbnailColor?.cgColor
        underlyingThumbnailView = CrossPlatformThumbnailView(_frame: _frame,
                                                             _ringWidth: _ringWidth,
                                                             _clockRadius: _clockRadius,
                                                             _thumbnailImage: thumnailImage,
                                                             _thumbnailColor: thumbnailColor)
    }
    
    override init(frame: CGRect) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setDrawableEndAngle(_ endAngle: CGFloat) {
        underlyingThumbnailView?.drawableEndAngle = endAngle
        self.setNeedsDisplay(self.bounds)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
                
        guard let ctx = UIGraphicsGetCurrentContext(),
              let underlyingView = self.underlyingThumbnailView else {
            return
        }
        
        underlyingView.draw(rect, context: ctx)
    }
}
