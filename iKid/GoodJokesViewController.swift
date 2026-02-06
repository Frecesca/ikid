//
//  GoodJokesViewController.swift
//  iKid
//
//  Created by wangmeixue on 2026/2/7.
//

import UIKit

class GoodJokesViewController: UIViewController {
    
    // jokes
    let jokes = [
        ("Why don't scientists trust atoms?", "Because they make up everything!"),
        ("What do you call fake spaghetti?", "An impasta!"),
        ("Why did the scarecrow win an award?", "He was outstanding in his field!")
    ]
    
    var currentJokeIndex = 0
    var isShowingQuestion = true
    
    // UI
    let jokeLabel = UILabel()
    let nextButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        showCurrentJoke()
    }
    
    func setupUI() {
        view.backgroundColor = .white
        
        // label
        jokeLabel.textAlignment = .center
        jokeLabel.numberOfLines = 0
        jokeLabel.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        jokeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // button
        nextButton.setTitle("Show Answer", for: .normal)
        nextButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        nextButton.backgroundColor = .systemBlue
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.layer.cornerRadius = 10
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        
        // add to view
        view.addSubview(jokeLabel)
        view.addSubview(nextButton)
        
        // make subject
        NSLayoutConstraint.activate([
            jokeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            jokeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            jokeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            jokeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            nextButton.widthAnchor.constraint(equalToConstant: 150),
            nextButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func showCurrentJoke() {
        let joke = jokes[currentJokeIndex]
        
        if isShowingQuestion {
            jokeLabel.text = joke.0
            nextButton.setTitle("Show Answer", for: .normal)
        } else {
            jokeLabel.text = joke.1
            nextButton.setTitle("Next Joke", for: .normal)
        }
    }
    
    @objc func nextButtonTapped() {
        if isShowingQuestion {
            isShowingQuestion = false
        } else {
            isShowingQuestion = true
            currentJokeIndex = (currentJokeIndex + 1) % jokes.count
        }
        showCurrentJoke()
    }
    
    // 支持屏幕旋转
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .all
    }
}
