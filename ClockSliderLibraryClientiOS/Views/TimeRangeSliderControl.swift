//
//  TimeRangeSliderControl.swift
//  ClockSliderLibraryClientiOS
//
//  Created by Jason Cross on 2025-01-04.
//

import UIKit
import ClockSliderLibrary

class TimeRangeSliderControl: UIView {
    var underlyingTimeRangeSliderControl: CrossPlatformTimeRangeSliderControl?
    
    //MARK:- subviews
    var clockFaceView : ClockFaceView?
    var clockSliderView: ClockSliderView?
    var startKnobView: ThumbnailView?
    var finishKnobView: ThumbnailView?
    
    /**
     * The color used in lieu of a thumbnail icon where the user places a finger to
     * drag the start location of the time range control.
     */
    var startThumbColor: UIColor = UIColor.systemBlue {
        willSet {
            self.underlyingTimeRangeSliderControl?.startKnobView?.thumbnailColor = newValue.cgColor
        }
    }
    
    
    /**
     * One of two colors which comprise the gradient used to fill the slider track.
     * The track uses this primary color scheme when the time span is between 0 and 12 hours.
     * This color is closest to the finish position.
     */
    @IBInspectable
    var firstDayGradientFinishColor : UIColor = UIColor(red: 0.965,
                                                        green: 0.965,
                                                        blue: 0.065,
                                                        alpha: 1.00) {
        willSet {
            self.underlyingTimeRangeSliderControl?.firstDayGradientFinishColor = newValue.cgColor
        }
    }
    
    /**
     * One of two colors which comprise the gradient used to fill the slider track.
     * The track switches to this alternate color scheme when the time span is between 12 and 24 hours.
     * This color is closest to the start position.
     */
    @IBInspectable
    var secondDayGradientStartColor : UIColor = UIColor(red: 0.072,
                                                        green: 0.878,
                                                        blue: 0.087,
                                                        alpha: 1.00) {
        willSet {
            self.underlyingTimeRangeSliderControl?.secondDayGradientStartColor = newValue.cgColor
        }
    }
    
    /**
     * One of two colors which comprise the gradient used to fill the slider track.
     * The track switches to this alternate color scheme when the time span is between 12 and 24 hours.
     * This color is closest to the finish position.
     */
    @IBInspectable
    var secondDayGradientFinishColor : UIColor = UIColor(red: 0.833,
                                                         green: 0.994,
                                                         blue: 0.342,
                                                         alpha: 1.00) {
        willSet {
            self.underlyingTimeRangeSliderControl?.secondDayGradientFinishColor = newValue.cgColor
        }
    }
    
    //MARK: - helpers
    internal func updateThumbLayers() -> Void {
        guard let safeSliderView = self.clockSliderView,
              let safeStartKnobView = self.startKnobView,
              let safeFinishKnobView = self.finishKnobView,
              let safeUnderlyingTimeRangeSliderControl = self.underlyingTimeRangeSliderControl else {
            return
        }
        
        let startMinutes = safeUnderlyingTimeRangeSliderControl.getStartTime().totalMinutes
        let finishMinutes = safeUnderlyingTimeRangeSliderControl.getFinishTime().totalMinutes
        let originForStartSlider = safeSliderView.originForThumbnail(minutes: startMinutes)
        let originForFinishSlider = safeSliderView.originForThumbnail(minutes: finishMinutes)
        safeStartKnobView.frame.origin = originForStartSlider
        safeFinishKnobView.frame.origin = originForFinishSlider
        
//        let clockRotationCount = safeUnderlyingTimeRangeSliderControl.getClockRotationCount()
//        let useFirstRotationColors = (clockRotationCount == .first)
//        let finishColor = useFirstRotationColors ? self.firstDayGradientFinishColor : self.secondDayGradientFinishColor
//        
//        let sliderEndAngle = safeUnderlyingTimeRangeSliderControl.getSliderEndAngle()
//        safeFinishKnobView.setDrawableEndAngle(sliderEndAngle)
//        self.startThumbColor = finishColor
        safeFinishKnobView.setNeedsDisplay(safeFinishKnobView.bounds)
        safeStartKnobView.setNeedsDisplay(safeStartKnobView.bounds)
        
        // drawing order should take into account which end is highlighted
        // note: last drawn is on top (higher Z-index)
        if ((safeUnderlyingTimeRangeSliderControl.viewModel.lastDraggedThumbKnob == HighlightedKnob.finish) &&
            (safeUnderlyingTimeRangeSliderControl.viewModel.thumbWithHigherZIndex != HighlightedKnob.finish)) {
            safeFinishKnobView.layer.removeFromSuperlayer()
            safeStartKnobView.layer.removeFromSuperlayer()
            self.layer.addSublayer(safeStartKnobView.layer)
            self.layer.addSublayer(safeFinishKnobView.layer)
            safeUnderlyingTimeRangeSliderControl.viewModel.thumbWithHigherZIndex = HighlightedKnob.finish
        }
        else if ((safeUnderlyingTimeRangeSliderControl.viewModel.lastDraggedThumbKnob == HighlightedKnob.start) &&
                  (safeUnderlyingTimeRangeSliderControl.viewModel.thumbWithHigherZIndex != HighlightedKnob.start)) {
            safeFinishKnobView.layer.removeFromSuperlayer()
            safeStartKnobView.layer.removeFromSuperlayer()
            self.layer.addSublayer(safeFinishKnobView.layer)
            self.layer.addSublayer(safeStartKnobView.layer)
            safeUnderlyingTimeRangeSliderControl.viewModel.thumbWithHigherZIndex = HighlightedKnob.start
        }
    }
}
