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
    
    let defaultTitleTopConst: CGFloat = 125.0
    let targetTitleTopConst: CGFloat = 25.0
    
    let defaultTitleFontSize: CGFloat = 12.0
    let targetTitleFontSize: CGFloat = 19.0
    
    let defaultSubtitleFontSize: CGFloat = 11.0
    let targetSubtitleFontSize: CGFloat = 18.0

    let defaultTitleSubtitleConst: CGFloat = 10.0
    let targetTitleSubtitleConst: CGFloat = 20.0
    
    func animatePresentationWithTransitionContext(transitionContext: UIViewControllerContextTransitioning) {
        let presentedController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        let presentedControllerView = transitionContext.viewForKey(UITransitionContextToViewKey)!
        let containerView = transitionContext.containerView()
        containerView.addSubview(presentedControllerView)
        
        presentedControllerView.frame = transitionContext.finalFrameForViewController(presentedController)
        presentedControllerView.layoutIfNeeded()
        
        let secondViewController = presentedController as SecondViewController
        secondViewController.backgroundTopConstraint.constant = targetBackgroundInsets.top
        secondViewController.backgroundLeadingConstraint.constant = targetBackgroundInsets.left
        secondViewController.backgroundBottomConstraint.constant = targetBackgroundInsets.bottom
        secondViewController.backgroundTrailingConstraint.constant = targetBackgroundInsets.right
        secondViewController.scrollViewTopConstraint.constant = 0.0
        
        secondViewController.titleLabel.font = UIFont.boldSystemFontOfSize(targetTitleFontSize)
        secondViewController.subtitleLabel.font = UIFont.systemFontOfSize(targetSubtitleFontSize)
        secondViewController.titleSubtitleConstraint.constant = targetTitleSubtitleConst
        secondViewController.titleTopConstraint.constant = targetTitleTopConst
        
        secondViewController.backgroundImageView.alpha = 0.0
        
        UIView.animateWithDuration(self.duration,
            delay: 0.0,
            usingSpringWithDamping: 0.85,
            initialSpringVelocity: 7.0,
            options: .AllowUserInteraction,
            animations: {
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
        secondViewController.backgroundTopConstraint.constant = defaultBackgroundInsets.top
        secondViewController.backgroundLeadingConstraint.constant = defaultBackgroundInsets.left
        secondViewController.backgroundBottomConstraint.constant = defaultBackgroundInsets.bottom
        secondViewController.backgroundTrailingConstraint.constant = defaultBackgroundInsets.right
        secondViewController.scrollViewTopConstraint.constant = containerView.bounds.size.height
        
//        secondViewController.titleLabel.font = UIFont.boldSystemFontOfSize(defaultTitleFontSize)
//        secondViewController.subtitleLabel.font = UIFont.systemFontOfSize(defaultSubtitleFontSize)
//        secondViewController.titleSubtitleConstraint.constant = defaultTitleSubtitleConst
        secondViewController.titleTopConstraint.constant = defaultTitleTopConst
        
        secondViewController.backgroundImageView.alpha = 1.0
        
        // Animate the presented view off the bottom of the view
        UIView.animateWithDuration(1.5,
            delay: 0.0,
            usingSpringWithDamping: 0.9,
            initialSpringVelocity: 7.0,
            options: .AllowUserInteraction,
            animations: {
                presentedControllerView.layoutIfNeeded();
            },
            completion: {(completed: Bool) -> Void in
                transitionContext.completeTransition(completed)
        })
    }
}
