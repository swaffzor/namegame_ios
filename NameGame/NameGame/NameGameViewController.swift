//
//  ViewController.swift
//  NameGame
//
//  Created by Matt Kauper on 3/8/16.
//  Copyright © 2016 WillowTree Apps. All rights reserved.
//

import UIKit

class NameGameViewController: UIViewController {

    @IBOutlet weak var outerStackView: UIStackView!
    @IBOutlet weak var innerStackView1: UIStackView!
    @IBOutlet weak var innerStackView2: UIStackView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet var imageButtons: [FaceButton]!

    var people = [Person]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let orientation: UIDeviceOrientation = self.view.frame.size.height > self.view.frame.size.width ? .portrait : .landscapeLeft
        configureSubviews(orientation)
        
        var nameGame = NameGame()
        
        nameGame.loadGameData() { people in
            self.people = people
        }
        
        startNewRound(people: self.people, nameGame: nameGame)
    }

    @IBAction func faceTapped(_ button: FaceButton) {
        
        print(people[button.id].firstName + " " + people[button.id].lastName + " face tapped")
    }

    func configureSubviews(_ orientation: UIDeviceOrientation) {
        if orientation.isLandscape {
            outerStackView.axis = .vertical
            innerStackView1.axis = .horizontal
            innerStackView2.axis = .horizontal
        } else {
            outerStackView.axis = .horizontal
            innerStackView1.axis = .vertical
            innerStackView2.axis = .vertical
        }

        view.setNeedsLayout()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        let orientation: UIDeviceOrientation = size.height > size.width ? .portrait : .landscapeLeft
        configureSubviews(orientation)
    }
    
    func startNewRound(people: [Person], nameGame: NameGame){
        //pick 6 (random?) people
        for button in imageButtons{
            let randomIndex = Int(arc4random_uniform(UInt32(people.count)))
            if people[randomIndex].correct < 1 {
                button.id = randomIndex
                let session = URLSession(configuration: .default)
                let url = URL(string: people[randomIndex].photo)
                //creating a dataTask
                let getImageFromUrl = session.dataTask(with: url!) { (data, response, error) in
                    //if there is any error
                    if let e = error {
                        //displaying the message
                        print("Error Occurred: \(e)")
                    } else {
                        //in case of now error, checking wheather the response is nil or not
                        if (response as? HTTPURLResponse) != nil {
                            //checking if the response contains an image
                            if let imageData = data {
                                //getting the image
                                let image = UIImage(data: imageData)
                                //displaying the image
                                DispatchQueue.main.async {
                                    button.setBackgroundImage(image, for: .normal)
                                }
                            } else {
                                print("Image file is currupted")
                            }
                        } else {
                            print("No response from server")
                        }
                    }
                }
                
                //starting the download task
                getImageFromUrl.resume()
            }
        }
        //update the label with the selected person
        let personOfInterest = Int(arc4random_uniform(UInt32(imageButtons.count)))
        let personID = imageButtons[personOfInterest].id
        questionLabel.text = "Who is " + people[personID].firstName + " " + people[personID].lastName + "?"
        
        //set game state?
    }
    
}

extension NameGameViewController: NameGameDelegate {
}
