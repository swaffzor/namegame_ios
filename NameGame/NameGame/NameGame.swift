//
//  NameGame.swift
//  NameGame
//
//  Created by Erik LaManna on 11/7/16.
//  Copyright © 2016 WillowTree Apps. All rights reserved.
//

import Foundation

protocol NameGameDelegate: class {
}

class NameGame {

    weak var delegate: NameGameDelegate?

    let numberPeople = 6

    // Load JSON data from API
    func loadGameData(completion: @escaping ([Person]) -> Void) { //array of persons
        
        var people = [Person]()
        if let url = URL(string: "https://willowtreeapps.com/api/v1.0/profiles/") {
            do {
                let data = try Data(contentsOf: url)
                let json = try? JSONSerialization.jsonObject(with: data, options: [])
                if let employeeArray = json as? [[String: Any]] {
                    for item in employeeArray {
                        if let person = Person.init(json: item){
                            people.append(person)
                        }
                    }
                }
                completion(people)
            } catch {
                // contents could not be loaded
                print("could not load data from the API")
            }
        } else {
            // the URL was bad!
            print("bad url")
        }
    }
    
    func checkAnswer(button: FaceButton, person: Person) -> Bool {
        return button.person!.firstName == person.firstName && button.person!.lastName == person.lastName
    }
}
