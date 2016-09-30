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
        return emptyColor.withAlphaComponent(0.5)
    }

    let mainColor = UIColor(red: 118.0/255.0, green: 180.0/255.0, blue: 68.0/255.0, alpha: 0.8)
    var topEdgeColor: UIColor {
        return mainColor.withAlphaComponent(0.5)
    }

    var shadowColor: UIColor {
        return emptyColor.withAlphaComponent(0.2)
    }

    fileprivate var fillPercentage: CGFloat = 0.0

    init(topEdgeHeight: CGFloat, topMaxIncline: CGFloat) {
        super.init(frame: CGRect.zero)

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

    fileprivate func setup() {
        self.backgroundColor = UIColor.clear
    }

    func setFilledPercentage(_ percentage: Float) {
        fillPercentage = CGFloat(percentage)

        self.setNeedsDisplay()
    }

    override func draw(_ rect: CGRect) {

        let viewWidth = self.bounds.width
        let viewHeight = self.bounds.height

        let fillWidth = CGFloat(self.fillPercentage) * viewWidth
        let context = UIGraphicsGetCurrentContext()

        // main progress rect
        context?.setFillColor(mainColor.cgColor)
        context?.fill(CGRect(x: 0, y: topEdgeHeight, width: fillWidth, height: viewHeight - topEdgeHeight))

        // remained main rect
        context?.setFillColor(emptyColor.cgColor)
        context?.fill(CGRect(x: fillWidth, y: topEdgeHeight, width: viewWidth - fillWidth, height: viewHeight - topEdgeHeight))

        // top inclined edge
        let backFillWidth = self.fillPercentage * (viewWidth - topMaxIncline*2)

        context?.move(to: CGPoint(x: topMaxIncline, y: 0))
        context?.addLine(to: CGPoint(x: topMaxIncline + backFillWidth, y: 0))
        context?.addLine(to: CGPoint(x: fillWidth, y: topEdgeHeight))
        context?.addLine(to: CGPoint(x: 0, y: topEdgeHeight))

        context?.setFillColor(topEdgeColor.cgColor)
        context?.fillPath()

        // shear
        context?.move(to: CGPoint(x: topMaxIncline + backFillWidth, y: 0))
        context?.addLine(to: CGPoint(x: topMaxIncline + backFillWidth, y: viewHeight - topEdgeHeight))
        context?.addLine(to: CGPoint(x: fillWidth, y: viewHeight))
        context?.addLine(to: CGPoint(x: fillWidth, y: topEdgeHeight))

        context?.setFillColor((topMaxIncline + backFillWidth > fillWidth) ? topEdgeColor.cgColor : topEdgeColor.withAlphaComponent(0.5).cgColor)
        context?.fillPath()

        // top inclined empty edge
        context?.move(to: CGPoint(x: topMaxIncline + backFillWidth, y: 0))
        context?.addLine(to: CGPoint(x: viewWidth - topMaxIncline, y: 0))
        context?.addLine(to: CGPoint(x: viewWidth, y: topEdgeHeight))
        context?.addLine(to: CGPoint(x: fillWidth, y: topEdgeHeight))

        context?.setFillColor(topEdgeEmptyColor.cgColor)
        context?.fillPath()

        // left shadow
        context?.move(to: CGPoint(x: topMaxIncline, y: 0))
        context?.addLine(to: CGPoint(x: topMaxIncline, y: viewHeight - topEdgeHeight))
        context?.addLine(to: CGPoint(x: 0, y: viewHeight))
        context?.addLine(to: CGPoint(x: 0, y: topEdgeHeight))
        context?.setFillColor(shadowColor.cgColor)
        context?.fillPath()

        // right shadow
        context?.move(to: CGPoint(x: viewWidth - topMaxIncline, y: 0))
        context?.addLine(to: CGPoint(x: viewWidth - topMaxIncline, y: viewHeight - topEdgeHeight))
        context?.addLine(to: CGPoint(x: viewWidth, y: viewHeight))
        context?.addLine(to: CGPoint(x: viewWidth, y: topEdgeHeight))
        context?.setFillColor(shadowColor.cgColor)
        context?.fillPath()

    }
}
