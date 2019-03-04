//
//  FoodTrackerTests.swift
//  FoodTrackerTests
//
//  Created by Art Williamson on 2/25/19.
//  Copyright © 2019 Art Williamson. All rights reserved.
//

import XCTest
@testable import FoodTracker

class FoodTrackerTests: XCTestCase {
    //MARK: Meal Class Tests
    func testMealInitializationSucceeds() {
        //Zero rating
        let zeroRatingMeal = Meal.init(name: "Zero", photo: nil, rating: 0)
        XCTAssertNotNil(zeroRatingMeal)

        //Highest positive rating
        let highestRatingMeal = Meal.init(name: "Positive", photo: nil, rating: 5)
        XCTAssertNotNil(highestRatingMeal)
    }

    func testMealInitializationFails() {
        //Negative rating
        let negativeRatingMeal = Meal.init(name: "Negative", photo: nil, rating: -1)
        XCTAssertNil(negativeRatingMeal)

        //No name
        let noNameMeal = Meal.init(name: "", photo: nil, rating: 0)
        XCTAssertNil(noNameMeal)

        //rating exceeds maximum
        let tooHighRating = Meal.init(name: "Too High", photo: nil, rating: 6)
        XCTAssertNil(tooHighRating)
    }
}
