//
//  GameController.swift
//  Game-Of-Life
//
//  Created by Michael McGrath on 6/24/20.
//  Copyright © 2020 Michael McGrath. All rights reserved.
//

import UIKit

class GameController {
    
    var cells: [Cell] = []
    var matrix: [[Cell]]?
    let columns = 25
    let rows = 25
    var liveCells: [Cell] = []
    var cellsToUpdate: [Cell] = []
    var isPlaying = false
    var generation = 0
    
    func createCells() {
        for x in 0..<columns {
            for y in 0..<rows {
                let newCell = Cell(x: x, y: y)
                cells.append(newCell)
            }
        }
        self.matrix = cells.chunked(into: 25)
    }
    
    func checkSurroundingCells() {
        for cell in cells {
            cell.liveNeighborCount = 0
            for x in (cell.x - 1)...(cell.x + 1) {
                if x < 0 || x >= columns {
                    continue
                }
                for y in (cell.y - 1)...(cell.y + 1) {
                    if y < 0 || y >= rows {
                        continue
                    }
                    if x == cell.x && y == cell.y {
                        continue
                    }
                    let neighborCell = matrix?[x][y]
                    if neighborCell?.state == .alive {
                        cell.liveNeighborCount += 1
                    }
                }
            }
        }
    }
    
    func nextGenCells2(collectionView: UICollectionView) {
        checkSurroundingCells()
        var indexPaths: [IndexPath] = []
        for cell in cells {
            switch cell.liveNeighborCount {
            case 3:
                self.matrix?[cell.x][cell.y].state = .alive
                let indexPath = IndexPath(item: cell.y, section: cell.x)
                indexPaths.append(indexPath)
                break
            case 0...1, 4...8:
                self.matrix?[cell.x][cell.y].state = .dead
                let indexPath = IndexPath(item: cell.y, section: cell.x)
                indexPaths.append(indexPath)
                break
            default:
                break
            }
        }
        collectionView.reloadItems(at: indexPaths)
    }
    
    func nextGenCells(collectionView: UICollectionView) {
        checkSurroundingCells()
        generation += 1
        for cell in cells {
            switch cell.liveNeighborCount {
            case 3:
                cell.state = .alive
                break
            case 0...1, 4...8:
                cell.state = .dead
                break
            default:
                break
            }
        }
        let updatedMatrix = cells.chunked(into: 25)
        self.matrix = updatedMatrix
        collectionView.reloadData()
    }
    
    func clearBoard(collectionView: UICollectionView) {
        for cell in cells {
            cell.state = .dead
        }
        generation = 0
        collectionView.reloadData()
    }
    
    func pulsarPattern(collectionView: UICollectionView) {
        let pulsarCells = [[13, 10], [13, 9], [13, 8], [14, 11], [15, 11], [16, 11], [14, 13], [15, 13], [16, 13], [13, 14], [13, 15], [13, 16], [11, 14], [11, 15], [11, 16], [11, 10], [11, 9], [11, 8], [10, 11], [9, 11], [8, 11], [10, 13], [9, 13], [8, 13], [6, 10], [6, 9], [6, 8], [6, 14], [6, 15], [6, 16], [10, 18], [9, 18], [8, 18], [14, 18], [15, 18], [16, 18], [18, 14], [18, 15], [18, 16], [18, 10], [18, 9], [18, 8], [14, 6], [15, 6], [16, 6], [10, 6], [9, 6], [8, 6]]
        for cell in cells {
            cell.state = .dead
        }
        for indexPath in pulsarCells {
            matrix?[indexPath[0]][indexPath[1]].state = .alive
        }
        collectionView.reloadData()
    }
    
    
    init() {
        createCells()
    }
}
