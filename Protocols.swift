//
//  Protocols.swift
//  Created by Todd Olsen on 4/4/16.
//

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

public typealias BoardSize   = (rowCount: Int, columnCount: Int)
public typealias CellAddress = (row: Int, column: Int)

public protocol CellType {
    
    var row:     Int  { get }
    var col:     Int  { get }
    var isAlive: Bool { get }
    
    func revive()
    func die()
}

public protocol BoardType {
    
    var  cells: [CellType] { get }
    var  boardSize: BoardSize { get }
    func reviveCellAt(address: CellAddress)
    func killCellAt(address: CellAddress)
    func numberOfLiveNeighborsForCell(cell: CellType) -> Int
    func updateGeneration()
    
}

extension BoardType {
    
    func cellAt(address: CellAddress) -> CellType {
        return cells[address.row * address.column + address.column]
    }
    
    public func reviveCellAt(address: CellAddress) {
        cellAt(address).revive()
    }
    
    public func killCellAt(address: CellAddress) {
        cellAt(address).die()
    }
    
    public func numberOfLiveNeighborsForCell(cell: CellType) -> Int {
        
        var neighbors = 0
        
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
            return cellAt(CellAddress(row: neighboringRowForRow(row, inDirection: v), column: neighboringColumnForColumn(column, inDirection: h))).isAlive
//            return grid[neighboringRowForRow(row, inDirection: v)][neighboringColumnForColumn(column, inDirection: h)].isAlive
        }
        
        if isAliveAt(.North, .West) { neighbors += 1 }
        if isAliveAt(.North, .None) { neighbors += 1 }
        if isAliveAt(.North, .East) { neighbors += 1 }
        if isAliveAt(.None,  .West) { neighbors += 1 }
        if isAliveAt(.None,  .East) { neighbors += 1 }
        if isAliveAt(.South, .West) { neighbors += 1 }
        if isAliveAt(.South, .None) { neighbors += 1 }
        if isAliveAt(.South, .East) { neighbors += 1 }
        
        return neighbors
    }
    
    public func updateGeneration() {
        
        var cellsToRevive = [CellType]()
        var cellsToDestroy = [CellType]()
        
//        print("cells: \(cells.count)")
        
        for cell in cells {
            
            // Any live cell with fewer than two live neighbours dies, as if caused by under-population.
            
            if cell.isAlive && numberOfLiveNeighborsForCell(cell) < 2 {
//                print("1")
                cellsToDestroy.append(cell)
            }
            
            // Any live cell with two or three live neighbours lives on to the next generation.
            if cell.isAlive && [2,3].contains(numberOfLiveNeighborsForCell(cell)) {
//                print("2")
                cellsToRevive.append(cell)
            }
            
            // Any live cell with more than three live neighbours dies, as if by over-population.
            if cell.isAlive && numberOfLiveNeighborsForCell(cell) > 3 {
//                print("3")
                cellsToDestroy.append(cell)
            }
            
            // Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.
            if !cell.isAlive && numberOfLiveNeighborsForCell(cell) == 3 {
//                print("4")
                cellsToRevive.append(cell)
            }
        }
        
//        print("cells to revive: \(cellsToRevive.count)")
//        print("cells to destroy: \(cellsToDestroy.count)")
        
        cellsToRevive.forEach { $0.revive() }
        cellsToDestroy.forEach { $0.die() }
        
//        for cell in cellsToRevive {
//            cell.revive()
////            reviveCellAtRow(cell.row, column: cell.col)
//        }
//        
//        for cell in cellsToDestroy {
//            
//            killCellAtRow(cell.row, column: cell.col)
//        }
        
//        generation += 1
        
    }
    
}