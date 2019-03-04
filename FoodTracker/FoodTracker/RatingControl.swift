//
//  RatingControl.swift
//  FoodTracker
//
//  Created by Art Williamson on 2/28/19.
//  Copyright © 2019 Art Williamson. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {
    //MARK: PROPERTIES
    private var ratingButtons = [UIButton]()
    var rating = 0 {
        didSet {
            updateButtonSelectionStates()
        }
    }

    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0) {
        didSet {
            setupButtons()
        }
    }

    @IBInspectable var starCount: Int = 5 {
        didSet {
            setupButtons()
        }
    }

    //MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }

    //MARK: Button action
    @objc func ratingButtonTapped(button: UIButton) {
        guard let index = ratingButtons.index(of: button) else {
            fatalError("the button, \(button), is not in the ratingButtons array: \(ratingButtons)")
        }

        let selectedRating = index + 1

        if selectedRating == rating {
            rating = 0
        } else {
            //otherwise set the rating to the second star
            rating = selectedRating
        }
    }

    //MARK: Private Methods
    private func setupButtons() {
        //clear any existing buttons
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }

        ratingButtons.removeAll()

        //Load button images
        let bundle = Bundle(for:type(of: self))
        let filledStar = UIImage(named: "filledStar", in: bundle, compatibleWith: self.traitCollection)
        let emptyStar = UIImage(named: "emptyStar", in: bundle, compatibleWith: self.traitCollection)
        let highlightedStar = UIImage(named: "highlightedStar", in: bundle, compatibleWith: self.traitCollection)

        //set up the buttons again
        for index in 0..<starCount {
            //create the button
            let button = UIButton()
            //set the button images
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            button.setImage(highlightedStar, for: .highlighted)

            //add constraints
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            //set the accessibility label
            button.accessibilityLabel = "Set \(index) star rating"
            //Setup the button action
            button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)
            //add the button to the stack view
            addArrangedSubview(button)

            ratingButtons.append(button)
        }

        updateButtonSelectionStates()
    }

    private func updateButtonSelectionStates() {
        for(index, button) in ratingButtons.enumerated() {
            //if the index of a button is less than the rating the button should be selected
            button.isSelected = index < rating

            //set the hint string for the currently selected star
            let hintString: String?
            if rating == index + 1 {
                hintString = "Tap here to reset rating to zero."
            } else {
                hintString = nil
            }

            //calculate teh value string
            let valueString: String
            switch (rating) {
            case 0:
                valueString = "No rating set."
            case 1:
                valueString = "1 star set."
            default:
                valueString = "\(rating) stars set."

            }

            //assign hint and value String
            button.accessibilityHint = hintString;
            button.accessibilityValue = valueString

        }
    }

}
