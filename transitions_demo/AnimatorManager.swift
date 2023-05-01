//
//  AnimatorManager.swift
//  transitions_demo
//
//  Created by Sonic on 30/4/23.
//

import UIKit

final class AnimatorManager: NSObject, UIViewControllerAnimatedTransitioning {
    
    private let duration: TimeInterval
    private var operation: UINavigationController.Operation
    
    init(duration: TimeInterval) {
        
        self.duration = duration
        self.operation = .push
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let fromViewController = transitionContext.viewController(forKey: .from),
              let toViewController = transitionContext.viewController(forKey: .to) else {
            transitionContext.completeTransition(false)
            return
        }
        
        animateTransition(from: fromViewController, to: toViewController, with: transitionContext)
    }

}

extension AnimatorManager: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        self.operation = operation
        if operation == .push {
            return self
        }
        
        return nil
    }
}

private extension AnimatorManager {
    
    func animateTransition<F: UIViewController,T: UIViewController>(from fromViewController: F, to toViewController: T, with context: UIViewControllerContextTransitioning) {
        
        switch operation {
        case .push:
            
            presentViewConrtoller(toViewController, from: fromViewController, with: context)
        default:
            break
        }
    }
    
    func presentViewConrtoller<T: UIViewController, F: UIViewController>(_ toViewController: T, from fromViewController: F, with context: UIViewControllerContextTransitioning) {
        
        guard let fromViewController = fromViewController as? UIFromAnimatedViewController,
              let contentView = fromViewController.contentViewReservedToAnimate,
              let imageView = fromViewController.imageViewReservedToAnimate,
              let toViewController = toViewController as? UIFromAnimatedViewController,
              let destinyImageView = toViewController.imageViewReservedToAnimate,
              let destinyContentView = toViewController.contentViewReservedToAnimate
        else {
            return
        }
                
        toViewController.view.layoutIfNeeded()
        
        let containerView = context.containerView
        
        let snapshotContentView = UIView()
        snapshotContentView.backgroundColor = .systemBackground
        snapshotContentView.frame = containerView.convert(contentView.frame, from: contentView)
        snapshotContentView.layer.cornerRadius = contentView.layer.cornerRadius
        
        let snapshotImageView = UIImageView()
        snapshotImageView.clipsToBounds = true
        snapshotImageView.contentMode = imageView.contentMode
        snapshotImageView.image = imageView.image
        snapshotImageView.layer.cornerRadius = imageView.layer.cornerRadius
        snapshotImageView.frame = containerView.convert(imageView.frame, from: contentView)
        
        containerView.addSubview(toViewController.view)
        containerView.addSubview(snapshotContentView)
        containerView.addSubview(snapshotImageView)
        
        toViewController.view.isHidden = true
        
        let animator = UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {
            snapshotContentView.frame = containerView.convert(toViewController.view.frame, from: toViewController.view)
            snapshotImageView.frame = containerView.convert(destinyImageView.frame, from: destinyContentView)
        }
        
        animator.addCompletion { position in
            toViewController.view.isHidden = false
            snapshotImageView.removeFromSuperview()
            snapshotContentView.removeFromSuperview()
            context.completeTransition(position == .end)
        }
        
        animator.startAnimation()
    }
}

