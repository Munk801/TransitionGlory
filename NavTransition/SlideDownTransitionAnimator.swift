//
//  SlideDownTransitionAnimator.swift
//  NavTransition
//
//  Created by Stephen Lu on 4/22/15.
//  Copyright (c) 2015 AppCoda. All rights reserved.
//

import UIKit

class SlideDownTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    
    var duration: Double = 0.5
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return duration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)!
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
        
        // Set the transform and use in the animation
        let container = transitionContext.containerView()
        let offScreenUp = CGAffineTransformMakeTranslation(0, -container.frame.height)
        let offScreenDown = CGAffineTransformMakeTranslation(0, container.frame.height)
        
        // Move dest view up to set it up initially
        toView.transform = offScreenUp
        
        container.addSubview(fromView)
        container.addSubview(toView)
        
        UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: nil, animations: {
            fromView.transform = offScreenDown
            fromView.alpha = 0.5
            toView.transform = CGAffineTransformIdentity
            }, completion: { finished in
                // Inform the transition is complete
                transitionContext.completeTransition(true)
        })
    }
    
    
   
}