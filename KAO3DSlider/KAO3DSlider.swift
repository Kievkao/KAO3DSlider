//
//  KAO3DSlider.swift
//  KAO3DSlider
//
//  Created by Andrii Kravchenko on 4/26/16.
//  Copyright © 2016 kievkao. All rights reserved.
//

import UIKit

class KAO3DSlider: UIView {

    private let slider = UISlider()

    override func awakeFromNib() {
        super.awakeFromNib()

        self.setupBackground()
        self.setupSlider()
    }

    private func setupSlider() {
        slider.minimumTrackTintColor = UIColor.clearColor()
        slider.maximumTrackTintColor = UIColor.clearColor()
        slider.addTarget(self, action: #selector(KAO3DSlider.sliderValueChanged), forControlEvents: .ValueChanged)

        self.addSubview(slider)
        self.addCenterConstraints(slider)
    }

    private func setupBackground() {
        let backImageView = UIImageView(image: UIImage(named: "sliderPart")?.resizableImageWithCapInsets(UIEdgeInsetsMake(5, 0, 5, 0), resizingMode: .Tile))

        self.addSubview(backImageView)
        self.addCenterConstraints(backImageView)
        self.addConstraint(NSLayoutConstraint(item: backImageView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .Height, multiplier: 1.0, constant: 30.0))
    }

    private func addCenterConstraints(view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraint(NSLayoutConstraint(item: view, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1.0, constant: 0.0))
        self.addConstraint(NSLayoutConstraint(item: view, attribute: .Leading, relatedBy: .Equal, toItem: self, attribute: .Leading, multiplier: 1.0, constant: 0.0))
        self.addConstraint(NSLayoutConstraint(item: view, attribute: .Trailing, relatedBy: .Equal, toItem: self, attribute: .Trailing, multiplier: 1.0, constant: 0.0))
    }

    func sliderValueChanged() {

    }
}
