//
//  Animator.swift
//  UICatalog
//

import UIKit

class AnimationResource {
    var imageView: UIImageView
    
    init(imageView: UIImageView) {
        self.imageView = imageView
    }
}

protocol AnimationDataSource where Self: UIViewController {
    func animationDataSource() -> AnimationResource
}

class Animator: NSObject, UIViewControllerAnimatedTransitioning {
    
    var isForward: Bool = true
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.25
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let from = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)! as! (UIViewController & AnimationDataSource)
        
        let to = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)! as! (UIViewController & AnimationDataSource)
        
        let containerView = transitionContext.containerView
        let duration = transitionDuration(using: transitionContext)
        
        // from resource
        let fromTransitionImage = from.animationDataSource().imageView
        let imageSnapshot = UIImageView(image: fromTransitionImage.image)
        imageSnapshot.contentMode = fromTransitionImage.contentMode
        imageSnapshot.clipsToBounds = fromTransitionImage.clipsToBounds
        imageSnapshot.frame = containerView.convert(fromTransitionImage.frame, from: fromTransitionImage.superview)
        fromTransitionImage.isHidden = true
        
        // to resource
        let toTransitionImage = to.animationDataSource().imageView
        to.view.frame = transitionContext.finalFrame(for: to)
        
        if isForward {
            to.view.alpha = 0.0
            containerView.addSubview(to.view)
            toTransitionImage.isHidden = true
            toTransitionImage.image = fromTransitionImage.image
            containerView.addSubview(imageSnapshot)
            
            UIView.animate(withDuration: duration, delay: 0.0, options: .curveEaseIn, animations: {
            
                to.view.alpha = 1.0
                imageSnapshot.frame = containerView.convert(toTransitionImage.frame, from: to.view)
                            
            }, completion: { (finished) in
                
                imageSnapshot.removeFromSuperview()
                
                fromTransitionImage.isHidden = false
                toTransitionImage.isHidden = false
                
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
            
        } else {
            toTransitionImage.isHidden = true
            containerView.insertSubview(to.view, belowSubview: from.view)
            containerView.addSubview(imageSnapshot)
            
            UIView.animate(withDuration: duration, delay: 0.0, options: .curveEaseIn, animations: {
            
                from.view.alpha = 0.0
                imageSnapshot.frame = containerView.convert(toTransitionImage.frame, from: toTransitionImage.superview)
                
            }, completion: { (finished) in
                
                imageSnapshot.removeFromSuperview()
                
                fromTransitionImage.isHidden = false
                toTransitionImage.isHidden = false
                
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
        }
    }
    

}
