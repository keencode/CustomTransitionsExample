//
//  CustomPresentationController.swift
//  CustomTransitionsExample
//
//  Created by Yee Peng Chia on 12/28/14.
//  Copyright (c) 2014 Keen Code Interactive. All rights reserved.
//

import UIKit

class CustomPresentationController: UIPresentationController {
   
    override func presentationTransitionWillBegin() {
        self.containerView.addSubview(self.presentedView())
        
        if let transitionCoordinator = self.presentingViewController.transitionCoordinator() {
            transitionCoordinator.animateAlongsideTransition(
                {(context: UIViewControllerTransitionCoordinatorContext!) -> Void in
//                var fromViewController = context.viewControllerForKey(UITransitionContextFromViewControllerKey)
//                println("fromViewController:\(fromViewController)")
                },
                completion:nil)
        }
    }
    
    override func presentationTransitionDidEnd(completed: Bool)  {
        if !completed {
        }
    }
    
    override func dismissalTransitionWillBegin()  {
        if let transitionCoordinator = self.presentingViewController.transitionCoordinator() {
            transitionCoordinator.animateAlongsideTransition(
                {(context: UIViewControllerTransitionCoordinatorContext!) -> Void in
                    
                },
                completion:nil)
        }
    }
    
    override func dismissalTransitionDidEnd(completed: Bool) {
        if completed {
        }
    }
    
    override func frameOfPresentedViewInContainerView() -> CGRect {
        var frame = self.containerView.bounds;
        return frame
    }
    
    override func viewWillTransitionToSize(size: CGSize,
        withTransitionCoordinator transitionCoordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: transitionCoordinator)
        
        transitionCoordinator.animateAlongsideTransition(
            {(context: UIViewControllerTransitionCoordinatorContext!) -> Void in
//                var firstViewController = self.presentingViewController as FirstViewController
//                firstViewController.button.frame = self.containerView.bounds
            },
            completion:nil)
    }
}
