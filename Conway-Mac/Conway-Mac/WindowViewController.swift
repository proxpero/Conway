//
//  WindowViewController.swift
//  Conway-Mac
//
//  Created by Todd Olsen on 4/23/16.
//  Copyright © 2016 Todd Olsen. All rights reserved.
//

import AppKit

class ConwayWindowController: NSWindowController {

    @IBOutlet weak var view: ConwayView!

    override func windowDidLoad() {
        view.controller = Controller()
    }

    func refresh() {
        view.controller.update()
        self.view.needsDisplay = true
    }

    @IBAction func startAction(sender: AnyObject) {
        NSTimer.every(0.1.seconds, refresh)
    }


}