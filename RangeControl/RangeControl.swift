//
//  RangeControl.swift
//  Chart
//
//  Created by Alexey Ledovskiy on 3/12/19.
//  Copyright © 2019 Alexey Ledovskiy. All rights reserved.
//

import UIKit
import QuartzCore

class RangeControlThumbLayer: CALayer {
    private let arrowHeight = CGFloat(36.0/128.0)
    private let arrowWidth = CGFloat(16.0/32.0)
    
    var isLeft = false
    var highlighted: Bool = false

    override func action(forKey event: String) -> CAAction? {
        if(event == "position"){  return nil }
        return super.action(forKey: event)
    }
    
    weak var rangeControl: RangeControl?
    override func draw(in ctx: CGContext) {
        if let slider = rangeControl {
            let thumbFrame = bounds
            let path = UIBezierPath(roundedRect: thumbFrame, cornerRadius: 2)
            ctx.addPath(path.cgPath)
            
            //Thumb
            ctx.setFillColor( slider.thumbColor.cgColor)
            ctx.addPath(path.cgPath)
            ctx.fillPath()
            
            //Arrows
            let arrow = UIBezierPath()
            let center = CGPoint(x: bounds.width/2.0, y: bounds.height/2.0)
            let arrowSize = CGSize(width: bounds.width * arrowWidth/1.5, height: bounds.height * arrowHeight)
            let arrowRect = CGRect(x: center.x - arrowSize.width/2, y: center.y - arrowSize.height/2, width: arrowSize.width, height: arrowSize.height)
            
            if(!isLeft){
                arrow.move(to: arrowRect.origin)
                arrow.addLine(to: CGPoint(x: center.x + arrowSize.width/2.0, y: center.y))
                arrow.move(to:  CGPoint(x: center.x + arrowSize.width/2.0, y: center.y))
                arrow.addLine(to: CGPoint(x: arrowRect.origin.x, y: arrowRect.origin.y + arrowRect.height))
            }else{
                arrow.move(to: CGPoint(x: arrowRect.origin.x + arrowSize.width, y: arrowRect.origin.y))
                arrow.addLine(to: CGPoint(x: center.x - arrowSize.width/2.0, y: center.y))
                arrow.move(to: CGPoint(x: center.x - arrowSize.width/2.0, y: center.y))
                arrow.addLine(to: CGPoint(x: arrowRect.origin.x + arrowSize.width, y: arrowRect.origin.y + arrowRect.height))
            }
        
            ctx.setLineWidth(2.5)
            ctx.setLineCap(.round)
            ctx.setStrokeColor(UIColor.white.cgColor)
            ctx.addPath(arrow.cgPath)
            ctx.strokePath()
        }
    }
}

class RangeControlTrackLayer: CALayer {
    weak var rangeControl: RangeControl?
    override func action(forKey event: String) -> CAAction? {
        if(event == "position" || event == "contents"){ return nil }
        return super.action(forKey: event)
    }
    
    override func draw(in ctx: CGContext) {
        if let slider = rangeControl {
            //Tack
            let rectTrack = CGRect(x: 0, y: slider.margin, width: bounds.width, height: bounds.height - slider.margin*2)
            let path = UIBezierPath(rect: rectTrack)
            
            let lowerValuePosition = CGFloat(slider.positionForValue(slider.lowValue))
            let upperValuePosition = CGFloat(slider.positionForValue(slider.upValue))
            //Cut rect
            let rect = CGRect(x: lowerValuePosition - slider.thumbWidth/2.0, y: slider.margin, width: upperValuePosition - lowerValuePosition + slider.thumbWidth, height: bounds.height - slider.margin*2 )

            let cutout = UIBezierPath(rect: rect)
            path.append(cutout.reversing())
            ctx.addPath(path.cgPath)
            
            // Fill the track
            ctx.setFillColor( slider.trackColor.cgColor)
            ctx.addPath(path.cgPath)
            ctx.fillPath()
            
            //Frame borders
            let border = CGRect(x: lowerValuePosition, y: 0, width: upperValuePosition - lowerValuePosition , height: bounds.height)
            let borderPath = UIBezierPath(rect: border)

            let borderCut = CGRect(x: lowerValuePosition, y: 1, width: upperValuePosition - lowerValuePosition , height: bounds.height-2)
            let borderCutPath = UIBezierPath(rect: borderCut)
            
            borderPath.append(borderCutPath.reversing())
            ctx.setFillColor(slider.thumbColor.cgColor)
            ctx.addPath(borderPath.cgPath)
            ctx.fillPath()
            
        }
    }
}


class RangeControl: UIControl{
    
    static let height = CGFloat(50.0)
    let margin = CGFloat(4.0)
    
    private let trackLayer = RangeControlTrackLayer()
    private let lowThumbLayer = RangeControlThumbLayer()
    private let upThumbLayer = RangeControlThumbLayer()
    let backgroundView = UIView()
    private let contentView = UIView()

    private  var previousLocation = CGPoint()
    
    var minValue:Float = 0.0 { didSet { updateLayerFrames() } }
    var maxValue:Float = 1.0 { didSet { updateLayerFrames() } }
    var lowValue:Float = 0.8 { didSet { updateLayerFrames() } }
    var upValue:Float = 1.0 { didSet {  updateLayerFrames() } }
    
    var trackColor: UIColor = UIColor.lightGray.withAlphaComponent(0.45) {
        didSet { trackLayer.setNeedsDisplay() }
    }
    
    var thumbColor: UIColor =  UIColor.lightGray.withAlphaComponent(0.95) {
        didSet {
            lowThumbLayer.setNeedsDisplay()
            upThumbLayer.setNeedsDisplay()
        }
    }
    
    var thumbWidth:CGFloat{
        return CGFloat(bounds.height/4.0)
    }

    var thumbHeight:CGFloat{
        return CGFloat(bounds.height)
    }
    
    override var frame: CGRect { didSet { updateLayerFrames() } }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateLayerFrames()
    }
    
    private func setup()  {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(backgroundView)
        backgroundView.isUserInteractionEnabled = false
        backgroundView.topAnchor.constraint(equalTo: self.topAnchor, constant: margin).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -margin).isActive = true
        backgroundView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        backgroundView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentView)
        contentView.frame = bounds
        contentView.isUserInteractionEnabled = false
        contentView.backgroundColor = UIColor.clear
        contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        contentView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        
        
        trackLayer.isOpaque = false
        lowThumbLayer.isOpaque = false
        upThumbLayer.isOpaque = false


        lowThumbLayer.isLeft = true
        contentView.layer.addSublayer(trackLayer)
        contentView.layer.addSublayer(lowThumbLayer)
        contentView.layer.addSublayer(upThumbLayer)
        updateLayerFrames()
        lowThumbLayer.rangeControl = self
        upThumbLayer.rangeControl = self
        trackLayer.rangeControl = self

        trackLayer.contentsScale = UIScreen.main.scale
        lowThumbLayer.contentsScale = UIScreen.main.scale
        upThumbLayer.contentsScale = UIScreen.main.scale
    }
    
    private func updateLayerFrames() {
        trackLayer.frame = bounds.insetBy(dx: 0.0, dy: 0.0)
        
        let lowThumbCenter = CGFloat(positionForValue(lowValue))
        let upThumbCenter = CGFloat(positionForValue(upValue))
        lowThumbLayer.frame = CGRect(x: lowThumbCenter - thumbWidth / 2.0, y: 0.0, width: thumbWidth, height: thumbHeight)
        upThumbLayer.frame = CGRect(x: upThumbCenter - thumbWidth / 2.0, y: 0.0, width: thumbWidth, height: thumbHeight)

        trackLayer.setNeedsDisplay()
        lowThumbLayer.setNeedsDisplay()
        upThumbLayer.setNeedsDisplay()
    }
    
    func positionForValue(_ value: Float) -> Float {
        return Float(bounds.width - thumbWidth) * (value - minValue) /
            (maxValue - minValue) + Float(thumbWidth / 2.0)
    }

    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        previousLocation = touch.location(in: self)
    
        if lowThumbLayer.frame.contains(previousLocation) {
            lowThumbLayer.highlighted = true
        } else if upThumbLayer.frame.contains(previousLocation) {
            upThumbLayer.highlighted = true
        } else if (lowThumbLayer.frame.union(upThumbLayer.frame).contains(previousLocation)){ //between handles
            lowThumbLayer.highlighted = true
            upThumbLayer.highlighted = true
        }
        
        
        return lowThumbLayer.highlighted || upThumbLayer.highlighted
    }
    
    private func boundValue(_ value: Float, toLowerValue lowerValue: Float, upperValue: Float) -> Float {
        return Float.minimum(Float.maximum(value, lowerValue), upperValue)
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        lowThumbLayer.highlighted = false
        upThumbLayer.highlighted = false
    }
    
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let location = touch.location(in: self)
        // 1. Determine by how much the user has dragged
        let deltaLocation = Float(location.x - previousLocation.x)
        let deltaValue = (maxValue - minValue) * deltaLocation / Float(bounds.width - thumbWidth)
        
        previousLocation = location

        // 2. Update the values
        if lowThumbLayer.highlighted {
            lowValue += deltaValue
            let lowValueTmp = boundValue(lowValue, toLowerValue: minValue, upperValue: upValue - 0.02)
            lowValue = Float.maximum(lowValueTmp, 0)
        }
        if upThumbLayer.highlighted {
            upValue += deltaValue
            let upValueTmp = boundValue(upValue, toLowerValue: lowValue + 0.02, upperValue: maxValue)
            upValue = Float.minimum(upValueTmp, 1.0)
        }

        // 3. Update the UI
        CATransaction.begin()
        CATransaction.setDisableActions(false)
        self.updateLayerFrames()
        CATransaction.commit()
        return super.continueTracking(touch, with: event)
    }
}
