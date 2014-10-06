//
//  PhotoViewController.swift
//  Facebook
//
//  Created by David Bellona on 10/5/14.
//  Copyright (c) 2014 David Bellona. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController, UIViewControllerTransitioningDelegate {
    @IBOutlet weak var imageView: UIImageView!
    
    var image: UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = image
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func onTapDone(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
