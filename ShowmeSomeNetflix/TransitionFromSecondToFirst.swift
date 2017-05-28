//
//  TransitionFromSecondToFirst.swift
//  ShowmeSomeNetflix
//
//  Created by Michel Goñi on 17/3/17.
//  Copyright © 2017 Michel Goñi. All rights reserved.
//

import UIKit

class TransitionFromSecondToFirst: NSObject, UIViewControllerAnimatedTransitioning {
    
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 2.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let fromViewController = transitionContext.viewController(forKey: .from)! as! MovieViewController
        let toViewController = transitionContext.viewController(forKey: .to)! as! ListViewController
                let containerView = transitionContext.containerView
        let finalFrameForVC = transitionContext.finalFrame(for: toViewController)
      
        let bounds = UIScreen.main.bounds
        toViewController.view.frame = finalFrameForVC.offsetBy(dx: 0, dy: -bounds.size.height)
        containerView.addSubview(toViewController.view)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: .curveLinear, animations: {
            fromViewController.view.alpha = 0.5
            toViewController.view.frame = finalFrameForVC
        }, completion: {
            finished in
            transitionContext.completeTransition(true)
            fromViewController.view.alpha = 1.0
        })

    }
}
