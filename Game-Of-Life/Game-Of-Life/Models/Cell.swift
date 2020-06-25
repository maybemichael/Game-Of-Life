//
//  Cell.swift
//  Game-Of-Life
//
//  Created by Michael McGrath on 6/23/20.
//  Copyright © 2020 Michael McGrath. All rights reserved.
//

import SpriteKit

enum CellState {
    case alive
    case dead
}

//class Cell: SKSpriteNode {
//    let x: Int
//    let y: Int
//    var state: CellState = .dead {
//        didSet {
//            switch state {
//            case .alive:
//                self.isHidden = false
//            case .dead:
//                self.isHidden = true
//            }
//        }
//    }
//
//    init(x: Int, y: Int, state: CellState = .dead) {
//        self.x = x
//        self.y = y
//        self.state = state
//
//        let texture = SKTexture(imageNamed: "cell")
//        super.init(texture: texture, color: #colorLiteral(red: 0.5383173227, green: 0.8126530051, blue: 0.9402781129, alpha: 1), size: texture.size())
//
//        zPosition = 1
//
//        anchorPoint = CGPoint(x: 0, y: 0)
//
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    func isNeighbor(cell: Cell) -> Bool {
//        let xCord = abs(self.x - cell.x)
//        let yCord = abs(self.y - cell.y)
//
//        switch (xCord, yCord) {
//        case (1, 1), (0, 1), (1, 0):
//            return true
//        default:
//            return false
//        }
//    }
//}

class Cell {
    let x: Int
    let y: Int
    var state: CellState = .dead
    var liveNeighborCount = 0

    init(x: Int, y: Int, state: CellState = .dead) {
        self.x = x
        self.y = y
        self.state = state
    }
    
    func isNeighbor(cell: Cell) -> Bool {
        let xCord = abs(self.x - cell.x)
        let yCord = abs(self.y - cell.y)
        
        switch (xCord, yCord) {
        case (1, 1), (0, 1), (1, 0):
            return true
        default:
            return false
        }
    }
}
