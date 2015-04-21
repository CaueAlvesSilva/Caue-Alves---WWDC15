//
//  MenuViewController.swift
//  CaueAlves - WWDC15
//
//  Created by Cauê Silva on 17/04/15.
//  Copyright (c) 2015 Cauê Silva. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    @IBInspectable
    @IBOutlet weak var btnProfile: UIButton!
    @IBInspectable
    @IBOutlet weak var btnWork: UIButton!
    @IBInspectable
    @IBOutlet weak var btnStudy: UIButton!
    @IBInspectable
    @IBOutlet weak var btnFamily: UIButton!
    @IBInspectable
    @IBOutlet weak var btnHobbies: UIButton!
    @IBInspectable
    
    var button: String?
    
    var pieColor:UIColor = UIColor(red: 29/255, green: 209/255, blue: 102/255, alpha: 1)
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        btnWork.layer.backgroundColor = UIColor .redColor().CGColor
        btnWork.layer.borderWidth = 3
        btnWork.layer.borderColor = UIColor .whiteColor().CGColor
        btnWork.layer.cornerRadius = 40
        btnWork.layer.masksToBounds = true
        btnWork.clipsToBounds = true
        
        
        btnStudy.layer.backgroundColor = UIColor .yellowColor().CGColor
        btnStudy.layer.borderWidth = 3
        btnStudy.layer.borderColor = UIColor .whiteColor().CGColor
        btnStudy.layer.cornerRadius = 40
        btnStudy.layer.masksToBounds = true
        btnStudy.clipsToBounds = true
        
        btnFamily.layer.backgroundColor = UIColor .greenColor().CGColor
        btnFamily.layer.borderWidth = 3
        btnFamily.layer.borderColor = UIColor .whiteColor().CGColor
        btnFamily.layer.cornerRadius = 40
        btnFamily.layer.masksToBounds = true
        btnFamily.clipsToBounds = true
        
        btnHobbies.layer.backgroundColor = UIColor .blueColor().CGColor
        btnHobbies.layer.borderWidth = 3
        btnHobbies.layer.borderColor = UIColor .whiteColor().CGColor
        btnHobbies.layer.cornerRadius = 40
        btnHobbies.layer.masksToBounds = true
        btnHobbies.clipsToBounds = true
        
        btnProfile.layer.backgroundColor = UIColor .whiteColor().CGColor
        btnProfile.layer.borderWidth = 3
        btnProfile.layer.borderColor = UIColor .whiteColor().CGColor
        btnProfile.layer.cornerRadius = 50
        btnProfile.layer.masksToBounds = true
        btnProfile.clipsToBounds = true
    }
    

    @IBAction func btnWork(sender: AnyObject)
    {
        button = "Work"
    }
    
    @IBAction func btnStudy(sender: AnyObject)
    {
        button = "Study"
    }
    
    @IBAction func btnFamily(sender: AnyObject)
    {
        button = "Family"
    }

    @IBAction func btnHobbies(sender: AnyObject)
    {
        button = "Hobbies"
    }
    
}
