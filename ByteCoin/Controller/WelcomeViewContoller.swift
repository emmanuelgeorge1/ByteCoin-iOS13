//
//  WelcomeViewContoller.swift
//  ByteCoin
//
//  Created by Emmanuel George on 28/08/22.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
                titleLabel.text=""
                var charIndex = 0.0
                let titleText = "₿yteCoin"
                for letter in titleText {
                    Timer.scheduledTimer(withTimeInterval: 0.1*charIndex, repeats: false) { (timer) in
                        self.titleLabel.text?.append(letter)
                    }
                    charIndex+=1
                }
    }

    }
    

