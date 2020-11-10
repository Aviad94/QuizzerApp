//
//  PageViewController.swift
//  TheQuizzler - iOS
//
//  Created by Aviad Sabag on 09/11/2020.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    lazy var orderedViewControllers: [UIViewController] = {
            return [
                self.newVc(viewController: "sbBlue"),self.newVc(viewController: "sbWelcome"),self.newVc(viewController: "sbQuestions") ,self.newVc(viewController: "sbThanks")
            
            ]
        }()
    
    
    var pageControl = UIPageControl()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self

                // This sets up the first view that will show up on our page control
                if let firstViewController = orderedViewControllers.first {
                    setViewControllers([firstViewController],
                                       direction: .forward,
                                       animated: true,
                                       completion: nil)
                }


        self.delegate = self
        configurePageControl()
        
    }
    

    func newVc(viewController: String) -> UIViewController {
            return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewController)
        }
    
    
    
    
    // MARK: Data source functions.
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
            guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
                return nil
            }
            
            let previousIndex = viewControllerIndex - 1
            
            // User is on the first view controller and swiped left to loop to
            // the last view controller.
            guard previousIndex >= 0 else {
//                return orderedViewControllers.last
                
                return nil // we dont want the user to swipe left and get to the last VC.
            }
            
            guard orderedViewControllers.count > previousIndex else {
                return nil
            }
            
            return orderedViewControllers[previousIndex]
        }
        
    
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
           guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else { // checking if the arr is empty
                return nil
            }
            
            let nextIndex = viewControllerIndex + 1
            let orderedViewControllersCount = orderedViewControllers.count
            
            // User is on the last view controller and swiped right to loop to
            // the first view controller.
            guard orderedViewControllersCount != nextIndex else {
//                return orderedViewControllers.first
                 return nil // we don't want the page control to loop
            }
            
            guard orderedViewControllersCount > nextIndex else {
                return nil
            }
            
            return orderedViewControllers[nextIndex]
        }
    
    
    
    // MARK: Dots inditor Methods:
    func configurePageControl() {
            pageControl = UIPageControl(frame: CGRect(x: 0,y: UIScreen.main.bounds.maxY - 50,width: UIScreen.main.bounds.width,height: 50))
            self.pageControl.numberOfPages = orderedViewControllers.count // number of dots acordding to VCs number.
            self.pageControl.currentPage = 0
            self.pageControl.tintColor = UIColor.black
            self.pageControl.pageIndicatorTintColor = UIColor.systemGray // color of the indicator
            self.pageControl.currentPageIndicatorTintColor = UIColor.systemBlue // color of the selected indictor
            self.view.addSubview(pageControl)
        }
    
    
    
    // MARK: Delegate functions
        func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
            let pageContentViewController = pageViewController.viewControllers![0]
            self.pageControl.currentPage = orderedViewControllers.index(of: pageContentViewController)!
        }
}


