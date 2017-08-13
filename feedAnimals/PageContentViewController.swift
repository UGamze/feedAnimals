//
//  PageContentViewController.swift
//  feedAnimals
//
//  Created by Gamze Ulucan on 10.08.17.
//  Copyright © 2017 Gamze Ulucan. All rights reserved.
//

import UIKit

class PageContentViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    lazy var VCArr: [UIViewController] = {
        return [self.VCInstance(name: "FirstPageViewController"),
                self.VCInstance(name: "SecondPageViewController"),
                self.VCInstance(name: "ThirdPageViewController")]
    }()
    
    private func VCInstance(name: String) -> UIViewController{
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: name)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.dataSource = self
        
        
        //to change the color of dots / pageIndicator
        let pageControl = UIPageControl.appearance()
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.currentPageIndicatorTintColor = UIColor.darkGray
        
        
        if let firstVC = VCArr.first{
            
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
            
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        for view in self.view.subviews{
            if view is UIScrollView{
                view.frame = UIScreen.main.bounds
            }else if view is UIPageControl{
                view.backgroundColor = UIColor.clear
                
            }
        }
    }
    
    func changeVC(VC: UIViewController) {
        setViewControllers([VC], direction: .forward, animated: true, completion: nil)
    }


    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?{
        
        guard let viewControllerIndex = VCArr.index(of: viewController) else{
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else{
            return VCArr.last
        }
        
        guard VCArr.count > previousIndex else{
            return nil
        }
        
        return VCArr[previousIndex]
        
        
        
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?{
        
        guard let viewControllerIndex = VCArr.index(of: viewController) else{
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        
        guard nextIndex < VCArr.count else{
            return VCArr.first
        }
        
        guard VCArr.count > nextIndex else{
            return nil
        }
        
        return VCArr[nextIndex]
        
    }
    
    public func presentationCount(for pageViewController: UIPageViewController) -> Int{
        
        return VCArr.count
        
    }
    
    public func presentationIndex(for pageViewController: UIPageViewController) -> Int{

        guard let firstViewController = viewControllers?.first,
            let firstViewControllerIndex = VCArr.index(of: firstViewController) else{
                
                return 0
        }

        
        return firstViewControllerIndex
        
    }
    
}
