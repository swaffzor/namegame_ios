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
    func loadGameData(completion: @escaping () -> Void) {
        
        
        if let url = URL(string: "https://willowtreeapps.com/api/v1.0/profiles/") {
            do {
                let contents = try String(contentsOf: url)
                print(contents)
            } catch {
                // contents could not be loaded
            }
        } else {
            // the URL was bad!
        }
    }
}
