//
//  SlideOutAnimationController.swift
//  StoreSearch
//
//  Created by Nick "Fox" Borer on 02/28/2023.
//

import Foundation
import UIKit

class SlideOutAnimationController: NSObject, UIViewControllerAnimatedTransitioning
{
   //Makes the Animation Slide-Out
   func transitionDuration( using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval
   {
      return 0.3
   }
   
   
   func animateTransition(using transitionContext: UIViewControllerContextTransitioning)
   {
      if let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from)
      {
	 let containerView = transitionContext.containerView
	 let time = transitionDuration(using: transitionContext)
	 
	 UIView.animate(
	    withDuration: time,
	    animations:
	       {
		  fromView.center.y = fromView.center.y - containerView.bounds.size.height
		  fromView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
	       }, completion:
	          {
		  finished in
		  transitionContext.completeTransition(finished)
	          }
	                )
      }
   }
}
