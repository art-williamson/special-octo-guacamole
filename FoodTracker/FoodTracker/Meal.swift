//
//  Meal.swift
//  FoodTracker
//
//  Created by Art Williamson on 3/1/19.
//  Copyright © 2019 Art Williamson. All rights reserved.
//

import UIKit

class Meal {

    //MARK: Properties
    var name: String
    var photo: UIImage?
    var rating: Int

    //MARK: Initialization
    init?(name: String, photo: UIImage?, rating: Int) {
        //make sure the nameis not empty
        guard !name.isEmpty else {
            return nil
        }

        //make sure rating is between 0 and 5
        guard (rating >= 0) && (rating <= 5) else {
            return nil
        }

        //initialize the properties
        self.name = name
        self.photo = photo
        self.rating = rating
    }



}
