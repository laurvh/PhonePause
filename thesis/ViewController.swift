//
//  ViewController.swift
//  thesis
//
//  Created by Lauren Van Horn on 4/26/23.
//

import UIKit

class ViewController: UIViewController {

    let hobbies = [
        "Drawing",
        "Hiking",
        "Cooking",
        "Playing an instrument",
        "Gardening",
        "Learning a new language",
        "Reading",
        "Baking",
        "Yoga",
        "Meditation",
        "Running",
        "Painting",
        "Knitting",
        "Photography",
        "Dancing",
        "Writing",
        "Calligraphy",
        "Woodworking",
        "Embroidery or cross-stitch",
        "Pottery",
        "Playing board games",
        "Learning a new skill",
        "Playing sports",
        "Volunteering",
        "Watching a classic movie",
        "Going for a walk",
        "Playing with a pet",
        "Listening to a podcast",
        "Listening to music",
        "Doing a puzzle",
        "Making a scrapbook",
        "Game night with friends",
        "Doing a DIY project",
        "Taking an online course",
        "Visiting a museum",
        "Attending a live show",
        "Going on a Picnic",
        "Go on a Hike",
        "Swimming",
        "Shopping",
        "Fishing",
        "Baking",
        "Write some poetry",
        "Sign up for an art class",
        "Oragami",
        "Go to the gym",
        "Call your friends or family",
        "Host a dinner party",
        "Write a letter",
        "Play Tennis",
        "Go to the Zoo",
        "Try designing clothes",
        "Explore your neighborhood",
        "Go to the library",
        "Check out a new cafe",
        "Crocheting"
    ]
    
    var currentHobbyIndex = 0
        var timer: Timer?
        let hobbyLabelsStackView = UIStackView()

        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
            
            // Add background image
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [UIColor(red: 208/255, green: 212/255, blue: 255/255, alpha: 1.0).cgColor, UIColor(red: 155/255, green: 238/255, blue: 255/255, alpha: 1.0).cgColor]
            gradientLayer.locations = [0, 1]
            gradientLayer.frame = view.bounds
            view.layer.addSublayer(gradientLayer)
            
            // Add title
            let titleLabel = UILabel(frame: CGRect(x: 0, y: 50, width:view.frame.width, height: 0))
            titleLabel.textAlignment = .center
            titleLabel.font = UIFont.systemFont(ofSize: 25, weight: .bold)
            titleLabel.numberOfLines = 0 // Set to 0 to allow for multiple lines
            titleLabel.lineBreakMode = .byWordWrapping // Set to wrap by words
            titleLabel.text = "Instead of spending time on your phone, try out one of these hobbies!"

            let size = titleLabel.sizeThatFits(CGSize(width: titleLabel.frame.width, height: CGFloat.greatestFiniteMagnitude))
            titleLabel.frame.size.height = size.height

            view.addSubview(titleLabel)
            
            // Set up hobby labels stack view
            hobbyLabelsStackView.axis = .vertical
            hobbyLabelsStackView.alignment = .center
            hobbyLabelsStackView.distribution = .equalSpacing
            hobbyLabelsStackView.spacing = 16
            hobbyLabelsStackView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(hobbyLabelsStackView)
            NSLayoutConstraint.activate([
                hobbyLabelsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                hobbyLabelsStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                hobbyLabelsStackView.widthAnchor.constraint(equalToConstant: 300)
            ])
            
            // Set up timer
            timer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { [weak self] timer in
                self?.changeHobbies()
            }
            
            // Set initial hobbies
            displayHobbies()
        }
        
        func displayHobbies() {
            hobbyLabelsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
            let hobbiesToDisplay = Array(hobbies[currentHobbyIndex..<currentHobbyIndex+7])
            for hobby in hobbiesToDisplay {
                let hobbyLabel = UILabel()
                hobbyLabel.textAlignment = .center
                hobbyLabel.font = UIFont.systemFont(ofSize: 25)
                hobbyLabel.text = hobby
                hobbyLabelsStackView.addArrangedSubview(hobbyLabel)
            }
        }
        
        func changeHobbies() {
            currentHobbyIndex += 7
            if currentHobbyIndex >= hobbies.count {
                currentHobbyIndex = 0
            }
            displayHobbies()
        }
    }

