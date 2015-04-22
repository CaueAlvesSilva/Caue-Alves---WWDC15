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
    var pages: [(pageNumber: Int, showPhoto: String, showText: String)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = type
        
        pages = [(1,"photo1.png", "Text of photo 1"),
                 (2,"photo2.png", "Text of photo 2"),
                 (3,"photo3.png", "Text of photo 3")]
        
//        imgPhoto.image = UIImage(named: pages[1].showPhoto)
//        lblText.text = pages[1].showText
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    

}
