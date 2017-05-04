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
        
        //設定參數並產生urlRequest
        let parameterAndURLGenerator = DirectionParameterSettingAndRequestURLGenerator()
        parameterAndURLGenerator.transitModePreference = ""
        parameterAndURLGenerator.travelMod = .transit
        parameterAndURLGenerator.language = .chinese
        parameterAndURLGenerator.distanceUnit = .metric
        parameterAndURLGenerator.trafficModel = .defaultValue //這行設定會需要抵達時間

        let parameters = parameterAndURLGenerator.produceParameterDictionary(origin: "捷運科技大樓站", destination: "捷運忠孝復興站")
        let urlString = parameterAndURLGenerator.urlStringWithRespondType()
        Alamofire.request(urlString, method: .get, parameters: parameters).responseJSON{ response in
            debugPrint(response)
            print(response)
        }
        
//        let urlString = parameterGenerator.urlString
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

