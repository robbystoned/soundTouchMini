//
//  AppDelegate.swift
//  SoundTouchMini
//
//  Created by Robert vd Steen on 10-05-17.
//  Copyright © 2017 Robert vd Steen. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    
    @IBOutlet weak var menu: NSMenu!
   
    let statusItem = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)    


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let icon = NSImage(named: "stlogo")
        //icon?.setTemplate = true
        statusItem.image = icon
        statusItem.menu = menu

    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    @IBAction func QuitApp(_ sender: Any) {
        exit(0)
    }

}

