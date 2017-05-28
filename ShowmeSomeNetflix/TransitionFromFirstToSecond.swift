//
//  TransitionFromFirstToSecond.swift
//  ShowmeSomeNetflix
//
//  Created by Michel Goñi on 17/3/17.
//  Copyright © 2017 Michel Goñi. All rights reserved.
//

import UIKit

class TransitionFromFirstToSecond: NSObject, UIViewControllerAnimatedTransitioning {

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
         return 2.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let fromViewController = transitionContext.viewController(forKey: .from)! as! ListViewController
        let toViewController = transitionContext.viewController(forKey: .to)! as! MovieViewController
        let containerView = transitionContext.containerView
        let finalFrameForVC = transitionContext.finalFrame(for: toViewController)
        
        let bounds = UIScreen.main.bounds
        toViewController.view.frame = finalFrameForVC.offsetBy(dx: 0, dy: bounds.size.height)
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
    
//
//        let fromViewController = transitionContext.viewController(forKey: .from)! as! ListViewController
//        let toViewController = transitionContext.viewController(forKey: .to)! as! MovieViewController
//        let containerView = transitionContext.containerView
//        
//        let duration = transitionDuration(using: transitionContext)
//        
//        let  cell = fromViewController.collectionViewItems .cellForItem(at: (fromViewController.collectionViewItems .indexPathsForSelectedItems?.first)!) as! MovieCell
//        let cellImageSnapShot = cell.movieImage.snapshotView(afterScreenUpdates: false)
//        cellImageSnapShot?.frame = containerView.convert(cell.movieImage.frame, from: cell.movieImage.superview)
//        cell.movieImage.isHidden = true
//        
//        toViewController.view.frame = transitionContext.finalFrame(for: toViewController)
//        toViewController.view.alpha = 0
//        toViewController.movieImg.isHidden = true
//        
//        containerView.addSubview(toViewController.view)
//        containerView.addSubview(cellImageSnapShot!)
//        
//        UIView.animate(withDuration: duration, delay: 0.0, options: .curveEaseInOut, animations: {
//            toViewController.view.alpha = 1.0
//            let frame: CGRect = containerView.convert(toViewController.movieImg.frame, from: toViewController.view)
//            cellImageSnapShot?.frame = frame
//        }, completion: {
//            finished in
//            toViewController.movieImg.isHidden = false
//            cell.isHidden = false
//            cellImageSnapShot?.removeFromSuperview()
//            
//            transitionContext.completeTransition(true)
//        })
//
//    }

}
