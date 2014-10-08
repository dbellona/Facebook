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
        return 0.25
    }
    
    
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        var containerView = transitionContext.containerView()
        var toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        var fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        
        
        if (isPresenting) {
            // copy UIImageView and put it on window
            var window = UIApplication.sharedApplication().keyWindow
            var tempImage = UIImageView()
            tempImage.frame = window.convertRect(imageViewToSegue.frame, fromView: scrollView)
            tempImage.clipsToBounds = true
            //tempImage.contentMode = imageViewToSegue.contentMode
            tempImage.contentMode = UIViewContentMode.ScaleAspectFill
            tempImage.image = imageViewToSegue.image
            window.addSubview(tempImage)
            
            containerView.addSubview(toViewController.view)
            toViewController.view.alpha = 0
            
            if let vc = toViewController as? PhotoViewController {
                vc.imageView.hidden = true
            }
            
            var tempRatio = 320 / imageViewToSegue.frame.width
            
            UIView.animateWithDuration(0.25, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                toViewController.view.alpha = 1
                
                tempImage.clipsToBounds = true
                
                tempImage.frame.size.width = 320
                tempImage.frame.size.height = 320 * (tempImage.image!.size.height / tempImage.image!.size.width)
                tempImage.center.x = toViewController.view.frame.size.width / 2
                tempImage.center.y = toViewController.view.frame.size.height / 2
                
                }) { (finished: Bool) -> Void in
                    tempImage.removeFromSuperview()
                    if let vc = toViewController as? PhotoViewController {
                        vc.imageView.hidden = false
                    }
                    transitionContext.completeTransition(true)
                    toViewController.view.backgroundColor = UIColor.clearColor()
            }
            
        } else {
            let vc = fromViewController as PhotoViewController
            var tempImage = UIImageView(frame: vc.imageView.frame)
            var window = UIApplication.sharedApplication().keyWindow
            tempImage.contentMode = UIViewContentMode.ScaleAspectFill
            tempImage.clipsToBounds = true
            
            tempImage.image = imageViewToSegue.image
            window.addSubview(tempImage)
            vc.imageView.hidden = true

            tempImage.frame.size.width = 320
            tempImage.frame.size.height = 320 * (vc.imageView.image!.size.height / vc.imageView.image!.size.width)
            
            // place image
            var tempLocation = ((fromViewController.view.frame.size.height - tempImage.frame.size.height) / 2) - vc.scrollView.contentOffset.y
            tempImage.frame.origin.y = tempLocation
            
            
            println("fromViewController.view.frame.size.height: \(fromViewController.view.frame.size.height)")
            println("tempImage.frame.size.height: \(tempImage.frame.size.height)")
            println("difference: \(fromViewController.view.frame.size.height - tempImage.frame.size.height)")
            println("div by 2: \((fromViewController.view.frame.size.height - tempImage.frame.size.height) / 2)")
            println("tempImage.frame.origin.y: \(tempImage.frame.origin.y)")
            println("///////////////////////////////////////////")
            println("withScroll: \(((fromViewController.view.frame.size.height - tempImage.frame.size.height) / 2) - vc.scrollView.contentOffset.y)")
            println("///////////////////////////////////////////")
            
            
            UIView.animateWithDuration(0.25, animations: { () -> Void in
                fromViewController.view.alpha = 0
                tempImage.frame = window.convertRect(self.imageViewToSegue.frame, fromView: self.scrollView)
                
                }) { (finished: Bool) -> Void in
                    fromViewController.view.removeFromSuperview()
                    tempImage.removeFromSuperview()
                    transitionContext.completeTransition(true)
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
