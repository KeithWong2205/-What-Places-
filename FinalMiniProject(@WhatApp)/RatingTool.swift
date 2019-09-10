//
//  RatingTool.swift
//  FinalMiniProject(@WhatApp)
//
//  Created by Keith Wong on 7/26/19.
//  Copyright © 2019 Keith Wong. All rights reserved.
//

import UIKit

class RatingTool: UIStackView
{
    //Mark: Properties of rating buttons
    private var ratingButts = [UIButton]()
    var rating = 0
    {
        didSet
        {
            updateButtonSelectionStates()
        }
    }
    @IBInspectable var starsize: CGSize = CGSize(width: 48.0, height: 44.0)
    {
        didSet
        {
            setupButtons()
        }
    }
    @IBInspectable var starnum: Int = 5
    {
        didSet
        {
            setupButtons()
        }
    }
    //Mark: Initialization
    override init(frame: CGRect)
    {
        super.init(frame: frame)
    }
    required init(coder: NSCoder)
    {
        super.init(coder: coder)
        setupButtons()
    }
    //Mark: Button Action
    @objc func rateTapped(button: UIButton)
    {
        guard let index = ratingButts.index(of: button) else
        {
            fatalError("The button, \(button), is not in the ratingButtons array: \(ratingButts)")
        }
        let selectedrate = index + 1
        if selectedrate == rating
        {
            rating = 0
        } else
        {
            rating = selectedrate
        }
    }
    //Mark: private methods
    private func setupButtons()
    {
        for button in ratingButts
        {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButts.removeAll()
        let bundle = Bundle(for: type(of: self))
        let filled = UIImage(named: "Filled", in: bundle, compatibleWith: self.traitCollection)
        let empty = UIImage(named: "Empty", in: bundle, compatibleWith: self.traitCollection)
        let highlight = UIImage(named: "Blued", in: bundle, compatibleWith: self.traitCollection)
        for index in 0..<starnum
        {
            let button = UIButton()
            button.setImage(empty, for: .normal)
            button.setImage(filled, for: .selected)
            button.setImage(highlight, for: .highlighted)
            button.setImage(highlight, for: [.highlighted, .selected])
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starsize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starsize.width).isActive = true
            button.accessibilityLabel = "Set \(index + 1) star rating"
            button.addTarget(self, action: #selector(RatingTool.rateTapped(button:)), for: .touchUpInside)
            addArrangedSubview(button)
            ratingButts.append(button)
        }
        updateButtonSelectionStates()
        
    }
        private func updateButtonSelectionStates()
        {
            for (index,button) in ratingButts.enumerated()
            {
                button.isSelected = index < rating
                let hint: String?
                if rating == index + 1
                {
                    hint = "Tap to reset rating"
                } else
                {
                    hint = nil
                }
                let value: String
                switch(rating)
                {
                case 0:
                    value = "No rating set"
                case 1:
                    value = "1 star set"
                default:
                    value = "\(rating) star set"
                }
                button.accessibilityHint = hint
                button.accessibilityValue = value
            }
        }
}

