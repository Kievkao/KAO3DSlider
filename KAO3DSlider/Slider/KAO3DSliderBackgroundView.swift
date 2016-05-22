//
//  KAO3DSliderBackgroundView.swift
//  KAO3DSlider
//
//  Created by Andrii Kravchenko on 4/26/16.
//  Copyright © 2016 kievkao. All rights reserved.
//

import UIKit

class KAO3DSliderBackgroundView: UIView {

    var topEdgeHeight: CGFloat = 20.0
    var topMaxIncline: CGFloat = 35.0

    let emptyColor = UIColor(red: 196.0/255.0, green: 196.0/255.0, blue: 196.0/255.0, alpha: 0.8)
    var topEdgeEmptyColor: UIColor {
        return emptyColor.colorWithAlphaComponent(0.5)
    }

    let mainColor = UIColor(red: 118.0/255.0, green: 180.0/255.0, blue: 68.0/255.0, alpha: 0.8)
    var topEdgeColor: UIColor {
        return mainColor.colorWithAlphaComponent(0.5)
    }

    var shadowColor: UIColor {
        return emptyColor.colorWithAlphaComponent(0.2)
    }

    private var fillPercentage: CGFloat = 0.0

    init(topEdgeHeight: CGFloat, topMaxIncline: CGFloat) {
        super.init(frame: CGRectZero)

        self.topEdgeHeight = topEdgeHeight
        self.topMaxIncline = topMaxIncline
        
        self.setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }

    private func setup() {
        self.backgroundColor = UIColor.clearColor()
    }

    func setFilledPercentage(percentage: Float) {
        fillPercentage = CGFloat(percentage)

        self.setNeedsDisplay()
    }

    override func drawRect(rect: CGRect) {

        let viewWidth = self.bounds.width
        let viewHeight = self.bounds.height

        let fillWidth = CGFloat(self.fillPercentage) * viewWidth
        let context = UIGraphicsGetCurrentContext()

        // main progress rect
        CGContextSetFillColorWithColor(context, mainColor.CGColor)
        CGContextFillRect(context, CGRectMake(0, topEdgeHeight, fillWidth, viewHeight - topEdgeHeight))

        // remained main rect
        CGContextSetFillColorWithColor(context, emptyColor.CGColor)
        CGContextFillRect(context, CGRectMake(fillWidth, topEdgeHeight, viewWidth - fillWidth, viewHeight - topEdgeHeight))

        // top inclined edge
        let backFillWidth = self.fillPercentage * (viewWidth - topMaxIncline*2)

        CGContextMoveToPoint(context, topMaxIncline, 0)
        CGContextAddLineToPoint(context, topMaxIncline + backFillWidth, 0)
        CGContextAddLineToPoint(context, fillWidth, topEdgeHeight)
        CGContextAddLineToPoint(context, 0, topEdgeHeight)

        CGContextSetFillColorWithColor(context, topEdgeColor.CGColor)
        CGContextFillPath(context)

        // shear
        CGContextMoveToPoint(context, topMaxIncline + backFillWidth, 0)
        CGContextAddLineToPoint(context, topMaxIncline + backFillWidth, viewHeight - topEdgeHeight)
        CGContextAddLineToPoint(context, fillWidth, viewHeight)
        CGContextAddLineToPoint(context, fillWidth, topEdgeHeight)

        CGContextSetFillColorWithColor(context, (topMaxIncline + backFillWidth > fillWidth) ? topEdgeColor.CGColor : topEdgeColor.colorWithAlphaComponent(0.5).CGColor)
        CGContextFillPath(context)

        // top inclined empty edge
        CGContextMoveToPoint(context, topMaxIncline + backFillWidth, 0)
        CGContextAddLineToPoint(context, viewWidth - topMaxIncline, 0)
        CGContextAddLineToPoint(context, viewWidth, topEdgeHeight)
        CGContextAddLineToPoint(context, fillWidth, topEdgeHeight)

        CGContextSetFillColorWithColor(context, topEdgeEmptyColor.CGColor)
        CGContextFillPath(context)

        // left shadow
        CGContextMoveToPoint(context, topMaxIncline, 0)
        CGContextAddLineToPoint(context, topMaxIncline, viewHeight - topEdgeHeight)
        CGContextAddLineToPoint(context, 0, viewHeight)
        CGContextAddLineToPoint(context, 0, topEdgeHeight)
        CGContextSetFillColorWithColor(context, shadowColor.CGColor)
        CGContextFillPath(context)

        // right shadow
        CGContextMoveToPoint(context, viewWidth - topMaxIncline, 0)
        CGContextAddLineToPoint(context, viewWidth - topMaxIncline, viewHeight - topEdgeHeight)
        CGContextAddLineToPoint(context, viewWidth, viewHeight)
        CGContextAddLineToPoint(context, viewWidth, topEdgeHeight)
        CGContextSetFillColorWithColor(context, shadowColor.CGColor)
        CGContextFillPath(context)

    }
}
