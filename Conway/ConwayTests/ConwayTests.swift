//
//  ConwayTests.swift
//  ConwayTests
//
//  Created by Todd Olsen on 3/8/16.
//  Copyright © 2016 Todd Olsen. All rights reserved.
//

import XCTest
@testable import Conway

class ConwayTests: XCTestCase {

    func testPerformanceExample() {
        var controller = Controller((150, 150))
        self.measureBlock {
            for _ in 1...1000 {
                controller.update()
            }
        }
    }    
}
