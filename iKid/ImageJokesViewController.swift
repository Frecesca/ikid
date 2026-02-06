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
            // Show question
            jokeLabel.text = joke.0
            
            // Load image from Assets.xcassets based on joke index
            switch currentJokeIndex {
            case 0:
                // First joke - chicken joke
                jokeImageView.image = UIImage(named: "chicken_image")
            case 1:
                // Second joke - bull joke
                jokeImageView.image = UIImage(named: "bull_image")
            case 2:
                // Third joke - skeleton joke
                jokeImageView.image = UIImage(named: "skeleton_image")
            default:
                jokeImageView.image = UIImage(systemName: "questionmark.circle")
            }
            
            // If you don't have custom images, use system images as fallback
            if jokeImageView.image == nil {
                let fallbackImages = ["hare.fill", "tortoise.fill", "ant.fill"]
                jokeImageView.image = UIImage(systemName: fallbackImages[currentJokeIndex])
                jokeImageView.tintColor = .systemBlue
            }
            
            nextButton.setTitle("Show Answer", for: .normal)
        } else {
            // Show answer
            jokeLabel.text = joke.1
            
            // You can show different images for answers
            switch currentJokeIndex {
            case 0:
                // Chicken joke answer
                jokeImageView.image = UIImage(named: "chicken_answer_image") ?? UIImage(systemName: "lightbulb.fill")
            case 1:
                // Bull joke answer
                jokeImageView.image = UIImage(named: "bull_answer_image") ?? UIImage(systemName: "brain.head.profile")
            case 2:
                // Skeleton joke answer
                jokeImageView.image = UIImage(named: "skeleton_answer_image") ?? UIImage(systemName: "face.smiling")
            default:
                jokeImageView.image = UIImage(systemName: "exclamationmark.circle")
            }
            
            // Set tint color for system images
            if jokeImageView.image?.isSymbolImage == true {
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
