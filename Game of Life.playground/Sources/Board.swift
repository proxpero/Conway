//
//  Board.swift
//  Game Of Life
//
//  Created by Todd Olsen on 9/29/15.
//  Copyright © 2015 Todd Olsen. All rights reserved.
//

import Foundation

enum Vertical {
    case North
    case South
    case None
}

enum Horizontal {
    case East
    case West
    case None
}


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

        var neighbors = 0
//        var neighbors = [Cell]()
        
        let row = cell.row
        let column = cell.col

        func neighboringRowForRow(row: Int, inDirection direction: Vertical) -> Int {
            switch direction {
                case .North:
                    return row > 0 ? row - 1 : boardSize.rowCount - 1
                case .South:
                    return row < boardSize.rowCount - 1 ? row + 1 : 0
                case .None:
                    return row
            }
        }
        
        func neighboringColumnForColumn(column: Int, inDirection direction: Horizontal) -> Int {
            switch direction {
                case .East:
                    return column < boardSize.columnCount - 1 ? column + 1 : 0
                case .West:
                    return column > 0 ? column - 1 : boardSize.columnCount - 1
                case .None:
                    return column
            }
        }
        
        func isAliveAt(v: Vertical, _ h: Horizontal) -> Bool {
            return grid[neighboringRowForRow(row, inDirection: v)][neighboringColumnForColumn(column, inDirection: h)].isAlive
        }
        
        if isAliveAt(.North, .West) { neighbors += 1 }
        if isAliveAt(.North, .None) { neighbors += 1 }
        if isAliveAt(.North, .East) { neighbors += 1 }
        if isAliveAt(.None, .West) { neighbors += 1 }
        if isAliveAt(.None, .East) { neighbors += 1 }
        if isAliveAt(.South, .West) { neighbors += 1 }
        if isAliveAt(.South, .None) { neighbors += 1 }
        if isAliveAt(.South, .East) { neighbors += 1 }
        
        // Get the eight neighbors then filter out the dead ones.
        // These checks guard against trying to access cells outside the bounds of the board.
        

        return neighbors
    }
    
}

extension Board: CustomStringConvertible {

    public var description: String {

        var string = "\t\t"
        for r in (0 ..< boardSize.rowCount) {
            for c in (0 ..< boardSize.columnCount) {
                string += grid[r][c].isAlive ? "◼︎" : "◻︎"
            }
            string += "\n\t\t"
        }
        
        return string
    }
    
}
