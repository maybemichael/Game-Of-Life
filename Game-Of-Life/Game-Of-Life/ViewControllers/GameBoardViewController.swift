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
    let settingsButtonView = UIView()
    let settingsButton = EMTNeumorphicButton()
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        constraints()
        configureSubviews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        buttonCornerRadius()
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}