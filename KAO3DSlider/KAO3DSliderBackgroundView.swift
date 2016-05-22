//
//  KAO3DSliderBackgroundView.swift
//  KAO3DSlider
//
//  Created by Andrii Kravchenko on 4/26/16.
//  Copyright © 2016 kievkao. All rights reserved.
//

import UIKit

class KAO3DSliderBackgroundView: UIView {

    let TopEdgeHeight: CGFloat = 20.0
    let TopMaxIncline: CGFloat = 35.0

    let emptyColor = UIColor(red: 196.0/255.0, green: 196.0/255.0, blue: 196.0/255.0, alpha: 0.8)
    var topEdgeEmptyColor: UIColor {
        return emptyColor.colorWithAlphaComponent(0.5)
    }

    let mainColor = UIColor(red: 118.0/255.0, green: 180.0/255.0, blue: 68.0/255.0, alpha: 0.8)
    var topEdgeColor: UIColor {
        return mainColor.colorWithAlphaComponent(0.5)
    }

    var shadowColor: UIColor {
        return mainColor.colorWithAlphaComponent(0.2)
    }

    private var fillPercentage: CGFloat = 0.0

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
        CGContextFillRect(context, CGRectMake(0, TopEdgeHeight, fillWidth, viewHeight - TopEdgeHeight))

        // remained main rect
        CGContextSetFillColorWithColor(context, emptyColor.CGColor)
        CGContextFillRect(context, CGRectMake(fillWidth, TopEdgeHeight, viewWidth - fillWidth, viewHeight - TopEdgeHeight))

        // top inclined edge
        let backFillWidth = self.fillPercentage * (viewWidth - TopMaxIncline*2)

        CGContextMoveToPoint(context, TopMaxIncline, 0)
        CGContextAddLineToPoint(context, TopMaxIncline + backFillWidth, 0)
        CGContextAddLineToPoint(context, fillWidth, TopEdgeHeight)
        CGContextAddLineToPoint(context, 0, TopEdgeHeight)

        CGContextSetFillColorWithColor(context, topEdgeColor.CGColor)
        CGContextFillPath(context)

        // top inclined empty edge
        CGContextMoveToPoint(context, TopMaxIncline + backFillWidth, 0)
        CGContextAddLineToPoint(context, viewWidth - TopMaxIncline, 0)
        CGContextAddLineToPoint(context, viewWidth, TopEdgeHeight)
        CGContextAddLineToPoint(context, fillWidth, TopEdgeHeight)

        CGContextSetFillColorWithColor(context, topEdgeEmptyColor.CGColor)
        CGContextFillPath(context)

        // left shadow
        CGContextMoveToPoint(context, TopMaxIncline, 0)
        CGContextAddLineToPoint(context, TopMaxIncline, viewHeight - TopEdgeHeight)
        CGContextAddLineToPoint(context, 0, viewHeight)
        CGContextAddLineToPoint(context, 0, TopEdgeHeight)
        CGContextSetFillColorWithColor(context, shadowColor.CGColor)
        CGContextFillPath(context)
    }
}
