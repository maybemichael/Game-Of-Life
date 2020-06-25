//
//  GameBoardVC+Ext.swift
//  Game-Of-Life
//
//  Created by Michael McGrath on 6/24/20.
//  Copyright © 2020 Michael McGrath. All rights reserved.
//

import UIKit

extension GameBoardViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width / 25) - 0.5
        let height = width
        return CGSize(width: width, height: height)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return gameController.matrix?.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameController.matrix?[section].count ?? 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GameBoardCell", for: indexPath) as? GameBoardCollectionViewCell else { return UICollectionViewCell() }
        
        let gameCell = gameController.matrix?[indexPath.section][indexPath.item]
        cell.gameCell = gameCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let gameCell = gameController.matrix?[indexPath.section][indexPath.item]
        if gameCell?.state == .alive {
            gameCell?.state = .dead
        } else {
            gameCell?.state = .alive
        }
        collectionView.reloadItems(at: [indexPath])
    }
    
    func startGame(timer: Timer) {
        gameController.nextGenCells(collectionView: collectionView)
        updateViews()
    }
    
    func updateViews() {
        generationCountLabel.text = "\(gameController.generation)"
    }
    
    func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        self.view.addGradient(color1: #colorLiteral(red: 0.7894616723, green: 0.9426258206, blue: 0.6598886847, alpha: 0.8470588235), color2: #colorLiteral(red: 0.4970824718, green: 0.8695255518, blue: 1, alpha: 0.8470588235))
        collectionView.layer.borderWidth = 2.0
        collectionView.layer.borderColor = UIColor.black.cgColor
        collectionView.anchor(top: nil, leading: nil, trailing: nil, bottom: nil, centerX: view.centerXAnchor, centerY: view.centerYAnchor, padding: .zero, size: .init(width: UIScreen.main.bounds.width - 16, height: UIScreen.main.bounds.width - 12))
        titleLabel.textShadow()
    }
    
    func constraints() {
        view.addSubview(buttonView)
        buttonView.anchor(top: collectionView.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: nil, centerX: view.centerXAnchor, centerY: nil, padding: .init(top: 40, left: 48, bottom: 0, right: -48), size: .init(width: UIScreen.main.bounds.width - 96, height: 64))
        buttonView.addSubview(playButton)
        buttonView.addSubview(stepButton)
        buttonView.addSubview(restartButton)
        playButton.anchor(top: nil, leading: nil, trailing: nil, bottom: nil, centerX: buttonView.centerXAnchor, centerY: buttonView.centerYAnchor, padding: .zero, size: .init(width: 48, height: 48))
        stepButton.anchor(top: nil, leading: playButton.trailingAnchor, trailing: nil, bottom: nil, centerX: nil, centerY: buttonView.centerYAnchor, padding: .init(top: 0, left: 40, bottom: 0, right: 0), size: .init(width: 48, height: 48))
        restartButton.anchor(top: nil, leading: nil, trailing: playButton.leadingAnchor, bottom: nil, centerX: nil, centerY: buttonView.centerYAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: -40), size: .init(width: 48, height: 48))
        generationLabelsStackView.anchor(top: nil, leading: nil, trailing: nil, bottom: collectionView.topAnchor, centerX: view.centerXAnchor, centerY: nil, padding: .init(top: 0, left: 0, bottom: -20, right: 0), size: .zero)
        titleLabel.anchor(top: nil, leading: nil, trailing: nil, bottom: generationLabelsStackView.topAnchor, centerX: view.centerXAnchor, centerY: nil, padding: .init(top: 0, left: 0, bottom: -20, right: 0), size: .zero)
        view.addSubview(settingsView)
        settingsView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, trailing: nil, bottom: nil, centerX: nil, centerY: nil, padding: .init(top: 8, left: 20, bottom: 0, right: 0), size: .init(width: 60, height: 60))
        settingsView.addSubview(neuView)
        neuView.anchor(top: nil, leading: nil, trailing: nil, bottom: nil, centerX: settingsView.centerXAnchor, centerY: settingsView.centerYAnchor, padding: .zero, size: .init(width: 50, height: 50))
        neuView.addSubview(settingsButtonView)
        settingsButtonView.anchor(top: nil, leading: nil, trailing: nil, bottom: nil, centerX: neuView.centerXAnchor, centerY: neuView.centerYAnchor, padding: .zero, size: .init(width: 50, height: 50))
        settingsButtonView.addSubview(settingsButton)
        settingsButton.anchor(top: nil, leading: nil, trailing: nil, bottom: nil, centerX: settingsButtonView.centerXAnchor, centerY: settingsButtonView.centerYAnchor, padding: .zero, size: .init(width: 48, height: 48))
    }
    
    func configureSubviews() {
        stepButton.imageEdgeInsets = UIEdgeInsets(top: -4.8, left: -4.8, bottom: -4.8, right: -4.8)
        playButton.imageEdgeInsets = UIEdgeInsets(top: -4.8, left: -4.8, bottom: -4.8, right: -4.8)
        restartButton.imageEdgeInsets = UIEdgeInsets(top: -4.8, left: -4.8, bottom: -4.8, right: -4.8)
        
        settingsButtonView.layer.masksToBounds = true
        playButton.contentVerticalAlignment = .fill
        playButton.contentHorizontalAlignment = .fill
        stepButton.contentVerticalAlignment = .fill
        stepButton.contentHorizontalAlignment = .fill
        restartButton.contentVerticalAlignment = .fill
        restartButton.contentHorizontalAlignment = .fill
        buttonView.layer.cornerRadius = 20
        settingsView.layer.cornerRadius = settingsView.bounds.width / 2
        playButton.layer.masksToBounds = true
        stepButton.layer.masksToBounds = true
        restartButton.layer.masksToBounds = true
        playButton.setImage(UIImage(named: "play_icon"), for: .normal)
        playButton.setImage(UIImage(named: "pause_icon"), for: .selected)
        stepButton.setImage(UIImage(named: "next_icon"), for: .normal)
        restartButton.setImage(UIImage(named: "restart_icon"), for: .normal)
        settingsButton.setImage(UIImage(named: "settings_icon"), for: .normal)
        settingsButton.neumorphicLayer?.elementDepth = 7
        settingsView.neumorphicLayer?.elementDepth = 7
        buttonView.neumorphicLayer?.elementDepth = 7
        neuView.neumorphicLayer?.elementDepth = 7
        playButton.neumorphicLayer?.elementDepth = 7
        stepButton.neumorphicLayer?.elementDepth = 7
        restartButton.neumorphicLayer?.elementDepth = 7
        playButton.neumorphicLayer?.elementColor = #colorLiteral(red: 0.7894616723, green: 0.9426258206, blue: 0.6598886847, alpha: 0.8470588235)
        restartButton.neumorphicLayer?.elementColor = #colorLiteral(red: 0.7894616723, green: 0.9426258206, blue: 0.6598886847, alpha: 0.8470588235)
        stepButton.neumorphicLayer?.elementColor = #colorLiteral(red: 0.7894616723, green: 0.9426258206, blue: 0.6598886847, alpha: 0.8470588235)
        neuView.neumorphicLayer?.elementColor = #colorLiteral(red: 0.7894616723, green: 0.9426258206, blue: 0.6598886847, alpha: 0.8470588235)
        settingsButton.neumorphicLayer?.elementColor = UIColor.clear.cgColor
        buttonView.neumorphicLayer?.elementBackgroundColor = #colorLiteral(red: 0.4970824718, green: 0.8695255518, blue: 1, alpha: 0.8470588235)
        settingsView.neumorphicLayer?.elementBackgroundColor = #colorLiteral(red: 0.6968801618, green: 0.9205616117, blue: 0.8583740592, alpha: 1)
        playButton.neumorphicLayer?.elementBackgroundColor = #colorLiteral(red: 0.7894616723, green: 0.9426258206, blue: 0.6598886847, alpha: 0.8470588235)
        stepButton.neumorphicLayer?.elementBackgroundColor = #colorLiteral(red: 0.7894616723, green: 0.9426258206, blue: 0.6598886847, alpha: 0.8470588235)
        restartButton.neumorphicLayer?.elementBackgroundColor = #colorLiteral(red: 0.7894616723, green: 0.9426258206, blue: 0.6598886847, alpha: 0.8470588235)
        neuView.neumorphicLayer?.elementBackgroundColor = #colorLiteral(red: 0.4970824718, green: 0.8695255518, blue: 1, alpha: 0.8470588235)
        settingsButton.neumorphicLayer?.elementBackgroundColor = UIColor.clear.cgColor
        
        playButton.neumorphicLayer?.darkShadowOpacity = 0.7
        stepButton.neumorphicLayer?.darkShadowOpacity = 0.7
        restartButton.neumorphicLayer?.darkShadowOpacity = 0.7
        settingsButton.neumorphicLayer?.darkShadowOpacity = 0.7
        neuView.neumorphicLayer?.darkShadowOpacity = 0.7
        playButton.neumorphicLayer?.lightShadowOpacity = 0.4
        stepButton.neumorphicLayer?.lightShadowOpacity = 0.4
        restartButton.neumorphicLayer?.lightShadowOpacity = 0.4
        settingsButton.neumorphicLayer?.lightShadowOpacity = 0.4
        neuView.neumorphicLayer?.lightShadowOpacity = 0.4
        playButton.addTarget(self, action: #selector(playButtonTapped(_:)), for: .touchUpInside)
        stepButton.addTarget(self, action: #selector(stepButtonTapped(_:)), for: .touchUpInside)
        restartButton.addTarget(self, action: #selector(restartButtonTapped(_:)), for: .touchUpInside)
    }
    
    func buttonCornerRadius() {
        playButton.layer.cornerRadius = playButton.bounds.width / 2
        stepButton.layer.cornerRadius = stepButton.bounds.width / 2
        restartButton.layer.cornerRadius = restartButton.bounds.width / 2
        settingsView.layer.cornerRadius = settingsView.bounds.width / 2
        settingsButtonView.layer.cornerRadius = settingsButtonView.bounds.width / 2
        neuView.layer.cornerRadius = neuView.bounds.width / 2
        settingsButton.layer.cornerRadius = settingsButton.bounds.width / 2
        settingsButtonView.addGradient2(color1: #colorLiteral(red: 0, green: 0.7310971022, blue: 0.9994077086, alpha: 1), color2: #colorLiteral(red: 0.0009124627686, green: 0.5192523003, blue: 0.9988625646, alpha: 1))
    }
}
