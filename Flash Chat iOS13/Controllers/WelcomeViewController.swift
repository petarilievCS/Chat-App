//
//  SceneDelegate.swift
//  Flash Chat iOS13
//
//  Created by Petar Iliev on 07/11/2022.
//  Copyright © 2022 Petar Iliev. All rights reserved.
//


import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = ""
        let title = "⚡️FlashChat"
        
        // Add animation for title
        var time = 0.0
        for letter in title {
            Timer.scheduledTimer(withTimeInterval: time, repeats: false) { timer in
                self.titleLabel.text?.append(letter)
            }
            time += 0.1
        }
    }
}
