//
//  ProfileViewController.swift
//  CaueAlves - WWDC15
//
//  Created by Cauê Silva on 21/04/15.
//  Copyright (c) 2015 Cauê Silva. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var imgProfile: UIImageView!
    

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationItem.title = "Profile"
    }
    
    override func viewWillAppear(animated: Bool) {
        imgProfile.layer.backgroundColor = UIColor .redColor().CGColor
        imgProfile.layer.borderWidth = 3
        imgProfile.layer.borderColor = UIColor .whiteColor().CGColor
        imgProfile.layer.cornerRadius = 10
        imgProfile.layer.masksToBounds = true
        imgProfile.clipsToBounds = true
    }

    override func didReceiveMemoryWarning() { super.didReceiveMemoryWarning() }

}
