//
//  MenuViewController.swift
//  CaueAlves - WWDC15
//
//  Created by Cauê Silva on 17/04/15.
//  Copyright (c) 2015 Cauê Silva. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet weak var imgImagem: UIImageView!
    @IBOutlet weak var btnButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        btnButton.layer.backgroundColor = UIColor .greenColor().CGColor
        btnButton.layer.borderWidth = 1.5
        btnButton.layer.borderColor = UIColor .grayColor().CGColor
        btnButton.layer.cornerRadius = 40
        btnButton.layer.masksToBounds = true
        btnButton.clipsToBounds = true
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
