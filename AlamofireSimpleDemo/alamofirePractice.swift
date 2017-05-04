//
//  alamofirePractice.swift
//  AlamofireSimpleDemo
//
//  Created by 倪僑德 on 2017/5/2.
//  Copyright © 2017年 Chiao. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class Interactor {
    func directions(complete: @escaping ([String: AnyObject]) -> (),
                    error: @escaping () -> ()) {
        let parameters: Parameters = [ "origin": "捷運大安站",
                                       "destination": "捷運中山國中站",
                                       "mode": "transit_mode",
                                       "key": "AIzaSyAKtGLosXJi5CeO5ichn28DAI81DZaW5ZU"] // Your API Key
        let urlString = "https://maps.googleapis.com/maps/api/directions/json"
        
        Alamofire.request(urlString,
                          method: .get,
                          parameters: parameters)
            .responseJSON { response in
                if let json = response.result.value {
                    let response = json as! Dictionary<String, AnyObject>
                    print("哇哈哈哈哈哈哈！！！")
                    print(response)
                    complete(response)
                } else {
                    error()
                }
        }
    }
}

