//
//  ViewController.swift
//  AlamofireSimpleDemo
//
//  Created by 倪僑德 on 2017/5/2.
//  Copyright © 2017年 Chiao. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // test
        
        
        // Setting direction's parameters
        let parameterAndURLGenerator = DirectionParameterSettingAndRequestURLGenerator()
        parameterAndURLGenerator.outputFormat = .json
        parameterAndURLGenerator.transitModePreference = ""
        parameterAndURLGenerator.travelMod = .transit
        parameterAndURLGenerator.language = .chinese
        parameterAndURLGenerator.distanceUnit = .metric
        parameterAndURLGenerator.trafficModel = .defaultValue //這行設定會需要抵達時間
        
        // Create parameters dictionary for Alamofire
        let parameters = parameterAndURLGenerator.produceParameterDictionary(origin: "捷運科技大樓站", destination: "捷運忠孝復興站")
        
        // Make a request
        let urlString = parameterAndURLGenerator.urlStringWithRespondType()
        Alamofire.request(urlString, method: .get, parameters: parameters).responseJSON{ response in
            if let routeDic = response.result.value as! [String:AnyObject]!{
                let analyst = ResponceAndJsonAnalyst()
                analyst.responceAnalyte(routes: routeDic)
                print(routeDic)
            }
        }
    }
    
    func responceAnalyte(route:[String:AnyObject]){
        let routesArray = route["routes"] as! [[String:AnyObject]]
        guard let legsDic = routesArray[0]["legs"] else {
            print("member legs doesn't exist")
            return
        }
        guard let pathArray = legsDic["steps"] else {
            print("member 'step' doesn't exist")
            return
        }

        print("////////////////////")
//        print(routesArray)
//        print(routeDic)
//        print(legsArray)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

