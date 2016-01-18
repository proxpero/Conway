//
//  Board.swift
//  Game Of Life
//
//  Created by Todd Olsen on 9/29/15.
//  Copyright © 2015 Todd Olsen. All rights reserved.
//

import Foundation

public typealias BoardSize = (rowCount: Int, columnCount: Int)

public struct Board {
    
    private var grid: [[Cell]]
    
    public init(rows: Int, columns: Int) {
        
        var matrix: [[Cell]] = []
        for r in (0..<rows) {
            var cols = [Cell]()
            for c in (0..<columns) {
                cols.append(Cell(row: r, col: c, isAlive: false))
            }
            matrix.append(cols)
        }
        grid = matrix
    }
    
    
    public var cells: [Cell] {
        return grid.flatMap { $0 }
    }
    
    
    public var boardSize: BoardSize {
        return (grid.count, grid[0].count)
    }
    
    
    public mutating func reviveCellAtRow(row: Int, column: Int) {
        grid[row][column].revive()
    }
    
    
    public mutating func killCellAtRow(row: Int, column: Int) {
        grid[row][column].die()
    }
    
    
    public func numberOfLiveNeighborsForCell(cell: Cell) -> Int {
        
        let row = cell.row
        let column = cell.col
        
        var liveCells = [Cell]()
        
        
        // Get the eight neighbors then filter out the dead ones.
        // These checks guard against trying to access cells outside the bounds of the board.
        
        if row > 0 {
            
            if column > 0 {
                liveCells.append(grid[row - 1][column - 1])
            }
            
            liveCells.append(grid[row - 1][column])
            
            if column < boardSize.columnCount - 1 {
                liveCells.append(grid[row - 1][column + 1])
            }
            
        }
        
        if column > 0 {
            liveCells.append(grid[row][column - 1])
        }


        if column < boardSize.columnCount - 1 {
            liveCells.append(grid[row][column + 1])
        }
        
        
        if row < boardSize.rowCount - 1 {
            
            if column > 0 {
                liveCells.append(grid[row + 1][column - 1])
            }
            
            liveCells.append(grid[row + 1][column])
            
            if column < boardSize.columnCount - 1 {
                liveCells.append(grid[row + 1][column + 1])
            }
            
        }

        return liveCells.filter { $0.isAlive }.count
    }
    
}

extension Board: CustomStringConvertible {

    public var description: String {

        var string = "\t\t"
        for r in (0 ..< boardSize.rowCount) {
            for c in (0 ..< boardSize.columnCount) {
                string += grid[r][c].isAlive ? "@" : "+"
            }
            string += "\n\t\t"
        }
        
        return string
    }
    
}
