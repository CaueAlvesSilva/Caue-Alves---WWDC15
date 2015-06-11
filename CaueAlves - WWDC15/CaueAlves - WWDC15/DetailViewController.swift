//
//  DetailViewController.swift
//  CaueAlves - WWDC15
//
//  Created by Cauê Silva on 21/04/15.
//  Copyright (c) 2015 Cauê Silva. All rights reserved.
//

import UIKit
import AVFoundation

class DetailViewController: UIViewController, UIPageViewControllerDataSource {

    // MARK: - Properties
    //================================================================
    var type:String!
    
    private var pageViewController: UIPageViewController?
    
    var contentImages: [(photoName:String, photoTitle:String, photoText:String)] = []
    
    var audioPlayerSound = AVAudioPlayer()
    var gameSoundBlop = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("change", ofType: "wav")!)
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
        let pageController = self.storyboard!.instantiateViewControllerWithIdentifier("PageController") as! UIPageViewController
        pageController.dataSource = self
        
        if contentImages.count > 0
        {
            let firstController = getItemController(0)!
            let startingViewControllers: NSArray = [firstController]
            pageController.setViewControllers(startingViewControllers as [AnyObject], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
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
        audioPlayerSound = AVAudioPlayer(contentsOfURL: gameSoundBlop, error: nil)
        audioPlayerSound.prepareToPlay()
        audioPlayerSound.play()
        audioPlayerSound.volume = 0.3
        
        let itemController = viewController as! PageItemController
        
        if itemController.itemIndex > 0
        {
            return getItemController(itemController.itemIndex-1)
        }
        
        return nil
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController?
    {
        audioPlayerSound = AVAudioPlayer(contentsOfURL: gameSoundBlop, error: nil)
        audioPlayerSound.prepareToPlay()
        audioPlayerSound.play()
        audioPlayerSound.volume = 0.3
        
        let itemController = viewController as! PageItemController
        
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
            let pageItemController = self.storyboard!.instantiateViewControllerWithIdentifier("ItemController") as! PageItemController
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
            contentImages =
                [("workPhoto1",
                  "First Job",
                  "In 2012 I got my first job in\nInformation Tecnology area on\nStefanini consultancy.\nI worked as analyst requirements\nusing UML."),
                
                 ("workPhoto2",
                  "Developer",
                  "In 2013, still working on Stefanini,\nI started to develop my first codes\nin COBOL and JCL languages."),
                
                 ("workPhoto3",
                  "Bank Developer",
                  "In 2014 I had almost 2 years experience developing in COBOL, then I got a job in Itau bank, one of the most importants banks in Brazil. In Itau I participated of big projects and I wrote my name in codes that run daily.")]
        }
        else if (photoType == "Study")
        {
            contentImages =
                [("studyPhoto1",
                  "High School Graduation",
                  "In 2011, I graduated at\nAlbert Einstein Technical School."),
                    
                 ("studyPhoto2",
                  "Developer",
                  "In Albert Einstein I also gratuated as technical developer. I developed a project called ECOSOFT, a software that helped and encouraged people to recycle eletronic materials."),
                    
                 ("studyPhoto3",
                  "University",
                  "In 2012 I began to study\nInformation Technology in\nMackenzie University."),
            
                 ("studyPhoto4",
                  "Other Courses",
                  "Since 2011, I already studied many development languages,\nincluding Java, MySQL, COBOL, JCL, DB2, HTML and UML too."),
            
                 ("studyPhoto5",
                  "iOS Development",
                  "In 2015, I began to study and develop iOS applications in a university project called MackMobile.")]
        }
        else if (photoType == "Family")
        {
            contentImages =
                [("familyPhoto1",
                  "My Family",
                  "This is my family, my mom Sueli,\nmy sisters Priscila and Mayara,\nand my brother Fabricio.\nI'm the youngest of the family."),
                    
                 ("familyPhoto2",
                  "Girlfriend",
                  "I live with my girlfriend Gabriela,\nshe is studying to be a\nWeb Designer and helps me a lot\nwith my projects."),
            
                 ("familyPhoto3",
                  "My son",
                  "I still don't know him personally,\nbut he is coming soon.")]
        }
        else if (photoType == "Hobbies")
        {
            contentImages =
                [("hobbiesPhoto1",
                  "Video Games",
                  "As a good geek, one of my favorites hobbies is play video games,\nespecially soccer and FPS games."),
                    
                 ("hobbiesPhoto2",
                  "Watch TV",
                  "In free time I also like\nto watch tv programs, movies, series\nand go to the cinema."),
            
                 ("hobbiesPhoto3",
                  "Soccer",
                  "As a good brazilian, I love soccer.\nI like to play soccer with friends,\nwatch soccer matches on tv\nand go to the stadium.")]
        }
    }
    //================================================================
    
}
