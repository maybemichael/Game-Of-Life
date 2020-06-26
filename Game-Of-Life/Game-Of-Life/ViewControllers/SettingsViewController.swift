//
//  SettingsViewController.swift
//  Game-Of-Life
//
//  Created by Michael McGrath on 6/25/20.
//  Copyright © 2020 Michael McGrath. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
     
    @IBOutlet weak var rulesLabel: UILabel!
    @IBOutlet weak var rule1Label: UILabel!
    @IBOutlet weak var rule2Label: UILabel!
    @IBOutlet weak var rule3Label: UILabel!
    @IBOutlet weak var rule4Label: UILabel!
    @IBOutlet weak var rule1Bullet: UILabel!
    @IBOutlet weak var rule2Bullet: UILabel!
    @IBOutlet weak var rule3Bullet: UILabel!
    @IBOutlet weak var rule4Bullet: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    
    func updateViews() {
        self.view.addGradient(color1: #colorLiteral(red: 0.4970824718, green: 0.8695255518, blue: 1, alpha: 0.8470588235), color2: #colorLiteral(red: 0.7894616723, green: 0.9426258206, blue: 0.6598886847, alpha: 0.8470588235))
        self.rulesLabel.textTitleShadow()
        self.rule1Label.textShadow2()
        self.rule2Label.textShadow2()
        self.rule3Label.textShadow2()
        self.rule4Label.textShadow2()
        self.rule1Bullet.textShadow2()
        self.rule2Bullet.textShadow2()
        self.rule3Bullet.textShadow2()
        self.rule4Bullet.textShadow2()
    }
}
