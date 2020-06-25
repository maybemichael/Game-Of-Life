//
//  GameScene.swift
//  Game-Of-Life
//
//  Created by Michael McGrath on 6/23/20.
//  Copyright © 2020 Michael McGrath. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    let rows = 25
    let columns = 25
    
    var cellWidth = UIScreen.main.bounds.width / 25
    var cellHeight = UIScreen.main.bounds.width / 25
    
    var cells: [Cell] = []
    
    override init(size: CGSize) {
        super.init(size: size)
        
        anchorPoint = CGPoint(x: 0, y: 0)
        self.isUserInteractionEnabled = true
//        addCells()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        anchorPoint = CGPoint(x: 0, y: 0)
        self.isUserInteractionEnabled = true
//        addCells()
    }
    
//    func addCells() {
//
//        createGameBoard()
        
//        for cell in cells {
//            let cellPosition = CGPoint(x: cell.x * Int(cellWidth), y: cell.y * Int(cellHeight))
//            cell.position = cellPosition
//            addChild(cell)
//        }
//    }
//
//    func createCells(x: Int, y: Int) {
//        let newCell = Cell(x: x, y: y, state: .dead)
//
////        let cellPosition = CGPoint(x: x * Int(cellWidth), y: y * Int(cellHeight))
////        newCell.position = cellPosition
//        newCell.isHidden = true
////        addChild(newCell)
//
//        cells.append(newCell)
//    }
    
//    func createGameBoard() {
//        for x in 0..<columns {
//            for y in 0..<rows {
//                createCells(x: x, y: y)
//            }
//        }
//    }
    
    func updateCells() {
        var nextGenCells = [Cell]()
        let liveCells = cells.filter { $0.state == .alive }
        
        for cell in cells {
            let livingNeighbors = liveCells.filter { $0.isNeighbor(cell: cell) }
            switch livingNeighbors.count {
            case 2...3 where cell.state == .alive:
                nextGenCells.append(cell)
            case 3 where cell.state == .dead:
                let liveCell = Cell(x: cell.x, y: cell.y, state: .alive)
                nextGenCells.append(liveCell)
            default:
                let deadCell = Cell(x: cell.x, y: cell.y, state: .dead)
                nextGenCells.append(deadCell)
            }
        }
        
        cells = nextGenCells
    }
    
//    func updateNextGenCells() {
//        for cell in cells {
//            for
//        }
//    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let xPoint = Int(location.x) / Int(cellWidth)
            let yPoint = Int(location.y) / Int(cellHeight)
            
            if let index = cells.firstIndex(where: {$0.x == xPoint && $0.y == yPoint}) {
                let selectedCell = cells[index]
                if selectedCell.state == .alive {
                    selectedCell.state = .dead
                } else {
                    selectedCell.state = .alive
                }
                print("Cell Index: \(index)")
                print("(\(cells[index].x), \(cells[index].y))")
                print("Compared to (\(xPoint), \(yPoint))")
                print("Cell's state: \(cells[index].state)")
            }
        }
    }
}
