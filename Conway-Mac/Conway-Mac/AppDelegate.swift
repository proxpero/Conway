//
//  AppDelegate.swift
//  Conway-Mac
//
//  Created by Todd Olsen on 4/23/16.
//  Copyright © 2016 Todd Olsen. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

//    @IBOutlet weak var window: NSWindow!
    var controller: NSWindowController!

    func applicationDidFinishLaunching(aNotification: NSNotification) {

        controller = ConwayWindowController(windowNibName: "Window")
        controller.showWindow(self)

    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }


}

