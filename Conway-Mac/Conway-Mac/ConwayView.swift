//
//  ConwayView.swift
//  Conway-Mac
//
//  Created by Todd Olsen on 4/23/16.
//  Copyright © 2016 Todd Olsen. All rights reserved.
//

import AppKit

class ConwayView: NSView {

    var controller = Controller()
    let alive = CGColorCreateGenericGray(1.0, 1.0)
    let dead  = CGColorCreateGenericGray(0.1, 1.0)


    override func drawRect(dirtyRect: NSRect) {

        let width = bounds.maxX/CGFloat(controller.board.boardSize.columnCount)
        let height = bounds.maxY/CGFloat(controller.board.boardSize.rowCount)

        let context = NSGraphicsContext.currentContext()?.CGContext

        let board = controller.board

        for r in 0..<board.grid.endIndex {
            for c in 0..<board.grid[0].endIndex {
                let cell = board.grid[r][c]
                CGContextSetFillColorWithColor(context, cell.isAlive ? alive : dead)
                CGContextFillRect(context, CGRectMake(width * CGFloat(c), height * CGFloat(r), width, height))
            }
        }
    }
}
