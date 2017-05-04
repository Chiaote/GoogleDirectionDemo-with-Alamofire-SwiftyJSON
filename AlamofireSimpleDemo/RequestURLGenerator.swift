//
//  RequestURLGenerator.swift
//  AlamofireSimpleDemo
//
//  Created by 倪僑德 on 2017/5/4.
//  Copyright © 2017年 Chiao. All rights reserved.
//

import UIKit

class DirectionParameterSettingAndRequestURLGenerator: NSObject {
    //註記：這邊有點醜, 寫法要再改
    //參數設定
    var language : languageSetting = .chinese
    var travelMod : travelMod = .transit
    var distanceUnit : distanceUnit = .metric
    var trafficModel : responceTrafficModel = .pessimistic
    var transitModePreference = transitPreferences(bus: true, subway: true, train: true, tram: true, rail: true).modeSetting
    var outputFormat : respondsDataType = .json
    
    //設定key&呼叫url
    private let mainURL = "https://maps.googleapis.com/maps/api/directions/"
    private let myKey = "AIzaSyAmmbgbhCNuyLVRmWJIftZ1Z9jDD_1zAkU"
    var urlString : String!
    
    //產生request的url
    func produceRequestURL(origin:String,destination:String) -> String {
        var urlString = "\(mainURL)\(outputFormat)?"
        let parameters = produceParameterDictionary(origin: origin, destination: destination)
        for parameter in parameters {
            if parameter.value as! String != "" {
                urlString += "\(parameter.key)=\(parameter.value)&"
                print(urlString)
            }
        }
        urlString += "key=\(myKey)"
        print(urlString)
        return urlString
    }
    
    //產生一組含有所有參數的陣列
    private func produceParameterDictionary(origin:String,destination:String) -> [String : Any]{
        let parameterArray = ["origin":origin,
                              "destination":destination,
                              "language":language.rawValue,
                              "mod":travelMod.rawValue,
                              "units":distanceUnit.rawValue,
                              "traffic_model":trafficModel.rawValue,
                              "transit_mode":transitModePreference!,
                              /*"avoid":avoid*/] as [String : Any]
        return parameterArray
    }
}

//設定回傳資料方式
enum respondsDataType : String{ //直接寫
    case json = "json"
    case xml = "xml"
}
//設定回傳語言
enum languageSetting : String { //&language=
    case chinese = "zh-TW"
    case english = "en"
}
//設定旅遊型態
enum travelMod : String {  //&mod=
    //&traffic_model= 指定偏好方式
    case driving = "driving"
    case walking = "walking"
    case bike = "bicycling"
    case transit = "transit"
}
//設定距離單位
enum distanceUnit : String { //&units=
    case metric = "metric"
    case imperial = "imperial"
}
//設定路線回傳模式
enum responceTrafficModel : String {
    case bestGuess = "best_guess"   //指出傳回的 duration_in_traffic 應該是考量歷史路況與即時路況下的最佳預估旅行時間。departure_time 越接近現在，即時路況就越重要。
    case pessimistic = "pessimistic" //指出傳回的 duration_in_traffic 應該比過去大部分的實際旅行時間更久，雖然偶有路況特別壅塞而超過此值的日子。
    case optimistic = "optimistic"   //指出傳回的 duration_in_traffic 應該比過去大部分的實際旅行時間更短，雖然偶有路況特別順暢而比此值更快的日子。
    
}

//設定偏好大眾運輸模式
class transitPreferences {
    //optional setting
    private var bus = (false,"bus")
    private var subway = (false,"subway")
    private var train = (false,"train")
    private var tram = (false,"tram")
    private var rail = (false,"rail")
    var modeSetting : String!
    
    //creat the settingResultString
    private func produceTransitModeString(modStringArray : [String], modOptionArray:[Bool]) -> String {
        var modeSettingString = ""
        for i in 0...modStringArray.count-1 {
            if modOptionArray[i] {
                modeSettingString += "|\(modStringArray[i])"
            }
        }
        if modeSettingString.characters.first == "|"{
            modeSettingString.characters.popFirst()
        }
        return modeSettingString
    }
    
    //-----------注意：有點醜, 待修改------------
    init(bus:Bool=false, subway:Bool=false, train:Bool=false, tram:Bool=false, rail:Bool=false){
        self.bus.0 = bus
        self.subway.0 = subway
        self.train.0 = train
        self.tram.0 = tram
        self.rail.0 = rail
        let modeOptionArray = [self.bus.0,self.subway.0,self.train.0,self.tram.0,self.rail.0]
        let modeStringArray = [self.bus.1,self.subway.1,self.train.1,self.tram.1,self.rail.1]
        modeSetting = produceTransitModeString(modStringArray: modeStringArray, modOptionArray: modeOptionArray)
    }
}

//設定要避開的
enum avoidPathType : String {   //avoid=
    case tolls = "tolls"    //指出計算的路線應該避開收費道路/橋樑。
    case highways = "highways"  //指出計算的路線應該避開高速公路。
    case ferries = "ferries"    //指出計算的路線應該避開渡輪。
    case indoor = "indoor"  //指出計算的路線應該避開有室內臺階的步行與大眾運輸路線。
    case none = ""
}

/*
 waypoints - 指定途經地點的陣列。途經地點更改路線的方法是指定要行經的位置。途經地點可以指定為緯度/經度座標、編碼折線、地點 ID，或即將進行地理編碼的地址。編碼折線前面必須加上 enc:，後面接著冒號 (:）。地點 ID 前面必須加上 place_id:。只有要求包括 API 金鑰或 Google Maps APIs Premium Plan 用戶端 ID 時，才可以指定地點 ID。開車、步行及單車路線規劃才支援途經地點。如需更多關於途經地點的資訊，請參閱以下的途經地點指南。
 alternatives - 如果設定為 true，可指定路線規劃服務會在回應中提供多條替代路線。請注意，提供替代路線會增加伺服器的回應時間。
 */

// gds721+pi

//範例：
//https://maps.googleapis.com/maps/api/directions/json?origin=Toronto&destination=Montreal&key=AIzaSyAmmbgbhCNuyLVRmWJIftZ1Z9jDD_1zAkU
//https://maps.googleapis.com/maps/api/directions/json?origin=Adelaide,SA&destination=Adelaide,SA&waypoints=optimize:true|Barossa+Valley,SA|Clare,SA|Connawarra,SA|McLaren+Vale,SA&key=YOUR_API_KEY


/*
 地區偏向
 您也可以設定路線規劃服務，使用 region 參數傳回偏向特定地區的結果。此參數可接受指定地區偏向的 ccTLD （國家/地區代碼頂層地區）引數。大部分 ccTLD 代碼和 ISO 3166-1 代碼完全相同，有些則是明顯例外。例如，英國的 ccTLD 是 "uk" (.co.uk)，但 ISO 3166-1 代碼是 "gb" （嚴格來說是指「大不列顛與北愛爾蘭聯合王國」）。
 
 您可以在主要「Google 地圖」應用程式已啟用規劃開車路線的任何地區使用。
 
 例如，當 region 設定為 es 時，會將「托利多」解譯為西班牙的城市，因此從「托利多」前往「馬德里」的路線規劃要求會傳回結果：
 
 https://maps.googleapis.com/maps/api/directions/json?origin=Toledo&destination=Madrid&region=es&key=YOUR_API_KEY
 
 {
 "status": "OK",
 "routes": [ {
 "summary": "AP-41",
 "legs": [ {
 ...
 } ],
 "copyrights": "Map data ©2010 Europa Technologies, Tele Atlas",
 "warnings": [ ],
 "waypoint_order": [ ]
 } ]
 }
 傳送從「托利多」前往「馬德里」的路線規劃要求沒有 region 參數時，會將「托利多」解譯為俄亥俄州的城市，因而不會傳回任何結果：
 
 https://maps.googleapis.com/maps/api/directions/json?origin=Toledo&destination=Madrid&key=YOUR_API_KEY
 
 {
 "status": "ZERO_RESULTS",
 "routes": [ ]
 }
 
 */


//&arrival_time=
//departure_time=
