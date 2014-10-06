//
//  FeedViewController.swift
//  Facebook
//
//  Created by David Bellona on 10/5/14.
//  Copyright (c) 2014 David Bellona. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController, UIScrollViewDelegate, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var feedImage: UIImageView!
    @IBOutlet weak var photoOneImage: UIImageView!
    @IBOutlet weak var photoTwoImage: UIImageView!
    @IBOutlet weak var photoThreeImage: UIImageView!
    @IBOutlet weak var photoFourImage: UIImageView!
    @IBOutlet weak var photoFiveImage: UIImageView!
    
    var imageViewToSegue : UIImageView!
    var isPresenting: Bool = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // scroll
        scrollView.delegate = self
        scrollView.contentSize = feedImage.frame.size
        scrollView.sendSubviewToBack(feedImage)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func animationControllerForPresentedController(presented: UIViewController!, presentingController presenting: UIViewController!, sourceController source: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
        isPresenting = true
        return self
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
        isPresenting = false
        return self
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        // The value here should be the duration of the animations scheduled in the animationTransition method
        return 1.4
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        var containerView = transitionContext.containerView()
        var toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        var fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        
        if (isPresenting) {
            containerView.addSubview(toViewController.view)
            toViewController.view.alpha = 0
            toViewController.view.frame.origin.x = -100
            println("\(toViewController.view.frame.origin.x)")
            
            UIView.animateWithDuration(1.4, animations: { () -> Void in
                toViewController.view.alpha = 1
                }) { (finished: Bool) -> Void in
                    transitionContext.completeTransition(true)
            }
        } else {
            UIView.animateWithDuration(1.4, animations: { () -> Void in
                fromViewController.view.alpha = 0
                }) { (finished: Bool) -> Void in
                    transitionContext.completeTransition(true)
                    fromViewController.view.removeFromSuperview()
            }
        }
    }

    @IBAction func onTapPhoto(gestureRecognizer: UITapGestureRecognizer) {
        imageViewToSegue = gestureRecognizer.view as UIImageView
        performSegueWithIdentifier("photoSegue", sender: self)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        var destinationViewController = segue.destinationViewController as PhotoViewController
        destinationViewController.image = self.imageViewToSegue.image
        
        destinationViewController.modalPresentationStyle = UIModalPresentationStyle.Custom
        destinationViewController.transitioningDelegate = self
        
    }
    
    
}




//        var location = gestureRecognizer.locationInView(view)
//
//        var imageView = gestureRecognizer.view as UIImageView
//
//        imageView.frame.origin.x = location.x
//view.addSubview(imageView)

//imageView.center.y = location.y