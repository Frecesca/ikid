//
//  GoodJokesViewController.swift
//  iKid
//
//  Created by wangmeixue on 2026/2/7.
//

import UIKit

class GoodJokesViewController: UIViewController {
    
    // MARK: - Properties
    
    // Regular jokes data
    let regularJokes = [
        ("Why don't scientists trust atoms?", "Because they make up everything!"),
        ("What do you call fake spaghetti?", "An impasta!"),
        ("Why did the scarecrow win an award?", "He was outstanding in his field!")
    ]
    
    // Knock-knock jokes data (5 steps for 4 flips)
    let knockKnockJokes = [
        "Knock knock!",
        "Who's there?",
        "Lettuce",
        "Lettuce who?",
        "Lettuce in, it's cold out here!"
    ]
    
    // State variables
    var currentJokeIndex = 0
    var isShowingQuestion = true
    var isKnockKnockMode = false
    var knockKnockIndex = 0
    
    // MARK: - UI Components
    let jokeLabel = UILabel()
    let nextButton = UIButton(type: .system)
    let modeSwitchButton = UIButton(type: .system)
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        showCurrentContent()
    }
    
    // MARK: - UI Setup
    func setupUI() {
        view.backgroundColor = .white
        
        // Configure joke label
        jokeLabel.textAlignment = .center
        jokeLabel.numberOfLines = 0
        jokeLabel.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        jokeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Configure next button
        nextButton.setTitle("Show Answer", for: .normal)
        nextButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        nextButton.backgroundColor = .systemBlue
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.layer.cornerRadius = 10
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        
        // Configure mode switch button
        modeSwitchButton.setTitle("Switch to Knock-Knock", for: .normal)
        modeSwitchButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        modeSwitchButton.backgroundColor = .systemPurple
        modeSwitchButton.setTitleColor(.white, for: .normal)
        modeSwitchButton.layer.cornerRadius = 8
        modeSwitchButton.translatesAutoresizingMaskIntoConstraints = false
        modeSwitchButton.addTarget(self, action: #selector(modeSwitchButtonTapped), for: .touchUpInside)
        
        // Add subviews
        view.addSubview(jokeLabel)
        view.addSubview(nextButton)
        view.addSubview(modeSwitchButton)
        
        // Setup constraints
        NSLayoutConstraint.activate([
            // Joke label constraints (centered)
            jokeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            jokeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            jokeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            jokeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // Mode switch button (top center)
            modeSwitchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            modeSwitchButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            modeSwitchButton.widthAnchor.constraint(equalToConstant: 200),
            modeSwitchButton.heightAnchor.constraint(equalToConstant: 40),
            
            // Next button (bottom right)
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            nextButton.widthAnchor.constraint(equalToConstant: 150),
            nextButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    // MARK: - Content Display Methods
    func showCurrentContent() {
        if isKnockKnockMode {
            // Show current knock-knock joke line
            jokeLabel.text = knockKnockJokes[knockKnockIndex]
            
            // Update button title based on position
            if knockKnockIndex < knockKnockJokes.count - 1 {
                nextButton.setTitle("Next Line", for: .normal)
            } else {
                nextButton.setTitle("Start Over", for: .normal)
            }
        } else {
            // Show regular joke
            let joke = regularJokes[currentJokeIndex]
            if isShowingQuestion {
                jokeLabel.text = joke.0
                nextButton.setTitle("Show Answer", for: .normal)
            } else {
                jokeLabel.text = joke.1
                nextButton.setTitle("Next Joke", for: .normal)
            }
        }
    }
    
    // MARK: - Button Action Methods
    @objc func nextButtonTapped() {
        if isKnockKnockMode {
            // Handle knock-knock joke flow
            if knockKnockIndex < knockKnockJokes.count - 1 {
                // Move to next line
                knockKnockIndex += 1
            } else {
                // Reset to start of knock-knock joke
                knockKnockIndex = 0
            }
        } else {
            // Handle regular joke flow
            if isShowingQuestion {
                isShowingQuestion = false
            } else {
                isShowingQuestion = true
                currentJokeIndex = (currentJokeIndex + 1) % regularJokes.count
            }
        }
        
        showCurrentContent()
    }
    
    @objc func modeSwitchButtonTapped() {
        // Toggle between regular and knock-knock mode
        isKnockKnockMode.toggle()
        
        if isKnockKnockMode {
            // Reset to start of knock-knock joke
            knockKnockIndex = 0
            modeSwitchButton.setTitle("Switch to Regular Jokes", for: .normal)
            modeSwitchButton.backgroundColor = .systemOrange
        } else {
            // Reset to start of regular jokes
            isShowingQuestion = true
            modeSwitchButton.setTitle("Switch to Knock-Knock", for: .normal)
            modeSwitchButton.backgroundColor = .systemPurple
        }
        
        showCurrentContent()
    }
    
    // MARK: - Screen Rotation Support
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .all
    }
}
