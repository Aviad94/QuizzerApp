//
//  WelcomeVC.swift
//  TheQuizzler - iOS
//
//  Created by Aviad Sabag on 09/11/2020.
//

import Foundation
import UIKit


class StartupViewController: UIViewController {
    
    
    let titleLabel = UILabel()
    let bodyLabel = UILabel()
    
    fileprivate func setupLabels() {
        titleLabel.text = "Start the game!"
        titleLabel.lineBreakMode = .byClipping
        titleLabel.font = UIFont(name: "Futura", size: 20)
        
        bodyLabel.text = "Welcome to our quiz, in this quiz you gonna answer 3 questions, remember the one who scores the most win the game, good luck!"
        
        bodyLabel.numberOfLines = 0
    }
    
    fileprivate func setupStackView() {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, bodyLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        view.addSubview(stackView)
        
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -100).isActive = true
    }
    
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLabels()
        setupStackView()

        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapAnimations)))
        
        
        
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        self.titleLabel.alpha = 1
        self.bodyLabel.alpha = 1
    }
    
    
    @objc fileprivate func handleTapAnimations() {
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut) {
            
            
            self.titleLabel.transform = CGAffineTransform(translationX: -30, y: 0)
            
        } completion: { (_) in
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.titleLabel.alpha = 0
                self.titleLabel.transform = self.titleLabel.transform.translatedBy(x: 0, y: -200)
                
            })
        }


        UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut) {
            
            
            self.bodyLabel.transform = CGAffineTransform(translationX: -30, y: 0)
            
        } completion: { (_) in
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.bodyLabel.alpha = 0
                self.bodyLabel.transform = self.bodyLabel.transform.translatedBy(x: 0, y: -200)

                
            })
        }
        
        
    }
    
    
    
}
