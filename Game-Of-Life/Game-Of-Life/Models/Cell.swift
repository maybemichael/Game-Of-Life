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

class Cell: Hashable {
    static func == (lhs: Cell, rhs: Cell) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
    }
    
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
