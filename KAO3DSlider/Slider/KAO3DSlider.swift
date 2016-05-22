//
//  KAO3DSlider.swift
//  KAO3DSlider
//
//  Created by Andrii Kravchenko on 4/26/16.
//  Copyright © 2016 kievkao. All rights reserved.
//

import UIKit

protocol KAO3DSliderDelegate {
    func sliderValueChanged(slider: KAO3DSlider, value: Float)
}

class KAO3DSlider: UIView {

    static let TopEdgeHeight: CGFloat = 20.0
    static let TopMaxIncline: CGFloat = 35.0

    private let slider = UISlider()
    private let backgroundView = KAO3DSliderBackgroundView(topEdgeHeight: TopEdgeHeight, topMaxIncline: TopMaxIncline)

    var delegate: KAO3DSliderDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()

        self.setupBackground()
        self.setupSlider()
    }

    private func setupBackground() {
        self.addSubview(backgroundView)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false

        let viewsDict = ["backgroundView" :backgroundView]
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[backgroundView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDict))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[backgroundView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views:  viewsDict))
    }

    private func setupSlider() {
        slider.minimumTrackTintColor = UIColor.clearColor()
        slider.maximumTrackTintColor = UIColor.clearColor()
        slider.addTarget(self, action: #selector(KAO3DSlider.sliderValueChanged), forControlEvents: .ValueChanged)

        self.addSubview(slider)

        slider.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraint(NSLayoutConstraint(item: slider, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1.0, constant: KAO3DSlider.TopEdgeHeight/2))
        self.addConstraint(NSLayoutConstraint(item: slider, attribute: .Leading, relatedBy: .Equal, toItem: self, attribute: .Leading, multiplier: 1.0, constant: 0.0))
        self.addConstraint(NSLayoutConstraint(item: slider, attribute: .Trailing, relatedBy: .Equal, toItem: self, attribute: .Trailing, multiplier: 1.0, constant: 0.0))
    }

    private func addCenterConstraints(view: UIView, yOffset:CGFloat) {
    }

    func sliderValueChanged() {
        backgroundView.setFilledPercentage((slider.value - slider.minimumValue) / (slider.maximumValue - slider.minimumValue))
        delegate?.sliderValueChanged(self, value: slider.value)
    }
}
