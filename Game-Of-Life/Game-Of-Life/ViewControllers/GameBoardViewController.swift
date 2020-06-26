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
    let randomNeuView = EMTNeumorphicView()
    let settingsButton = EMTNeumorphicButton()
    let patternButtonOneView = EMTNeumorphicView()
    let patternButtonTwoView = EMTNeumorphicView()
    let patternButtonThreeView = EMTNeumorphicView()
    let patternButtonOne = UIButton()
    let patternButtonTwo = UIButton()
    let patternButtonThree = UIButton()
    let randomButton = UIButton()
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        constraints()
        configureSubviews()
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
        configureNeuViews()
        configureButtons()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    @objc func playButtonTapped(_ sender: UIButton) {
        playButton.isSelected.toggle()
        gameController.isPlaying.toggle()
        if gameController.isPlaying {
            collectionView.isUserInteractionEnabled = false
            timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: startGame)
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
    
    @objc func randomPatternTapped(_ sender: UIButton) {
        gameController.randomPattern(collectionView: collectionView)
    }
    
    @objc func patternOneTapped(_ sender: UIButton) {
        gameController.pulsarPattern(collectionView: collectionView)
    }
    
    @objc func patternTwoTapped(_ sender: UIButton) {
        gameController.pentadecathlonPattern(collectionView: collectionView)
    }
    
    @objc func patternThreeTapped(_ sender: UIButton) {
        gameController.heavySpaceshipPattern(collectionView: collectionView)
    }
}
