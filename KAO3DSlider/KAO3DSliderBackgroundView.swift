//
//  KAO3DSliderBackgroundView.swift
//  KAO3DSlider
//
//  Created by Andrii Kravchenko on 4/26/16.
//  Copyright © 2016 kievkao. All rights reserved.
//

import UIKit

class KAO3DSliderBackgroundView: UIView {

    private var fillPercentage: Float = 0.0

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
        fillPercentage = percentage

        self.setNeedsDisplay()
    }

    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(context, UIColor.greenColor().CGColor)
        CGContextFillRect(context, CGRectMake(0, 0, CGFloat(self.fillPercentage) * self.bounds.width, self.bounds.height))
    }
}
