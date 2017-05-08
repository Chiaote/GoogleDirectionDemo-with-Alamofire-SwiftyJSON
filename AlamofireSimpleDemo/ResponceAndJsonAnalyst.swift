//
//  ResponceAndJsonAnalyst.swift
//  AlamofireSimpleDemo
//
//  Created by 倪僑德 on 2017/5/8.
//  Copyright © 2017年 Chiao. All rights reserved.
//

import UIKit

class ResponceAndJsonAnalyst: NSObject {
    
    // setting the key words for dictionary
    let keyText = "text"
    let keyLat = "lat"
    let keyLng = "lng"
    let keyDistance = "distance"
    let keyDuration = "duration"
    let keyEndLocation = "end_location"
    let keyStartLocation = "start_location"
    //    let keyTravelMode = "travel_mode"
    
    func responceAnalyte(routes:[String:AnyObject]){
        let routesArray = routes["routes"] as! [[String:AnyObject]]
        print(routesArray)
        guard let legsDic : [String:AnyObject] = routesArray.first?["legs"] as? [String : AnyObject] else {
            print("route build fail")
            return
        }
        
        // 目的： 將legs的資料讀出轉存為物件
        var legs = legsInformation()
        legs = settingObjsCommentInformation(inputDic: legsDic, obj: legs) as! legsInformation
        legs.steps = [PathDetailInformation]()
        
        // 將legs中step的物件讀出轉存為物件
        guard let steps: [[String:AnyObject]] = legsDic["steps"] as? [[String : AnyObject]] else {
            print("steps build fail")
            return
        }
        
        // 將每個step數據以array讀儲存到legs物件中
        for step in steps {
            var stepInformation = PathDetailInformation()
            stepInformation = settingObjsCommentInformation(inputDic: step, obj:stepInformation) as! PathDetailInformation
            stepInformation.travelMode = step["travel_mode"] as! String
            stepInformation.htmlInstructions = step["html_instructions"] as! String
            stepInformation.maneuver = step["maneuver"] as! String
            stepInformation.polyline = step["polyline"] as! String
            legs.steps.append(stepInformation)
        }
        
        // 將跟legs同街的參數全部印出
        print(legs.steps)
        print("overview_polyline:\(legsDic["overview_polyline"]?["points"] as! String)")
        print("summary:\(legsDic["summary"] as! String)")
        print("summary:\(legsDic["copyrights"] as! String)")
        
    }
    
    private func settingObjsCommentInformation (inputDic:[String:AnyObject], obj:directCommentInformation) -> directCommentInformation {
        
        obj.distance = inputDic[keyDistance]?[keyText] as! String
        obj.duration = inputDic[keyDuration]?[keyText] as! String
        
        // setting endLocation
        if let adrs: String = inputDic["end_address"] as? String {
            obj.endLocation.address = adrs
        }
        obj.endLocation.latitude = inputDic[keyEndLocation]?[keyLat] as! Double
        obj.endLocation.longitude = inputDic[keyEndLocation]?[keyLng] as! Double
        
        // setting startLocation
        if let adrs: String = inputDic["start_address"] as? String {
            obj.endLocation.address = adrs
        }
        obj.startLocation.latitude = inputDic[keyStartLocation]?[keyLat] as! Double
        obj.startLocation.longitude = inputDic[keyStartLocation]?[keyLng] as! Double
        
        return obj
    }
}

class directCommentInformation: NSObject {
    var distance : String!
    var duration : String!
    var endLocation : LocationInformation!
    var startLocation : LocationInformation!
}

class legsInformation: directCommentInformation {
    var steps : [PathDetailInformation]!
}

class PathDetailInformation: directCommentInformation {
    // important value
    var travelMode : String!
    var maneuver : String!
    var polyline : String!
    
    // option value
    var htmlInstructions : String!
    var point : String!
    
    //    init(  distance : String!,
    //                    duration : String!,
    //                    endLocation : LocationInformation!,
    //                    startLocation : LocationInformation!,
    //                    travelMode : String!     )
    //    {
    //        super.init()
    //        self.distance = distance
    //        self.duration = duration
    //        self.endLocation = endLocation
    //        self.startLocation = startLocation
    //        self.travelMode = travelMode
    //    }
}

class LocationInformation {
    
    var latitude : Double
    var longitude : Double
    var address : String!
    
    required init(latitude:Double, longitude:Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
