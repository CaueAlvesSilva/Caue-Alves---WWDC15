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
            contentImages =
                [("workPhoto1.jpg",
                  "First Job",
                  "Em 2012 consegui meu primeiro emprego na area de TI, na consultoria STEFANINI, eu trabalhava como analista de requisitos usando UML."),
                
                 ("workPhoto2.jpg",
                  "Analyst and Developer",
                  "Em 2013 ainda trabalhando na STEFANINI, comecei a criar meus primeiros programas nas linguagens COBOL e JCL."),
                
                 ("workPhoto3.jpg",
                  "Bank Developer",
                  "Em 2014 eu ja tinha quase 2 anos de experiência em programação COBOL, consegui um emprego no Banco Itaú, um dos mais importantes bancos do Brasil. No Itaú participei de grandes projetos e pude deixar meu nome em programas que são executados todos os dias.")]
        }
        else if (photoType == "Study")
        {
            contentImages =
                [("studyPhoto1.jpg",
                  "High School Graduation",
                  "Em 2011 me formei no ensino médio pela Escola Tecnica Albert Einstein."),
                    
                 ("studyPhoto2.jpg",
                  "Technical Programmer",
                  "Na Escola Técnica Albert Einstein eu também me formei como técnico em programação, onde ajudei a criar o projeto ECOSOFT, um software que auxilia e incentiva a reciclagem de materiais eletrônicos."),
                    
                 ("studyPhoto3.jpg",
                  "University",
                  "Em 2012 comecei a estudar Sistemas de Informacao na Universidade Presbiteriana Mackenzie. Hoje estou no 3th ano e falta apenas um para me formar."),
            
                 ("studyPhoto4.png",
                  "Other Courses",
                  "Desde que comecei a estudar programacao, já fiz diversos cursos e estudei diversas linguagens, entre eles: Java, MySQL, COBOL, JCL, DB2, HTML and UML."),
            
                 ("studyPhoto5.png",
                  "iOS Development",
                  "Em 2015 comecei a estudar e desenvolver apps em iOS em um projeto da Universidade.")]
        }
        else if (photoType == "Family")
        {
            contentImages =
                [("familyPhoto1.jpg",
                  "My Family",
                  "This is my family. \nMy mom Sueli, my sisters Priscila and Mayara, and my brother Fabricio."),
                    
                 ("familyPhoto2.jpg",
                  "Girlfriend",
                  "I live with my girlfriend Gabriela, she studies to be a Web Designer and helps me a lot with my projects.")]
                    
//                 ("familyPhoto3.jpg",
//                  "My son",
//                  "Eu ainda não o conheco pessoalmente, mas ele está chegando.")]
        }
        else if (photoType == "Hobbies")
        {
            contentImages =
                [("hobbiesPhoto1.jpg",
                  "Video Games",
                  "As a good geek, one of my favorities hobbies is play video games, in special soccer and FPS games."),
                    
                 ("hobbiesPhoto2.jpg",
                  "Watch Everything",
                  "In free time i also like to watch tv programs, movies, series and go to the cinema"),
            
                 ("hobbiesPhoto3.jpg",
                  "Soccer",
                  "And as a good brazilian, i love soccer. I like to play soccer with friends, watch soccer matches on tv and go to the stadium.")]
        }
    }
    //================================================================
    
}
