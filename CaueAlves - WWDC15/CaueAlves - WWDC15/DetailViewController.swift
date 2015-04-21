//
//  DetailViewController.swift
//  CaueAlves - WWDC15
//
//  Created by Cauê Silva on 21/04/15.
//  Copyright (c) 2015 Cauê Silva. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var type:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = type
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
