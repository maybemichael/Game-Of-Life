//
//  GameBoardViewController.swift
//  Game-Of-Life
//
//  Created by Michael McGrath on 6/24/20.
//  Copyright © 2020 Michael McGrath. All rights reserved.
//

import UIKit
import EMTNeumorphicView

class GameBoardViewController: UIViewController {

    let gameController = GameController()
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var generationLabel: UILabel!
    @IBOutlet weak var generationCountLabel: UILabel!
    @IBOutlet weak var generationLabelsStackView: UIStackView!
    var buttonView = EMTNeumorphicView()
    let playButton = EMTNeumorphicButton()
    let stepButton = EMTNeumorphicButton()
    let restartButton = EMTNeumorphicButton()
    let settingsView = EMTNeumorphicView()
    let neuView = EMTNeumorphicView()
    let randomNeuView = EMTNeumorphicView()
    let settingsButton = EMTNeumorphicButton()
    let patternButtonOneView = EMTNeumorphicView()
    let patternButtonTwoView = EMTNeumorphicView()
    let patternButtonThreeView = EMTNeumorphicView()
    let patternButtonOne = UIButton()
    let patternButtonTwo = UIButton()
    let patternButtonThree = UIButton()
    let randomButton = UIButton()
//    let randomButtonView = UIView()
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        constraints()
        configureSubviews()
       
//        configureButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        buttonCornerRadius()
        configureNeuViews()
        configureButtons()
    }
    
    @objc func playButtonTapped(_ sender: UIButton) {
        playButton.isSelected.toggle()
        gameController.isPlaying.toggle()
        if gameController.isPlaying {
            collectionView.isUserInteractionEnabled = false
            timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: startGame)
        } else {
            collectionView.isUserInteractionEnabled = true
            timer.invalidate()
        }
    }
    
    @objc func stepButtonTapped(_ sender: UIButton) {
        gameController.nextGenCells(collectionView: collectionView)
        updateViews()
    }
    
    @objc func restartButtonTapped(_ sender: UIButton) {
        gameController.clearBoard(collectionView: collectionView)
        updateViews()
    }
    
    @objc func settingsButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "SettingsSegue", sender: nil)
    }
    
    @objc func patternOneTapped(_ sender: UIButton) {
        gameController.pulsarPattern(collectionView: collectionView)
    }
    
    @objc func patternTwoTapped(_ sender: UIButton) {
        print("It Works!")
    }
    
    @objc func patternThreeTapped(_ sender: UIButton) {
        print("It maybe Works!")
    }
}
