//
//  CustomPresentationAnimationController.swift
//  CustomTransitionsExample
//
//  Created by Yee Peng Chia on 12/28/14.
//  Copyright (c) 2014 Keen Code Interactive. All rights reserved.
//

import UIKit

class CustomPresentationAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
   
    let isPresenting :Bool
    let duration :NSTimeInterval = 0.5
    
    init(isPresenting: Bool) {
        self.isPresenting = isPresenting
        
        super.init()
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return self.duration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning)  {
        if isPresenting {
            animatePresentationWithTransitionContext(transitionContext)
        }
        else {
            animateDismissalWithTransitionContext(transitionContext)
        }
    }
    
    // ---- Helper methods
    let defaultBackgroundInsets = UIEdgeInsetsMake(140, 60, 140, 60)
    let targetBackgroundInsets = UIEdgeInsetsMake(-20, -20, 0, -20)
    
    func animatePresentationWithTransitionContext(transitionContext: UIViewControllerContextTransitioning) {
        let presentedController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        let presentedControllerView = transitionContext.viewForKey(UITransitionContextToViewKey)!
        let containerView = transitionContext.containerView()
        containerView.addSubview(presentedControllerView)
        
        presentedControllerView.frame = transitionContext.finalFrameForViewController(presentedController)
        presentedControllerView.layoutIfNeeded()
        
        let secondViewController = presentedController as SecondViewController
        secondViewController.scrollViewTopConstraint.constant = 0.0

        let presentingController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let firstViewController = presentingController as FirstViewController
        firstViewController.backgroundTopConstraint.constant = targetBackgroundInsets.top
        firstViewController.backgroundLeadingConstraint.constant = targetBackgroundInsets.left
        firstViewController.backgroundBottomConstraint.constant = targetBackgroundInsets.bottom
        firstViewController.backgroundTrailingConstraint.constant = targetBackgroundInsets.right
        firstViewController.titleTopConstraint.constant = 30
        firstViewController.titleWidthConstraint.constant = 300.0
        firstViewController.titleHeightConstraint.constant = 105.0
        firstViewController.button.alpha = 0
        
        UIView.animateWithDuration(self.duration,
            delay: 0.0,
            usingSpringWithDamping: 0.9,
            initialSpringVelocity: 0.5,
            options: .AllowUserInteraction,
            animations: {
                presentingController.view.layoutIfNeeded()
                presentedControllerView.layoutIfNeeded();
            },
            completion: {(completed: Bool) -> Void in
                secondViewController.closeButton.hidden = false
                transitionContext.completeTransition(completed)
        })
    }
    
    func animateDismissalWithTransitionContext(transitionContext: UIViewControllerContextTransitioning) {
        let presentedControllerView = transitionContext.viewForKey(UITransitionContextFromViewKey)!
        presentedControllerView.layoutIfNeeded()
        
        let containerView = transitionContext.containerView()

        let presentedController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let secondViewController = presentedController as SecondViewController
        secondViewController.closeButton.hidden = true
        secondViewController.scrollViewTopConstraint.constant = containerView.bounds.size.height
        
        let presentingController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        let firstViewController = presentingController as FirstViewController
        firstViewController.backgroundTopConstraint.constant = defaultBackgroundInsets.top
        firstViewController.backgroundLeadingConstraint.constant = defaultBackgroundInsets.left
        firstViewController.backgroundBottomConstraint.constant = defaultBackgroundInsets.bottom
        firstViewController.backgroundTrailingConstraint.constant = defaultBackgroundInsets.right
        firstViewController.titleTopConstraint.constant = 118.0
        firstViewController.titleWidthConstraint.constant = 208.0
        firstViewController.titleHeightConstraint.constant = 63.0
        firstViewController.button.alpha = 1.0
        
        UIView.animateWithDuration(0.7,
            delay: 0.0,
            usingSpringWithDamping: 0.8,
            initialSpringVelocity: 0.5,
            options: .CurveLinear,
            animations: {
                presentingController.view.layoutIfNeeded()
                presentedControllerView.layoutIfNeeded()
            },
            completion: {(completed: Bool) -> Void in
                transitionContext.completeTransition(completed)
        })
    }
}
