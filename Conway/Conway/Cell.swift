//
//  Cell.swift
//  Game Of Life
//
//  Created by Todd Olsen on 9/29/15.
//  Copyright © 2015 Todd Olsen. All rights reserved.
//

import Foundation

public struct Cell {
    let row: Int
    let col: Int
    var isAlive: Bool
    
    mutating func revive() {
        if !isAlive { isAlive = true }
    }
    
    mutating func die() {
        if isAlive { isAlive = false }
    }
}