//
//  MenuViewController.swift
//  CaueAlves - WWDC15
//
//  Created by Cauê Silva on 17/04/15.
//  Copyright (c) 2015 Cauê Silva. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet weak var btnWork: UIButton!
    @IBInspectable
    @IBOutlet weak var btnStudy: UIButton!
    
    @IBInspectable
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
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
