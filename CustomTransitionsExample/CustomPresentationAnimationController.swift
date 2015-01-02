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
    
    let defaultTitleInsets = UIEdgeInsetsMake(125, 14, 0, 14)
    let targetTitleInsets = UIEdgeInsetsMake(30, 14, 0, 14)
    
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
        
        secondViewController.titleTopConstraint.constant = targetTitleInsets.top
        secondViewController.titleLeadingConstraint.constant = targetTitleInsets.left
        secondViewController.titleTrailingConstraint.constant = targetTitleInsets.right
        
        secondViewController.backgroundImageView.alpha = 0.0
        
        UIView.animateWithDuration(self.duration,
            delay: 0.0,
            usingSpringWithDamping: 0.9,
            initialSpringVelocity: 0.5,
            options: .AllowUserInteraction,
            animations: {
                presentedControllerView.layoutIfNeeded();
            },
            completion: {(completed: Bool) -> Void in
                secondViewController.closeButton.hidden = false
                transitionContext.completeTransition(completed)
        })
        
        let startScale: CGFloat = 0.5
        let endScale: CGFloat = 2.0
        secondViewController.titleLabel.font = UIFont.boldSystemFontOfSize(targetTitleFontSize)
        secondViewController.titleLabel.transform = CGAffineTransformScale(secondViewController.titleLabel.transform, startScale, startScale);
        secondViewController.subtitleLabel.font = UIFont.systemFontOfSize(targetSubtitleFontSize)
        secondViewController.subtitleLabel.transform = CGAffineTransformScale(secondViewController.subtitleLabel.transform, startScale, startScale);
        
        UIView.animateWithDuration(self.duration,
            delay: 0.0,
            options: .CurveEaseInOut,
            animations: {
                secondViewController.titleLabel.transform = CGAffineTransformScale(secondViewController.titleLabel.transform, endScale, endScale);
                secondViewController.subtitleLabel.transform = CGAffineTransformScale(secondViewController.subtitleLabel.transform, endScale, endScale);
            },
            completion: {(completed: Bool) -> Void in
        });
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
        
        secondViewController.titleTopConstraint.constant = defaultTitleInsets.top
        secondViewController.titleLeadingConstraint.constant = defaultTitleInsets.left
        secondViewController.titleTrailingConstraint.constant = defaultTitleInsets.right
        
        secondViewController.backgroundImageView.alpha = 1.0
        
        let startScale: CGFloat = 0.9
        let endScale: CGFloat = 0.6
        secondViewController.titleLabel.transform = CGAffineTransformScale(secondViewController.titleLabel.transform, startScale, startScale);
        secondViewController.subtitleLabel.transform = CGAffineTransformScale(secondViewController.subtitleLabel.transform, startScale, startScale);
        
        UIView.animateWithDuration(3.0,
            delay: 0.0,
            usingSpringWithDamping: 0.8,
            initialSpringVelocity: 0.5,
            options: .CurveLinear,
            animations: {
                secondViewController.titleLabel.transform = CGAffineTransformScale(secondViewController.titleLabel.transform, endScale, endScale);
                secondViewController.subtitleLabel.transform = CGAffineTransformScale(secondViewController.subtitleLabel.transform, endScale, endScale);
                secondViewController.titleView.layoutIfNeeded();
                presentedControllerView.layoutIfNeeded();
            },
            completion: {(completed: Bool) -> Void in
                secondViewController.titleLabel.font = UIFont.boldSystemFontOfSize(self.defaultTitleFontSize)
                secondViewController.subtitleLabel.font = UIFont.systemFontOfSize(self.defaultSubtitleFontSize)
                transitionContext.completeTransition(completed)
        })

        
//        UIView.animateWithDuration(5,
//            delay: 0.0,
//            options: .CurveLinear,
//            animations: {
//                secondViewController.titleLabel.transform = CGAffineTransformScale(secondViewController.titleLabel.transform, endScale, endScale);
//                secondViewController.subtitleLabel.transform = CGAffineTransformScale(secondViewController.subtitleLabel.transform, endScale, endScale);
//            },
//            completion: {(completed: Bool) -> Void in
//        });
    }
}
