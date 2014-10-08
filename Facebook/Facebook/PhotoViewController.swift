//
//  PhotoViewController.swift
//  Facebook
//
//  Created by David Bellona on 10/5/14.
//  Copyright (c) 2014 David Bellona. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController, UIViewControllerTransitioningDelegate, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var actionBarImageView: UIImageView!
    @IBOutlet weak var doneButton: UIButton!
    
    
    var image: UIImage!
    var imageMaxScroll: CGFloat = 70

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // scroll
        scrollView.delegate = self
        scrollView.contentSize = imageView.frame.size
        scrollView.sendSubviewToBack(imageView)
        
        imageView.image = image
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        
        // var scaleFactor = view.frame.width / imageView.frame.width
        // imageView.transform = CGAffineTransformMakeScale(scaleFactor, scaleFactor)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            self.actionBarImageView.alpha = 0
            self.doneButton.alpha = 0
            }, completion: nil)
    }
    

    func scrollViewDidScroll(scrollView: UIScrollView!) {
        var difference = scrollView.contentOffset.y / 293
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            self.scrollView.backgroundColor = UIColor(white: 0, alpha: 1 - abs(difference))
            }, completion: nil)
        }

    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {

        if scrollView.contentOffset.y > imageMaxScroll || scrollView.contentOffset.y < -imageMaxScroll {
            dismissViewControllerAnimated(true, completion: nil)
        } else {
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                self.actionBarImageView.alpha = 1
                self.doneButton.alpha = 1
                }, completion: nil)
        }
    }

    
    @IBAction func onTapDone(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    
}
