//
//  Controller.swift
//  Game Of Life
//
//  Created by Todd Olsen on 9/29/15.
//  Copyright © 2015 Todd Olsen. All rights reserved.
//

import Foundation

public struct Controller {
    
    internal var board: Board
    var generation = 0
    
    public init(boardSize: (rows: Int, columns: Int), var seeds: [(Int, Int)] = []) {
        self.board = Board(rows: boardSize.rows, columns: boardSize.columns)
        
        if seeds.isEmpty {
            
            for r in (0 ..< boardSize.rows) {
                for c in (0 ..< boardSize.columns) {
                    if arc4random_uniform(100) % 2 == 0 {
                        seeds.append((r, c))
                    }
                }
            }
        }
        
        for (r, c) in seeds {
            if r < boardSize.rows && c < boardSize.columns {
                self.board.reviveCellAtRow(r, column: c)
            }
        }
    }
    
    public mutating func update() {
        
        var revive = [Cell]()
        var destroy = [Cell]()
        
        for cell in board.cells {
            
            // Any live cell with fewer than two live neighbours dies, as if caused by under-population.
        
            if cell.isAlive && board.numberOfLiveNeighborsForCell(cell) < 2 {
                destroy.append(cell)
            }

            // Any live cell with two or three live neighbours lives on to the next generation.
            if cell.isAlive && [2,3].contains(board.numberOfLiveNeighborsForCell(cell)) {
                revive.append(cell)
            }

            // Any live cell with more than three live neighbours dies, as if by over-population.
            if cell.isAlive && board.numberOfLiveNeighborsForCell(cell) > 3 {
                destroy.append(cell)
            }
            
            // Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.
            if !cell.isAlive && board.numberOfLiveNeighborsForCell(cell) == 3 {
                revive.append(cell)
            }
        }
        
        for cell in revive {
            board.reviveCellAtRow(cell.row, column: cell.col)
        }
        
        for cell in destroy {
            board.killCellAtRow(cell.row, column: cell.col)
        }
        
        generation += 1
    }
}

extension Controller: CustomStringConvertible {
    public var description: String {
        return "\t\tGeneration: \(generation)\n\n\(board.description)\n\n\n"
    }
}