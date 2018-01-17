//
//  Person.swift
//  NameGame
//
//  Created by Jeremy Swafford on 1/15/18.
//  Copyright © 2018 WillowTree Apps. All rights reserved.
//

import Foundation
import UIKit

class Person {
    var firstName: String
    var lastName: String
    var photo: String
    var jobTitle: String?
    var appeared: Int
    var correct: Int
    
    init?(json: [String: Any]){
        guard let firstName = json["firstName"] as? String,
            let lastName = json["lastName"] as? String,
            let headshot = json["headshot"] as? [String: Any],
            var photo = headshot["url"] as? String
        else {
            print("failed to init " + String(describing: json["firstName"]))
            return nil
        }
        self.firstName = firstName
        self.lastName = lastName
        photo.insert(contentsOf: "http:", at: photo.startIndex)
        self.photo = photo
        self.jobTitle = json["jobTitle"] as? String
        self.appeared = 0
        self.correct = 0
    }
}
