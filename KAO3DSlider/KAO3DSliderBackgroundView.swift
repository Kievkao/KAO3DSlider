//
//  KAO3DSliderBackgroundView.swift
//  KAO3DSlider
//
//  Created by Andrii Kravchenko on 4/26/16.
//  Copyright © 2016 kievkao. All rights reserved.
//

import UIKit

class KAO3DSliderBackgroundView: UIView {

    let TopEdgeHeight: CGFloat = 35.0
    let TopMaxIncline: CGFloat = 35.0

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

        let fillWidth = CGFloat(self.fillPercentage) * self.bounds.width
        let context = UIGraphicsGetCurrentContext()

        // draw main progress rect
        CGContextSetFillColorWithColor(context, UIColor.greenColor().CGColor)
        CGContextFillRect(context, CGRectMake(0, TopEdgeHeight, fillWidth, self.bounds.height - TopEdgeHeight))

        // draw top inclined edge
        let backFillWidth = self.fillPercentage * (self.bounds.width - TopMaxIncline*2)

        CGContextMoveToPoint(context, TopMaxIncline, 0)
        CGContextAddLineToPoint(context, TopMaxIncline + backFillWidth, 0)
        CGContextAddLineToPoint(context, fillWidth, TopEdgeHeight)
        CGContextAddLineToPoint(context, 0, TopEdgeHeight)

        CGContextSetFillColorWithColor(context, UIColor.redColor().CGColor)
        CGContextFillPath(context)
    }
}
