//
//  GoodJokesViewController.swift
//  iKid
//
//  Created by wangmeixue on 2026/2/7.
//

import UIKit

class ImageJokesViewController: UIViewController {
    
    // MARK: - Properties
    
    // Image jokes data (question, answer, image name)
    let imageJokes = [
        ("Why did the chicken cross the road?", "To get to the other side!", "chicken"),
        ("What do you call a sleeping bull?", "A bulldozer!", "bull"),
        ("Why don't skeletons fight each other?", "They don't have the guts!", "skeleton")
    ]
    
    var currentJokeIndex = 0
    var isShowingQuestion = true
    
    // MARK: - UI Components
    let jokeLabel = UILabel()
    let nextButton = UIButton(type: .system)
    let jokeImageView = UIImageView()
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        showCurrentJoke()
    }
    
    // MARK: - UI Setup
    func setupUI() {
        view.backgroundColor = .white
        
        // Configure joke image view
        jokeImageView.contentMode = .scaleAspectFit
        jokeImageView.translatesAutoresizingMaskIntoConstraints = false
        jokeImageView.layer.cornerRadius = 10
        jokeImageView.clipsToBounds = true
        jokeImageView.backgroundColor = .systemGray6
        
        // Configure joke label
        jokeLabel.textAlignment = .center
        jokeLabel.numberOfLines = 0
        jokeLabel.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        jokeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Configure next button
        nextButton.setTitle("Show Answer", for: .normal)
        nextButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        nextButton.backgroundColor = .systemTeal
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.layer.cornerRadius = 10
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        
        // Add subviews
        view.addSubview(jokeImageView)
        view.addSubview(jokeLabel)
        view.addSubview(nextButton)
        
        // Setup constraints
        NSLayoutConstraint.activate([
            // Image view constraints (top)
            jokeImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            jokeImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            jokeImageView.widthAnchor.constraint(equalToConstant: 250),
            jokeImageView.heightAnchor.constraint(equalToConstant: 200),
            
            // Joke label constraints (below image)
            jokeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            jokeLabel.topAnchor.constraint(equalTo: jokeImageView.bottomAnchor, constant: 40),
            jokeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            jokeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // Next button constraints (bottom)
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            nextButton.widthAnchor.constraint(equalToConstant: 160),
            nextButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    // MARK: - Content Display Methods
    func showCurrentJoke() {
        let joke = imageJokes[currentJokeIndex]
        
        if isShowingQuestion {
            // Show question and corresponding image
            jokeLabel.text = joke.0
            
            // In a real app, you would load actual images
            // For now, we'll use system images or colored placeholders
            let imageNames = ["hare.fill", "tortoise.fill", "ant.fill"]
            if currentJokeIndex < imageNames.count {
                jokeImageView.image = UIImage(systemName: imageNames[currentJokeIndex])
                jokeImageView.tintColor = .systemBlue
            }
            
            nextButton.setTitle("Show Answer", for: .normal)
        } else {
            // Show answer
            jokeLabel.text = joke.1
            
            // Change image for answer (optional)
            let answerImageNames = ["lightbulb.fill", "brain.head.profile", "face.smiling"]
            if currentJokeIndex < answerImageNames.count {
                jokeImageView.image = UIImage(systemName: answerImageNames[currentJokeIndex])
                jokeImageView.tintColor = .systemGreen
            }
            
            nextButton.setTitle("Next Joke", for: .normal)
        }
    }
    
    // MARK: - Button Action Methods
    @objc func nextButtonTapped() {
        if isShowingQuestion {
            // Switch to answer
            isShowingQuestion = false
        } else {
            // Move to next joke
            isShowingQuestion = true
            currentJokeIndex = (currentJokeIndex + 1) % imageJokes.count
        }
        
        showCurrentJoke()
    }
    
    // MARK: - Screen Rotation Support
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .all
    }
}
