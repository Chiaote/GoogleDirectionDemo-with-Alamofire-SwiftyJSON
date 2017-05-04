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
//        Alamofire.request("https://rocky-meadow-1164.herokuapp.com/todo")
        Interactor.directions()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

