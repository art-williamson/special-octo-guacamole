//
//  RatingControl.swift
//  FoodTracker
//
//  Created by Art Williamson on 2/28/19.
//  Copyright © 2019 Art Williamson. All rights reserved.
//

import UIKit

class RatingControl: UIStackView {
    //MARK: PROPERTIES
    private var ratingButtons = [UIButton]()
    var rating = 0

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
        print("Button Pressed")
    }

    //MARK: Private Methods
    private func setupButtons() {
        for _ in 0..<5 {
            //create the button
            let button = UIButton()
            button.backgroundColor = UIColor.red
            //add constraints
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
            button.widthAnchor.constraint(equalToConstant: 44.0).isActive = true
            //Setup the button action
            button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)
            //add the button to the stack view
            addArrangedSubview(button)

            ratingButtons.append(button)
        }

    }

}
