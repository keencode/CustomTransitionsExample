//
//  SecondViewController.swift
//  CustomTransitionsExample
//
//  Created by Yee Peng Chia on 12/28/14.
//  Copyright (c) 2014 Keen Code Interactive. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UIViewControllerTransitioningDelegate, UIScrollViewDelegate {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var closeButton: UIButton!
    
    var titleImageView: UIImageView?
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!)  {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.commonInit()
    }
    
    func commonInit() {
        self.modalPresentationStyle = .Custom
        self.transitioningDelegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.clearColor()
        
        self.closeButton.hidden = true;
        
//        self.titleLabel.adjustsFontSizeToFitWidth = true
//        self.subtitleLabel.adjustsFontSizeToFitWidth = true
        
        self.scrollView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
        var bounds = UIScreen.mainScreen().bounds
        self.scrollView.contentSize = CGSizeMake(bounds.size.width, 1500)
        
        self.scrollViewTopConstraint.constant = bounds.size.height - 50
        self.view.layoutIfNeeded()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // ---- UIViewControllerTransitioningDelegate methods
    
    func presentationControllerForPresentedViewController(presented: UIViewController!,
        presentingViewController presenting: UIViewController!,
        sourceViewController source: UIViewController!) -> UIPresentationController! {
            
        if presented == self {
            return CustomPresentationController(presentedViewController: presented, presentingViewController: presenting)
        }
        
        return nil
    }
    
    func animationControllerForPresentedController(presented: UIViewController!,
        presentingController presenting: UIViewController!,
        sourceController source: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
        
        if presented == self {
            return CustomPresentationAnimationController(isPresenting: true)
        }
        else {
            return nil
        }
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
        
        if dismissed == self {
            return CustomPresentationAnimationController(isPresenting: false)
        }
        else {
            return nil
        }
    }
    
    // ---- UIScrollViewDelegate
    
    func scrollViewDidScroll(sender: UIScrollView) {
        if (sender.contentOffset.x != 0) {
            var offset = sender.contentOffset;
            offset.x = 0;
            sender.contentOffset = offset;
        }
    }
}
