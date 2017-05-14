import Foundation

class InterfacePresetsController {
    
    
    let httpController = HTTPRequestControler();
    var presetsArr: [String] = ["","","","","",""]


    
     func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        

        let url = NSURL(string:"http://Bose-SoundTouch-9900F9:8090/presets")!
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
        
        print("activatePreset")
        
    }
    

    
    
       
}
