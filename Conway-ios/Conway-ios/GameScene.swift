//
//  GameScene.swift
//  Conway-ios
//
//  Created by Todd Olsen on 3/8/16.
//  Copyright (c) 2016 Todd Olsen. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, BoardType {

    let boardSize: BoardSize
    var cells: [CellType] = [] // {
//        return children.map { $0 as! CellType }
//    }
    
    override init(size: CGSize) {
        
        let cols = 70
        let edge = Swift.min(size.height, size.width)/CGFloat(cols)
        let rows = Int(size.height/edge)
        
//        func initializeGrid() {
//            for r in (0..<rows) {
//                for c in (0..<cols) {
//                    let cell = CellNode(size: CGSizeMake(edge, edge), row: r, col: c)
//                    let col = CGFloat(c)
//                    let row = CGFloat(r)
//                    cell.position = CGPointMake(col * edge, row * edge)
//                    addChild(cell)
//                }
//            }
//        }
        
        self.boardSize = BoardSize(rows, cols)
        super.init(size: size)


    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToView(view: SKView) {
        
        let edge = Swift.min(view.frame.height, view.frame.width)/CGFloat(boardSize.columnCount)
        anchorPoint = CGPointMake(0, 0)

//        let rows = boardSize.rowCount
//        let cols = boardSize.columnCount
        
        for r in (0..<boardSize.rowCount) {
            for c in (0..<boardSize.columnCount) {
                let cell = CellNode(size: CGSizeMake(edge, edge), row: r, col: c)
                let col = CGFloat(c)
                let row = CGFloat(r)
                cell.position = CGPointMake(col * edge + (0.5 * edge), row * edge + (0.5 * edge))
                addChild(cell)
            }
        }
        
        self.cells = children.map { $0 as! CellType }
    }

    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        updateGeneration()
    }
    
    override func update(currentTime: NSTimeInterval) {
        updateGeneration()
    }

}

class CellNode: SKSpriteNode, CellType {
    
    let row: Int
    let col: Int
    var isAlive: Bool = false
    
    func revive() {
        color = UIColor.whiteColor()
        isAlive = true
    }
    
    func die() {
        color = UIColor.blackColor()
        isAlive = false
    }
    
    init(size: CGSize, row: Int, col: Int) {
//        let red = CGFloat(arc4random_uniform(255))/255.0
//        let grn = CGFloat(arc4random_uniform(255))/255.0
//        let blu = CGFloat(arc4random_uniform(255))/255.0
//        let color = UIColor(red: red, green: grn, blue: blu, alpha: 1.0)
  
        self.isAlive = arc4random_uniform(10) % 7 == 0 ? true : false
        let color = self.isAlive ? UIColor.whiteColor() : UIColor.blackColor()
        
        self.row = row
        self.col = col
        
        super.init(texture: nil, color: color, size: size)
        zPosition = 6
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}