//
//  GoodJokesViewController.swift
//  iKid
//
//  Created by wangmeixue on 2026/2/7.
//

import UIKit

class PunJokesViewController: UIViewController {
    
    let jokes = [
        ("I'm reading a book on anti-gravity.", "It's impossible to put down!"),
        ("I used to be a baker...", "but I couldn't make enough dough."),
        ("What's orange and sounds like a parrot?", "A carrot!")
    ]
    
    var currentJokeIndex = 0
    var isShowingQuestion = true
    
    let jokeLabel = UILabel()
    let nextButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        showCurrentJoke()
    }
    
    func setupUI() {
        view.backgroundColor = .white
        
        jokeLabel.textAlignment = .center
        jokeLabel.numberOfLines = 0
        jokeLabel.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        jokeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        nextButton.setTitle("Show Answer", for: .normal)
        nextButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        nextButton.backgroundColor = .systemGreen
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.layer.cornerRadius = 10
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        
        view.addSubview(jokeLabel)
        view.addSubview(nextButton)
        
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
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .all
    }
}
