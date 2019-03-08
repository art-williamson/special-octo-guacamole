//
//  Meal.swift
//  FoodTracker
//
//  Created by Art Williamson on 3/1/19.
//  Copyright © 2019 Art Williamson. All rights reserved.
//

import UIKit
import os.log

class Meal: NSCoding {

    //MARK: Properties
    var name: String
    var photo: UIImage?
    var rating: Int

    //MARK: Type
    struct PropertyKey {
        static let name = "name"
        static let photo = "photo"
        static let rating = "rating"
    }

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

    //MARK: NsCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(photo, forKey: PropertyKey.photo)
        aCoder.encode(rating, forKey: PropertyKey.rating)
    }

    required convenience init?(coder aDecoder: NSCoder) {
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }

        // Because photo is an optional property of Meal, just use conditional cast.
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage

        let rating = aDecoder.decodeObject(forKey: PropertyKey.rating) as! Int

        self.init(name: name, photo: photo, rating: rating)
    }

    //MARK: ARCHIVING PATHS
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("meals")

}
