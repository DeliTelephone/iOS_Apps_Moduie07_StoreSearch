//
//  FadeOutAnimationController.swift
//  StoreSearch
//
//  Created by Nick "Fox" Borer on 03/02/2023.
//

import Foundation
import UIKit


class FadeOutAminationController: NSObject, UIViewControllerAnimatedTransitioning
{
   //Makes the Animation Fade-Out 
   func transitionDuration(
      using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval
   {
      return 0.4
   }
   
   func animateTransition(using transitionContext: UIViewControllerContextTransitioning)
   {
      if let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from)
      {
	 let time = transitionDuration(using: transitionContext)
	 UIView.animate(withDuration: time,
			animations: { fromView.alpha = 0.0 },
			completion: {finished in transitionContext.completeTransition(finished) }
	                )
      }
   }
   
   
}
