//
//  KAO3DSlider.swift
//  KAO3DSlider
//
//  Created by Andrii Kravchenko on 4/26/16.
//  Copyright © 2016 kievkao. All rights reserved.
//

import UIKit

protocol KAO3DSliderDelegate {
    func sliderValueChanged(_ slider: KAO3DSlider, value: Float)
}

class KAO3DSlider: UIView {

    static let TopEdgeHeight: CGFloat = 20.0
    static let TopMaxIncline: CGFloat = 35.0

    fileprivate let slider = UISlider()
    fileprivate let backgroundView = KAO3DSliderBackgroundView(topEdgeHeight: TopEdgeHeight, topMaxIncline: TopMaxIncline)

    var delegate: KAO3DSliderDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()

        self.setupBackground()
        self.setupSlider()
    }

    fileprivate func setupBackground() {
        self.addSubview(backgroundView)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false

        let viewsDict = ["backgroundView" :backgroundView]
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[backgroundView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[backgroundView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views:  viewsDict))
    }

    fileprivate func setupSlider() {
        slider.minimumTrackTintColor = UIColor.clear
        slider.maximumTrackTintColor = UIColor.clear
        slider.addTarget(self, action: #selector(KAO3DSlider.sliderValueChanged), for: .valueChanged)

        self.addSubview(slider)

        slider.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraint(NSLayoutConstraint(item: slider, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: KAO3DSlider.TopEdgeHeight/2))
        self.addConstraint(NSLayoutConstraint(item: slider, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0.0))
        self.addConstraint(NSLayoutConstraint(item: slider, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0.0))
    }

    fileprivate func addCenterConstraints(_ view: UIView, yOffset:CGFloat) {
    }

    func sliderValueChanged() {
        backgroundView.setFilledPercentage((slider.value - slider.minimumValue) / (slider.maximumValue - slider.minimumValue))
        delegate?.sliderValueChanged(self, value: slider.value)
    }
}
