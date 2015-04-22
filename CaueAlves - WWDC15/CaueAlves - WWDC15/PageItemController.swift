//
//  PageItemController.swift
//  CaueAlves - WWDC15
//
//  Created by Cauê Silva on 21/04/15.
//  Copyright (c) 2015 Cauê Silva. All rights reserved.
//

import UIKit

class PageItemController: UIViewController {
    
    // MARK: - Properties
    //================================================================
    var itemIndex: Int = 0
    
    var photoTitle: String = "" {
        didSet {
            if let labelTitle = lblPhotoTitle {
                labelTitle.text = photoTitle
            }
        }
    }
    
    var photoText: String = "" {
        didSet {
            if let labelText = lblPhotoText {
                labelText.text = photoText
            }
        }
    }
        
    var imageName: String = "" {
        didSet {
            if let imageView = contentImageView {
                imageView.image = UIImage(named: imageName)
            }
        }
    }
    
    // Outlets
    
    @IBOutlet var contentImageView: UIImageView?
    
    @IBOutlet weak var lblPhotoTitle: UILabel?
    
    @IBOutlet weak var lblPhotoText: UILabel?
    //================================================================
    
    
    
    // MARK: - View Lifecycle
    //================================================================
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        contentImageView!.image = UIImage(named: imageName)
        lblPhotoTitle!.text = photoTitle
        lblPhotoText!.text = photoText
    }
    //================================================================

}
