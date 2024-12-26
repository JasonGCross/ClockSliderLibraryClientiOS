//
//  ViewController.swift
//  ClockSliderLibraryClientiOS
//
//  Created by Jason Cross on 2024-10-27.
//

import UIKit
import ClockSliderLibrary

class ViewController: UIViewController {

    @IBOutlet var customViewContainer: UIView!
    var clockFaceView: ClockFaceView!
    var clockSliderView: ClockSliderView!
    var startKnobView: ThumbnailView!
    var finishKnobView: ThumbnailView!
    let ringWidth: CGFloat = 44.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sliderStartAngle = 0.0
        let sliderEndAngle = Double.pi/4

        self.clockFaceView = ClockFaceView(frame: self.customViewContainer.bounds)
        self.clockSliderView = ClockSliderView(
            _frame: self.customViewContainer.bounds,
            _ringWidth: 44.0,
            _sliderStartAngle: 0.0,
            _sliderEndAngle: Double.pi/4,
            _clockType: ClockType.twelveHourClock,
            _clockRotationCount: ClockRotationCount.first)
       
        
        let diameter = CGFloat(fminf(Float(view.frame.size.width),
                                     Float(view.frame.size.height)))
        let clockRadius = diameter / 2.0
        let startThumbnailOrigin = self.clockSliderView.originForThumbnail(minutes:0)
        let startThumbnailFrame = CGRect(x: startThumbnailOrigin.x, y: startThumbnailOrigin.y, width: ringWidth, height: ringWidth)
        
        self.startKnobView = ThumbnailView.init(_frame: startThumbnailFrame,
                                                _ringWidth: ringWidth,
                                                _clockRadius: clockRadius,
                                                _thumbnailColor: UIColor.red)
        self.startKnobView.setDrawableEndAngle(sliderStartAngle)
        
        let finishThumbnailOrigin = self.clockSliderView.originForThumbnail(minutes:90)
        let finishThumbnailFrame = CGRect(x: finishThumbnailOrigin.x, y: finishThumbnailOrigin.y, width: ringWidth, height: ringWidth)
        self.finishKnobView = ThumbnailView.init(_frame: finishThumbnailFrame,
                                                 _ringWidth: ringWidth,
                                                 _clockRadius: clockRadius,
                                                 _thumbnailColor: UIColor.green)
        self.finishKnobView.setDrawableEndAngle(sliderEndAngle)
        
        self.customViewContainer.addSubview(self.clockFaceView)
        self.customViewContainer.addSubview(self.clockSliderView)
        self.customViewContainer.addSubview(self.startKnobView)
        self.customViewContainer.addSubview(self.finishKnobView)
    }


}

