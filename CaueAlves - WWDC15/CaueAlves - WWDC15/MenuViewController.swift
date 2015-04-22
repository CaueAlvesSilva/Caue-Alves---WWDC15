//
//  MenuViewController.swift
//  CaueAlves - WWDC15
//
//  Created by Cauê Silva on 17/04/15.
//  Copyright (c) 2015 Cauê Silva. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    // MARK: - Properties (Buttons)
    //================================================================
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
    //================================================================
    
    
    
    // MARK: - View Lifecycle
    //================================================================
    override func viewDidLoad() { super.viewDidLoad() }

    override func didReceiveMemoryWarning() { super.didReceiveMemoryWarning() }
    //================================================================
    
    
    
    // MARK: - View Will Appear (Buttons' layout)
    //================================================================
    override func viewWillAppear(animated: Bool)
    {
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
    //================================================================
    
    
    
    // MARK: - Prepare for Segue (send to detailView the information's type)
    //================================================================
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if let dvc = segue.destinationViewController as? DetailViewController
        {
            if (segue.identifier == "segueWork")
            {
                dvc.type = "Work"
            }
            else if (segue.identifier == "segueStudy")
            {
                dvc.type = "Study"
            }
            else if (segue.identifier == "segueFamily")
            {
                dvc.type = "Family"
            }
            else if (segue.identifier == "segueHobbies")
            {
                dvc.type = "Hobbies"
            }
        }
    }
    //================================================================
    
}
