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
    
    init?(json: [String: Any]){
        guard let firstName = json["firstName"] as? String,
            let lastName = json["lastName"] as? String,
            let headshot = json["headshot"] as? [String: Any],
            let photo = headshot["url"] as? String
        else {
            print("failed to init " + String(describing: json["firstName"]))
            return nil
        }
        self.firstName = firstName
        self.lastName = lastName
        self.photo = photo
        self.jobTitle = json["jobTitle"] as? String
    }
}
