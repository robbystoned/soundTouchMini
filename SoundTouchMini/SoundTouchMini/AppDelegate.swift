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
    let serverName = "http://slaapkamer:8090/"
    var presetsArr: [String] = ["","","","","",""]
    
    @IBOutlet weak var menu: NSMenu!
   
    let statusItem = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)    
    let httpController = HTTPRequestControler();


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let icon = NSImage(named: "stlogo")
        //icon?.setTemplate = true
        statusItem.image = icon
        statusItem.menu = menu

        let url = NSURL(string: serverName + "presets")!
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "GET"
        
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            guard error == nil && data != nil else {                                                          // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
            do{
                let xmlDoc = try AEXMLDocument(xml: data!)
                
                if let presets = xmlDoc.root["preset"].all {
                    for preset in presets {
                        let presetId:Int? = Int(preset.attributes["id"]!)
                        self.presetsArr[(presetId!-1)] = preset["ContentItem"].xml
                        
                    }
                }
            }catch{
                print("\(error)")
            }
            
        }
        
        task.resume()

    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    @IBAction func QuitApp(_ sender: Any) {
        exit(0)
    }
 
    @IBAction func pressPower(_ sender: Any) {
        
        let url = "http://slaapkamer:8090/key"
        let xmlCommandPress = "<key state=\"press\" sender=\"Gabbo\">POWER</key>"
        let xmlCommandRelease = "<key state=\"release\" sender=\"Gabbo\">POWER</key>"
        
        httpController.sendKeyRequest(stUrl: url, xmlRequestPress: xmlCommandPress, xmlRequestRelease:xmlCommandRelease, completionBlock​: {
            (result) in
            //self.httpController.checkPowerState(self.powerState)
        })

    }

    @IBAction func pressPreset1(_ sender: Any) {
        let url = serverName + "select"
        if(presetsArr[0] != ""){
            httpController.sendPostRequest(stUrl: url, xmlRequest: presetsArr[0])
        }
    }
    @IBAction func pressPreset2(_ sender: Any) {
        let url = serverName + "select"
        if(presetsArr[1] != ""){
            httpController.sendPostRequest(stUrl: url, xmlRequest: presetsArr[1])
        }
    }
    @IBAction func pressPreset3(_ sender: Any) {
        let url = serverName + "select"
        if(presetsArr[2] != ""){
            httpController.sendPostRequest(stUrl: url, xmlRequest: presetsArr[2])
        }
    }
    @IBAction func pressPreset4(_ sender: Any) {
        let url = serverName + "select"
        if(presetsArr[3] != ""){
            httpController.sendPostRequest(stUrl: url, xmlRequest: presetsArr[3])
        }
    }
    @IBAction func pressPreset5(_ sender: Any) {
        let url = serverName + "select"
        if(presetsArr[4] != ""){
            httpController.sendPostRequest(stUrl: url, xmlRequest: presetsArr[4])
        }
    }
    @IBAction func pressPreset6(_ sender: Any) {
        let url = serverName + "select"
        if(presetsArr[5] != ""){
            httpController.sendPostRequest(stUrl: url, xmlRequest: presetsArr[5])
        }
    }
    
}

