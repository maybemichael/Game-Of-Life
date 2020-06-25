//
//  GameBoardCollectionViewCell.swift
//  Game-Of-Life
//
//  Created by Michael McGrath on 6/24/20.
//  Copyright © 2020 Michael McGrath. All rights reserved.
//

import UIKit

class GameBoardCollectionViewCell: UICollectionViewCell {
    
    var gameCell: Cell? {
        didSet {
            updateViews()
        }
    }
    @IBOutlet weak var gameCellView: UIView! {
        didSet {
            gameCellView.backgroundColor = #colorLiteral(red: 0, green: 0.4817361832, blue: 0.9873190522, alpha: 1)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    
    func updateViews() {
        guard let gameCell = gameCell else { return }
        if gameCell.state == .alive {
            gameCellView.isHidden = false
        } else {
            gameCellView.isHidden = true 
        }
    }

    func setupViews() {
        contentView.layer.borderColor = UIColor.black.cgColor
        contentView.layer.borderWidth = 1.0
    }
}
