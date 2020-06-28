//
//  GameBoardVC+Ext.swift
//  Game-Of-Life
//
//  Created by Michael McGrath on 6/24/20.
//  Copyright © 2020 Michael McGrath. All rights reserved.
//

import UIKit

extension GameBoardViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UIGestureRecognizerDelegate {
    
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
        print("Gamecell: (\(String(describing: gameCell?.x)), \(String(describing: gameCell?.y)))")
        collectionView.reloadItems(at: [indexPath])
    }
    
    func startGame(timer: Timer) {
        gameController.getNextGeneration(collectionView: collectionView)
//        gameController.updateBoard(collectionView: collectionView)
//        gameController.nextGenCells(collectionView: collectionView)
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
        collectionView.canCancelContentTouches = false
        collectionView.allowsMultipleSelection = true
        titleLabel.textShadow()
    }
    
    func constraints() {
        view.addSubview(buttonView)
        buttonView.anchor(top: collectionView.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: nil, centerX: view.centerXAnchor, centerY: nil, padding: .init(top: 40, left: 48, bottom: 0, right: -48), size: .init(width: 48 * 6.5, height: 128))
        buttonView.addSubview(playButton)
        buttonView.addSubview(stepButton)
        buttonView.addSubview(restartButton)
        buttonView.addSubview(randomNeuView)
        buttonView.addSubview(patternButtonOneView)
        buttonView.addSubview(patternButtonTwoView)
        buttonView.addSubview(patternButtonThreeView)
        playButton.anchor(top: buttonView.topAnchor, leading: nil, trailing: nil, bottom: nil, centerX: buttonView.centerXAnchor, centerY: nil, padding: .init(top: 10, left: 0, bottom: 0, right: 0), size: .init(width: 48, height: 48))
        stepButton.anchor(top: nil, leading: playButton.trailingAnchor, trailing: nil, bottom: nil, centerX: nil, centerY: playButton.centerYAnchor, padding: .init(top: 0, left: 24, bottom: 0, right: 0), size: .init(width: 48, height: 48))
        restartButton.anchor(top: nil, leading: nil, trailing: playButton.leadingAnchor, bottom: nil, centerX: nil, centerY: playButton.centerYAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: -24), size: .init(width: 48, height: 48))
        generationLabelsStackView.anchor(top: nil, leading: nil, trailing: nil, bottom: collectionView.topAnchor, centerX: view.centerXAnchor, centerY: nil, padding: .init(top: 0, left: 0, bottom: -20, right: 0), size: .zero)
        randomNeuView.anchor(top: nil, leading: nil, trailing: restartButton.centerXAnchor, bottom: buttonView.bottomAnchor, centerX: nil, centerY: nil, padding: .init(top: 0, left: 0, bottom: -10, right: -12), size: .init(width: 48, height: 48))
        randomNeuView.addSubview(randomButton)
        randomButton.anchor(top: nil, leading: nil, trailing: nil, bottom: nil, centerX: randomNeuView.centerXAnchor, centerY: randomNeuView.centerYAnchor, padding: .zero, size: .init(width: 48, height: 48))
        patternButtonOneView.anchor(top: nil, leading: nil, trailing: playButton.centerXAnchor, bottom: buttonView.bottomAnchor, centerX: nil, centerY: nil, padding: .init(top: 0, left: 0, bottom: -10, right: -12), size: .init(width: 48, height: 48))
        patternButtonOneView.addSubview(patternButtonOne)
        patternButtonOne.anchor(top: nil, leading: nil, trailing: nil, bottom: nil, centerX: patternButtonOneView.centerXAnchor, centerY: patternButtonOneView.centerYAnchor, padding: .zero, size: .init(width: 48, height: 48))
        patternButtonTwoView.anchor(top: nil, leading: playButton.centerXAnchor, trailing: nil, bottom: buttonView.bottomAnchor, centerX: nil, centerY: nil, padding: .init(top: 0, left: 12, bottom: -10, right: 0), size: .init(width: 48, height: 48))
        patternButtonTwoView.addSubview(patternButtonTwo)
        patternButtonTwo.anchor(top: nil, leading: nil, trailing: nil, bottom: nil, centerX: patternButtonTwoView.centerXAnchor, centerY: patternButtonTwoView.centerYAnchor, padding: .zero, size: .init(width: 48, height: 48))
        patternButtonThreeView.anchor(top: nil, leading: patternButtonTwoView.trailingAnchor, trailing: nil, bottom: buttonView.bottomAnchor, centerX: nil, centerY: nil, padding: .init(top: 0, left: 24, bottom: -10, right: 0), size: .init(width: 48, height: 48))
        patternButtonThreeView.addSubview(patternButtonThree)
        patternButtonThree.anchor(top: nil, leading: nil, trailing: nil, bottom: nil, centerX: patternButtonThreeView.centerXAnchor, centerY: patternButtonThreeView.centerYAnchor, padding: .zero, size: .init(width: 48, height: 48))
        view.addSubview(settingsView)
        settingsView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, trailing: nil, bottom: nil, centerX: nil, centerY: nil, padding: .init(top: 8, left: 20, bottom: 0, right: 0), size: .init(width: 50, height: 50))

        settingsView.addSubview(settingsButton)
        settingsButton.anchor(top: nil, leading: nil, trailing: nil, bottom: nil, centerX: settingsView.centerXAnchor, centerY: settingsView.centerYAnchor, padding: .zero, size: .init(width: 48, height: 48))
        titleLabel.anchor(top: nil, leading: nil, trailing: nil, bottom: generationLabelsStackView.topAnchor, centerX: view.centerXAnchor, centerY: nil, padding: .init(top: 0, left: 0, bottom: -20, right: 0), size: .zero)
    }
    
    func configureSubviews() {
        stepButton.imageEdgeInsets = UIEdgeInsets(top: -4.8, left: -4.8, bottom: -4.8, right: -4.8)
        playButton.imageEdgeInsets = UIEdgeInsets(top: -4.8, left: -4.8, bottom: -4.8, right: -4.8)
        restartButton.imageEdgeInsets = UIEdgeInsets(top: -4.8, left: -4.8, bottom: -4.8, right: -4.8)
        randomButton.imageEdgeInsets = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
        patternButtonOne.imageEdgeInsets = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 12)
    }
    
    func configureNeuViews() {
        // MARK: - Button View
        buttonView.configureView(depth: 7, lightShadowColor: #colorLiteral(red: 0.4970824718, green: 0.8695255518, blue: 1, alpha: 0.8470588235), backgroundColor: #colorLiteral(red: 0.4970824718, green: 0.8695255518, blue: 1, alpha: 0.8470588235), lightOpacity: 0.4, darkOpacity: 0.7)
        buttonView.layer.cornerRadius = 20
        
        // MARK: - Info Button View
        settingsView.configureView(depth: 7, lightShadowColor: #colorLiteral(red: 0.7894616723, green: 0.9426258206, blue: 0.6598886847, alpha: 0.8470588235), backgroundColor: #colorLiteral(red: 0.7894616723, green: 0.9426258206, blue: 0.6598886847, alpha: 0.8470588235), lightOpacity: 0.7, darkOpacity: 0.2)
        settingsView.layer.cornerRadius = settingsView.bounds.width / 2
        
        // MARK: - Random Button View
        randomNeuView.configureView(depth: 7, lightShadowColor: #colorLiteral(red: 0.7894616723, green: 0.9426258206, blue: 0.6598886847, alpha: 0.8470588235), backgroundColor: #colorLiteral(red: 0.7894616723, green: 0.9426258206, blue: 0.6598886847, alpha: 0.8470588235), lightOpacity: 0.4, darkOpacity: 0.7)
        randomNeuView.layer.cornerRadius = randomNeuView.bounds.width / 2
        
        // MARK: - Pattern One Button View
        patternButtonOneView.configureView(depth: 7, lightShadowColor: #colorLiteral(red: 0.7894616723, green: 0.9426258206, blue: 0.6598886847, alpha: 0.8470588235), backgroundColor: #colorLiteral(red: 0.7894616723, green: 0.9426258206, blue: 0.6598886847, alpha: 0.8470588235), lightOpacity: 0.4, darkOpacity: 0.7)
        patternButtonOneView.layer.cornerRadius = patternButtonOneView.bounds.width / 2
        
        // MARK: - Pattern Two Button View
        patternButtonTwoView.configureView(depth: 7, lightShadowColor: #colorLiteral(red: 0.7894616723, green: 0.9426258206, blue: 0.6598886847, alpha: 0.8470588235), backgroundColor: #colorLiteral(red: 0.7894616723, green: 0.9426258206, blue: 0.6598886847, alpha: 0.8470588235), lightOpacity: 0.4, darkOpacity: 0.7)
        patternButtonTwoView.layer.cornerRadius = patternButtonTwoView.bounds.width / 2
        
        // MARK: - Pattern Three Button View
        patternButtonThreeView.configureView(depth: 7, lightShadowColor: #colorLiteral(red: 0.7894616723, green: 0.9426258206, blue: 0.6598886847, alpha: 0.8470588235), backgroundColor: #colorLiteral(red: 0.7894616723, green: 0.9426258206, blue: 0.6598886847, alpha: 0.8470588235), lightOpacity: 0.4, darkOpacity: 0.7)
        patternButtonThreeView.layer.cornerRadius = patternButtonThreeView.bounds.width / 2
    }
    
    func configureButtons() {
        
        // MARK: - Play Button
        playButton.layer.masksToBounds = true
        playButton.configureButton(depth: 7, lightShadowColor: #colorLiteral(red: 0.7894616723, green: 0.9426258206, blue: 0.6598886847, alpha: 0.8470588235), backgroundColor: #colorLiteral(red: 0.7894616723, green: 0.9426258206, blue: 0.6598886847, alpha: 0.8470588235), lightOpacity: 0.4, darkOpacity: 0.7)
        playButton.layer.cornerRadius = playButton.bounds.width / 2
        playButton.setImage(UIImage(named: "play_icon"), for: .normal)
        playButton.setImage(UIImage(named: "pause_icon"), for: .selected)
        playButton.contentVerticalAlignment = .fill
        playButton.contentHorizontalAlignment = .fill
        playButton.addTarget(self, action: #selector(playButtonTapped(_:)), for: .touchUpInside)
        
        // MARK: - Step Button
        stepButton.layer.masksToBounds = true
        stepButton.configureButton(depth: 7, lightShadowColor: #colorLiteral(red: 0.7894616723, green: 0.9426258206, blue: 0.6598886847, alpha: 0.8470588235), backgroundColor: #colorLiteral(red: 0.7894616723, green: 0.9426258206, blue: 0.6598886847, alpha: 0.8470588235), lightOpacity: 0.4, darkOpacity: 0.7)
        stepButton.layer.cornerRadius = stepButton.bounds.width / 2
        stepButton.setImage(UIImage(named: "next_icon"), for: .normal)
        stepButton.contentVerticalAlignment = .fill
        stepButton.contentHorizontalAlignment = .fill
        stepButton.addTarget(self, action: #selector(stepButtonTapped(_:)), for: .touchUpInside)
        
        // MARK: - Restart Button
        restartButton.layer.masksToBounds = true
        restartButton.configureButton(depth: 7, lightShadowColor: #colorLiteral(red: 0.7894616723, green: 0.9426258206, blue: 0.6598886847, alpha: 0.8470588235), backgroundColor: #colorLiteral(red: 0.7894616723, green: 0.9426258206, blue: 0.6598886847, alpha: 0.8470588235), lightOpacity: 0.4, darkOpacity: 0.7)
        restartButton.layer.cornerRadius = restartButton.bounds.width / 2
        restartButton.setImage(UIImage(named: "restart_icon"), for: .normal)
        restartButton.contentVerticalAlignment = .fill
        restartButton.contentHorizontalAlignment = .fill
        restartButton.addTarget(self, action: #selector(restartButtonTapped(_:)), for: .touchUpInside)
        
        // MARK: - Random Button
        randomButton.layer.masksToBounds = true
        
        randomButton.layer.cornerRadius = randomButton.bounds.width / 2
        randomButton.addGradient2(color1: #colorLiteral(red: 0, green: 0.7310971022, blue: 0.9994077086, alpha: 1), color2: #colorLiteral(red: 0.0009124627686, green: 0.5192523003, blue: 0.9988625646, alpha: 1))
        randomButton.setImage(UIImage(named: "random_icon"), for: .normal)
        randomButton.contentVerticalAlignment = .fill
        randomButton.contentHorizontalAlignment = .fill
        randomButton.addTarget(self, action: #selector(randomPatternTapped(_:)), for: .touchUpInside)
        
        // MARK: - Settings Button
        settingsButton.configureButton(depth: 7, lightShadowColor: #colorLiteral(red: 0.7894616723, green: 0.9426258206, blue: 0.6598886847, alpha: 0.8470588235), backgroundColor: #colorLiteral(red: 0.4970824718, green: 0.8695255518, blue: 1, alpha: 0.8470588235), lightOpacity: 0.4, darkOpacity: 0.7)
        settingsButton.layer.cornerRadius = settingsButton.bounds.width / 2
        settingsButton.setImage(UIImage(named: "info_icon"), for: .normal)
        settingsButton.addTarget(self, action: #selector(settingsButtonTapped), for: .touchUpInside)
        
        // MARK: - Pattern Button One
        patternButtonOne.layer.masksToBounds = true
        patternButtonOne.layer.cornerRadius = patternButtonOne.bounds.width / 2
        let style = NSMutableParagraphStyle()
        style.alignment = .center
        let buttonTitle = NSAttributedString(string: "1", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: "Montserrat-SemiBold", size: 40)!, NSAttributedString.Key.paragraphStyle: style])
        patternButtonOne.setAttributedTitle(buttonTitle, for: .normal)
        patternButtonOne.addGradient2(color1: #colorLiteral(red: 0, green: 0.7310971022, blue: 0.9994077086, alpha: 1), color2: #colorLiteral(red: 0.0009124627686, green: 0.5192523003, blue: 0.9988625646, alpha: 1))
        patternButtonOne.contentVerticalAlignment = .fill
        patternButtonOne.contentHorizontalAlignment = .fill
        patternButtonOne.addTarget(self, action: #selector(patternOneTapped), for: .touchUpInside)
        
        // MARK: - Pattern Button Two
        patternButtonTwo.layer.masksToBounds = true
        patternButtonTwo.layer.cornerRadius = patternButtonTwo.bounds.width / 2
        let buttonTitle2 = NSAttributedString(string: "2", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: "Montserrat-SemiBold", size: 40)!, NSAttributedString.Key.paragraphStyle: style])
        patternButtonTwo.setAttributedTitle(buttonTitle2, for: .normal)
        patternButtonTwo.addGradient2(color1: #colorLiteral(red: 0, green: 0.7310971022, blue: 0.9994077086, alpha: 1), color2: #colorLiteral(red: 0.0009124627686, green: 0.5192523003, blue: 0.9988625646, alpha: 1))
        patternButtonTwo.contentVerticalAlignment = .fill
        patternButtonTwo.contentHorizontalAlignment = .fill
        patternButtonTwo.addTarget(self, action: #selector(patternTwoTapped(_:)), for: .touchUpInside)
        
        // MARK: - Pattern Button Three
        patternButtonThree.layer.masksToBounds = true
        patternButtonThree.layer.cornerRadius = patternButtonThree.bounds.width / 2
        let buttonTitle3 = NSAttributedString(string: "3", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: "Montserrat-SemiBold", size: 40)!, NSAttributedString.Key.paragraphStyle: style])
        patternButtonThree.setAttributedTitle(buttonTitle3, for: .normal)
        patternButtonThree.addGradient2(color1: #colorLiteral(red: 0, green: 0.7310971022, blue: 0.9994077086, alpha: 1), color2: #colorLiteral(red: 0.0009124627686, green: 0.5192523003, blue: 0.9988625646, alpha: 1))
        patternButtonThree.contentVerticalAlignment = .fill
        patternButtonThree.contentHorizontalAlignment = .fill
        patternButtonThree.addTarget(self, action: #selector(patternThreeTapped(_:)), for: .touchUpInside)
        
    }
}
