//
//  ClockSliderView.swift
//  ClockSliderLibraryClientiOS
//
//  Created by Jason Cross on 2024-10-28.
//

import UIKit
import ClockSliderLibrary

class ClockSliderView: UIView {
    var underlyingClockSliderView: CrossPlatformClockSliderView?
    private var viewModel: ClockSliderViewModel
    
    init(_frame: CGRect,
         _ringWidth: CGFloat,
         _sliderStartAngle: CGFloat,
         _sliderEndAngle: CGFloat,
         _clockType: ClockType,
         _clockRotationCount: ClockRotationCount) {
        
        
        
        let screenScale = UIScreen.main.scale
        viewModel = ClockSliderViewModel(
            _frame: _frame,
            _clockType: _clockType,
            _ringWidth: _ringWidth,
            _sliderStartAngle: _sliderStartAngle,
            _sliderEndAngle: _sliderEndAngle,
            _clockRotationCount: _clockRotationCount,
            _screenScale: screenScale)
        self.underlyingClockSliderView = CrossPlatformClockSliderView(
            viewModel: viewModel)
        
        super.init(frame: _frame)
        self.isOpaque = false // very important, otherwise a black rectangle obscures everything underneath
        // alternatively, could set
        // self.backgroundColor = UIColor.clear
        // which would have the same effect
    }
    
    override init(frame: CGRect) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func originForThumbnail(minutes: Int) -> CGPoint {
        return self.viewModel.originForThumbnail(minutes)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
                
        guard let ctx = UIGraphicsGetCurrentContext(),
              let underlyingView = self.underlyingClockSliderView else {
            return
        }
        
        underlyingView.draw(rect, context: ctx)
    }
}
