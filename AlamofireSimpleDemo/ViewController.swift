//
//  ViewController.swift
//  AlamofireSimpleDemo
//
//  Created by 倪僑德 on 2017/5/2.
//  Copyright © 2017年 Chiao. All rights reserved.
//

/*
未完成部分：
    Error handle & ViewModel
*/


import UIKit
import Alamofire
import SwiftyJSON

class MyViewController: UIViewController{
    
    var directionObj : LegsData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print("viewDidLoad囉～～～")
        
        // Setting direction's parameters
        let parameterAndURLGenerator = DirectionParameterSettingAndRequestURLGenerator()
        parameterAndURLGenerator.outputFormat = .json
        parameterAndURLGenerator.transitModePreference = ""
        parameterAndURLGenerator.travelMod = .transit
        parameterAndURLGenerator.language = .chinese
        parameterAndURLGenerator.distanceUnit = .metric
        parameterAndURLGenerator.transitModePreference = transitPreferences(bus: false, subway: true, train: true, tram: false, rail: false).modeSetting
        parameterAndURLGenerator.trafficModel = .defaultValue //這行設定會需要抵達時間
        
        // Create parameters dictionary for Alamofire
        let parameters = parameterAndURLGenerator.produceParameterDictionary(origin: "捷運科技大樓站", destination: "捷運行天宮站")
        
        // Make a request
        let urlString = parameterAndURLGenerator.urlStringWithRespondType()
        
        let test = self.testPrint(urlString: urlString, parameters: parameters)
        print(test)
        
        Alamofire.request(urlString, method: .get, parameters: parameters).responseJSON{ response in
            
            print("Alamofire囉～～～")
            
            // Check the response status
            if let result = response.result.value {
                let responseJSON = JSON(result)
                guard responseJSON["status"] == "OK" else{
                    // 做一些事如果status不對的時候
                    return
                }
                
                let parser = DirectionJsonAnalyst()
                self.directionObj = parser.trasferJSONToObject(responseJSON: responseJSON,travelMode:parameterAndURLGenerator.travelMod.rawValue)
                
                print("Alamofire跑完囉")
            }
        }
        print("程式跑完囉")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 測試用程式碼, 將request URL印出以便複製到瀏覽器做對照
    func testPrint(urlString:String, parameters:[String:String]) -> String {
        var string = urlString
        for obj in parameters {
            let tmpString = "\(obj.key)=\(obj.value)&"
            string += tmpString
        }
        string.characters.removeLast()
        return string
    }
    
}

