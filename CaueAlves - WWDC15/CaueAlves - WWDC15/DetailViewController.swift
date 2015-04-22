//
//  DetailViewController.swift
//  CaueAlves - WWDC15
//
//  Created by Cauê Silva on 21/04/15.
//  Copyright (c) 2015 Cauê Silva. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UIPageViewControllerDataSource {

    // MARK: - Properties
    //================================================================
    var type:String!
    
    private var pageViewController: UIPageViewController?
    
    var contentImages: [(photoName:String, photoTitle:String, photoText:String)] = []
    //================================================================
    
    
    
    // MARK: - View Lifecycle
    //================================================================
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        selectPhotos(type)
        createPageViewController()
        setupPageControl()
        
        self.navigationItem.title = type
    }
    //================================================================
    
    
    
    // MARK: - Create the PageViewController
    //================================================================
    // create
    private func createPageViewController()
    {
        let pageController = self.storyboard!.instantiateViewControllerWithIdentifier("PageController") as UIPageViewController
        pageController.dataSource = self
        
        if contentImages.count > 0
        {
            let firstController = getItemController(0)!
            let startingViewControllers: NSArray = [firstController]
            pageController.setViewControllers(startingViewControllers, direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
        }
        
        pageViewController = pageController
        addChildViewController(pageViewController!)
        self.view.addSubview(pageViewController!.view)
        pageViewController!.didMoveToParentViewController(self)
    }
    
    // setUp
    private func setupPageControl()
    {
        let appearance = UIPageControl.appearance()
        appearance.pageIndicatorTintColor = UIColor.grayColor()
        appearance.currentPageIndicatorTintColor = UIColor.whiteColor()
        appearance.backgroundColor = UIColor.darkGrayColor()
    }
    //================================================================
    
    
    
    // MARK: - Page Controller DataSource
    //================================================================
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController?
    {
        
        let itemController = viewController as PageItemController
        
        if itemController.itemIndex > 0
        {
            return getItemController(itemController.itemIndex-1)
        }
        
        return nil
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController?
    {
        
        let itemController = viewController as PageItemController
        
        if itemController.itemIndex+1 < contentImages.count
        {
            return getItemController(itemController.itemIndex+1)
        }
        
        return nil
    }
    
    private func getItemController(itemIndex: Int) -> PageItemController?
    {
        if itemIndex < contentImages.count
        {
            let pageItemController = self.storyboard!.instantiateViewControllerWithIdentifier("ItemController") as PageItemController
            pageItemController.itemIndex = itemIndex
            pageItemController.imageName = contentImages[itemIndex].photoName
            pageItemController.photoTitle = contentImages[itemIndex].photoTitle
            pageItemController.photoText = contentImages[itemIndex].photoText
            return pageItemController
        }
        
        return nil
    }
    //================================================================
    
    
    
    // MARK: - Page Indicator
    //================================================================
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int
    {
        return contentImages.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int
    {
        return 0
    }
    //================================================================
    
    
    
    // MARK: - Selecting photos, titles and texts
    //================================================================
    func selectPhotos(photoType: String)
    {
        if (photoType == "Work")
        {
            contentImages = [("workPhoto1.png", "Photo of Work 1", "This is the text of the work photo 1"),
                             ("workPhoto2.png", "Photo of Work 2", "This is the text of the work photo 2"),
                             ("workPhoto3.png", "Photo of Work 3", "This is the text of the work photo 3")]
        }
        else if (photoType == "Study")
        {
            contentImages = [("studyPhoto1.png", "Photo of Study 1", "This is the text of the study photo 1"),
                             ("studyPhoto2.png", "Photo of Study 2", "This is the text of the study photo 2"),
                             ("studyPhoto3.png", "Photo of Study 3", "This is the text of the study photo 3")]
        }
        else if (photoType == "Family")
        {
            contentImages = [("familyPhoto1.png", "Photo of Family 1", "This is the text of the family photo 1"),
                             ("familyPhoto2.png", "Photo of Family 2", "This is the text of the family photo 2"),
                             ("familyPhoto3.png", "Photo of Family 3", "This is the text of the family photo 3")]
        }
        else if (photoType == "Hobbies")
        {
            contentImages = [("hobbiesPhoto1.png", "Photo of Hobbies 1", "This is the text of the hobbies photo 1"),
                             ("hobbiesPhoto2.png", "Photo of Hobbies 2", "This is the text of the hobbies photo 2"),
                             ("hobbiesPhoto3.png", "Photo of Hobbies 3", "This is the text of the hobbies photo 3")]
        }
    }
    //================================================================
    
}
