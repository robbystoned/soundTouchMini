//
//  httpRequestController.swift
//  SoundTouchWatch
//
//  Created by Robert vd Steen on 13-04-16.
//  Copyright © 2016 Robert vd Steen. All rights reserved.
//

import Foundation


class HTTPRequestControler {

    func sendKeyRequest(stUrl: String, xmlRequestPress: String, xmlRequestRelease: String, completionBlock​: @escaping (_ result: String) -> ()){
        
        let requestXmlDataPress = xmlRequestPress.data(using: String.Encoding.utf8)
        let requestXmlDataRelease = xmlRequestRelease.data(using: String.Encoding.utf8)
        
        let url = NSURL(string:stUrl)!
        
        let requestPress = NSMutableURLRequest(url: url as URL)
        requestPress.httpMethod = "POST"
        requestPress.httpBody = requestXmlDataPress!
        
        
        
        let requestRelease = NSMutableURLRequest(url: url as URL)
        requestRelease.httpMethod = "POST"
        requestRelease.httpBody = requestXmlDataRelease!
        
        let taskPress = URLSession.shared.dataTask(with: requestPress as URLRequest) { data, response, error in
            guard error == nil && data != nil else {                                                          // check for fundamental networking error
                print("error=\(error)")
                
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
                            }
            
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("responseString = \(responseString)")
            let taskRelease = URLSession.shared.dataTask(with: requestRelease as URLRequest) { data, response, error in
                guard error == nil && data != nil else {                                                          // check for fundamental networking error
                    print("error=\(error)")
                   
                    return
                }
                
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                    
                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                    print("response = \(response)")
                }
                
                let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                print("responseString = \(responseString)")
                
                completionBlock​("");
            }
            taskRelease.resume()
            
        }
        taskPress.resume()
        
    }
    
    
    func sendPostRequest(stUrl: String, xmlRequest: String){
        
        let requestXmlData = xmlRequest.data(using: String.Encoding.utf8)
        let url = NSURL(string:stUrl)!
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "POST"
        request.httpBody = requestXmlData!
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            guard error == nil && data != nil else {                                                          // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
               
            }
            
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("responseString = \(responseString)")
        }
        task.resume()
        
    }

    func checkPowerState( ) {
        let url = NSURL(string:"http://Bose-SoundTouch-9900F9:8090/now_playing")!
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
                print(xmlDoc.root.attributes["source"])
                let sourceState = xmlDoc.root.attributes["source"]
                if(sourceState == "STANDBY") {
                    //powerState.setImageNamed("red")
                    
                } else {
                    //powerState.setImageNamed("green")
                }

            }catch{
                print("\(error)")
            }
            
        }
        
        task.resume()
        
    }
    

}
