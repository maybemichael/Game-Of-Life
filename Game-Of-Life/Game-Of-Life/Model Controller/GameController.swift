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
    var nextGenMatrix: [[Cell]] = []
    let columns = 25
    let rows = 25
    var liveCells: Set<Cell> = []
    var cellsToUpdate: [Cell] = []
    var isPlaying = false
    var generation = 0
    var generationsArray: [Set<Cell>] = []
    var generationsArray2: [Dictionary<Cell, Int>] = []
    
    func createCells() {
        for x in 0..<columns {
            for y in 0..<rows {
                let newCell = Cell(x: x, y: y)
                cells.append(newCell)
            }
        }
        self.matrix = cells.chunked(into: 25)
        self.nextGenMatrix = cells.chunked(into: 25)
    }
    
    func getLiveCells() {
        if liveCells.count == 0 {
            for cell in cells {
                if cell.state == .alive {
                    liveCells.insert(cell)
                }
            }
        }
    }
    
    func getNeighbors2(cell: Cell, max: Int) -> [Cell] {
        guard let matrix = self.matrix else { fatalError() }
        var liveCellNeighbors = [Cell]()
        
        if cell.x - 1 > 0 && cell.y - 1 > 0 {
            liveCellNeighbors.append(matrix[cell.x - 1][cell.y - 1])
        } else {
            liveCellNeighbors.append(matrix[max - 1][max - 1])
        }
        
        if cell.y - 1 > 0 {
            liveCellNeighbors.append(matrix[cell.x][cell.y - 1])
        } else {
            liveCellNeighbors.append(matrix[cell.x][max - 1])
        }
        
        if cell.x + 1 < max && cell.y - 1 > 0 {
            liveCellNeighbors.append(matrix[cell.x + 1][cell.y - 1])
        } else {
            liveCellNeighbors.append(matrix[0][max - 1])
        }
        
        if cell.x - 1 > 0 {
            liveCellNeighbors.append(matrix[cell.x - 1][cell.y])
        } else {
            liveCellNeighbors.append(matrix[max - 1][cell.y])
        }
        
        if cell.x + 1 < max {
            liveCellNeighbors.append(matrix[cell.x + 1][cell.y])
        } else {
            liveCellNeighbors.append(matrix[0][cell.y])
        }
        
        if cell.x - 1 > 0 && cell.y + 1 < max {
            liveCellNeighbors.append(matrix[cell.x - 1][cell.y + 1])
        } else {
            liveCellNeighbors.append(matrix[max - 1][0])
        }
        
        if cell.y + 1 < max {
            liveCellNeighbors.append(matrix[cell.x][cell.y + 1])
        } else {
            liveCellNeighbors.append(matrix[cell.x][0])
        }
        
        if cell.x + 1 < max && cell.y + 1 < max {
            liveCellNeighbors.append(matrix[cell.x + 1][cell.y + 1])
        } else {
            liveCellNeighbors.append(matrix[0][0])
        }
        
//        var neighbors = [
//            matrix[cell.x - 1][cell.y - 1],
//            matrix[cell.x]    [cell.y - 1],
//            matrix[cell.x + 1][cell.y - 1],
//            matrix[cell.x - 1][cell.y],
//            matrix[cell.x + 1][cell.y],
//            matrix[cell.x - 1][cell.y + 1],
//            matrix[cell.x]    [cell.y + 1],
//            matrix[cell.x + 1][cell.y + 1]
//        ]
 
        return liveCellNeighbors
    }
    
    func getNeighbors(cell: Cell, max: Int) -> [Cell] {
        guard let matrix = self.matrix else { fatalError() }
        var neighbors = [Cell]()
        if cell.x - 1 >= 0 && cell.y - 1 >= 0 {
            neighbors.append(matrix[cell.x - 1][cell.y - 1])
        }
        if cell.y - 1 >= 0 {
            neighbors.append(matrix[cell.x][cell.y - 1])
        }
        if cell.x + 1 < max && cell.y - 1 >= 0 {
            neighbors.append(matrix[cell.x + 1][cell.y - 1])
        }
        if cell.x - 1 >= 0 {
            neighbors.append(matrix[cell.x - 1][cell.y])
        }
        if cell.x + 1 < max {
            neighbors.append(matrix[cell.x + 1][cell.y])
        }
        if cell.x - 1 >= 0 && cell.y + 1 < max {
            neighbors.append(matrix[cell.x - 1][cell.y + 1])
        }
        if cell.y + 1 < max {
            neighbors.append(matrix[cell.x][cell.y + 1])
        }
        if cell.x + 1 < max && cell.y + 1 < max {
            neighbors.append(matrix[cell.x + 1][cell.y + 1])
        }
        
        return neighbors
    }
    
    func getNextGeneration2(collectionView: UICollectionView) {
        DispatchQueue.global().async {
            let start = CFAbsoluteTimeGetCurrent()
            self.getLiveCells()
            var countedSet: [Cell: Int] = [:]
            self.generation += 1
            for cell in self.liveCells {
                if countedSet[cell] == nil {
                    countedSet[cell] = 0
                }
                let neighbors = self.getNeighbors(cell: cell, max: 25)
                for neighbor in neighbors {
                    if let value = countedSet[neighbor] {
                        countedSet[neighbor]! = value + 1
                    } else {
                        countedSet[neighbor] = 1
                    }
                }
            }
            self.generationsArray2.append(countedSet)
            let difference = CFAbsoluteTimeGetCurrent() - start
            print("It took \(difference) seconds for one generation.")
        }
    }
    
    func getNextGeneration(collectionView: UICollectionView) {
        DispatchQueue.global().async {
            let start = CFAbsoluteTimeGetCurrent()
            self.getLiveCells()
            
            var countedSet: [Cell: Int] = [:]
            self.generation += 1
            for cell in self.liveCells {
                if countedSet[cell] == nil {
                    countedSet[cell] = 0
                }
                let neighbors = self.getNeighbors(cell: cell, max: 25)
                for neighbor in neighbors {
                    if let value = countedSet[neighbor] {
                        countedSet[neighbor]! = value + 1
                    } else {
                        countedSet[neighbor] = 1
                    }
                }
            }
            for cell in countedSet.keys {
                if countedSet[cell]! < 2 || countedSet[cell]! > 3 {
                    self.liveCells.remove(cell)
                    self.matrix?[cell.x][cell.y].state = .dead
                }
                
                if countedSet[cell] == 3 {
                    self.liveCells.insert(cell)
                    self.matrix?[cell.x][cell.y].state = .alive
                }
            }
            let difference = CFAbsoluteTimeGetCurrent() - start
            print("It took \(difference) seconds for one generation.")
        }
        DispatchQueue.main.async {
            let start2 = CFAbsoluteTimeGetCurrent()
            collectionView.reloadData()
            let diff = CFAbsoluteTimeGetCurrent() - start2
            print("It took \(diff) seconds for one generation to update collection view.")
        }
    }
    
    func updateBoard(collectionView: UICollectionView) {
        let start = CFAbsoluteTimeGetCurrent()
        DispatchQueue.global().async {
            var index = 0
            while self.isPlaying != false {
                let countedSet = self.generationsArray2[index]
                for cell in countedSet.keys {
                    if countedSet[cell]! < 2 || countedSet[cell]! > 3 {
                        self.liveCells.remove(cell)
                        self.matrix?[cell.x][cell.y].state = .dead
                    }
                    
                    if countedSet[cell] == 3 {
                        self.liveCells.insert(cell)
                        self.matrix?[cell.x][cell.y].state = .alive
                    }
                    index += 1
                    let difference = CFAbsoluteTimeGetCurrent() - start
                    print("It took \(difference) seconds for one generation.")
                }
                DispatchQueue.main.async {
                    let start2 = CFAbsoluteTimeGetCurrent()
                    collectionView.reloadData()
                    let diff = CFAbsoluteTimeGetCurrent() - start2
                    print("It took \(diff) seconds for one generation to update collection view.")
                }
            }
        }
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
        let start = CFAbsoluteTimeGetCurrent()
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
        let difference = CFAbsoluteTimeGetCurrent() - start
        print("It took \(difference) seconds for one generation.")
    }
    
    func clearBoard(collectionView: UICollectionView) {
        for cell in cells {
            cell.state = .dead
        }
        generation = 0
        collectionView.reloadData()
    }
    
    func randomPattern(collectionView: UICollectionView) {
        for cell in cells {
            let random = Int(arc4random_uniform(3))
            if random == 1 {
                cell.state = .alive
            } else {
                cell.state = .dead
            }
        }
        self.matrix = cells.chunked(into: 25)
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
    
    func pentadecathlonPattern(collectionView: UICollectionView) {
        let pentaCells = [[12, 12], [12, 13], [12, 11], [12, 10], [12, 14], [12, 15], [12, 9], [12, 8], [12, 16], [12, 7]]
        for cell in cells {
            cell.state = .dead
        }
        for indexPath in pentaCells {
            matrix?[indexPath[0]][indexPath[1]].state = .alive
        }
        collectionView.reloadData()
    }
    
    func heavySpaceshipPattern(collectionView: UICollectionView) {
        let spaceshipCells = [[13, 0], [12, 1], [12, 2], [12, 3], [12, 4], [12, 5], [12, 6], [13, 6], [14, 6], [15, 5]]
        for cell in cells {
            cell.state = .dead
        }
        for indexPath in spaceshipCells {
            matrix?[indexPath[0]][indexPath[1]].state = .alive
        }
        collectionView.reloadData()
    }
    
    init() {
        createCells()
    }
}
