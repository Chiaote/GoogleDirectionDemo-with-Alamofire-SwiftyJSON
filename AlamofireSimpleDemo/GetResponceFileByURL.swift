//
//  GetResponceFileByURL.swift
//  AlamofireSimpleDemo
//
//  Created by 倪僑德 on 2017/5/4.
//  Copyright © 2017年 Chiao. All rights reserved.
//

import UIKit

class GetResponceFileByURL: NSObject {
    
    
    func getResponce (requestURL:String) {
        
        let urlRequest = URLRequest(url: requestURL, method: .get)
        
    }
   
    let urlRequest: NSMutableURLRequest = NSMutableURLRequest(URL: requestURL)
    let session = NSURLSession.sharedSession()
    let task = session.dataTaskWithRequest(urlRequest) {
        (data, response, error) -> Void in
        
        let httpResponse = response as! NSHTTPURLResponse
        let statusCode = httpResponse.statusCode
        
        if (statusCode == 200) {
            print("Everyone is fine, file downloaded successfully.")
        }
    }
    
    task.resume()
    
}
