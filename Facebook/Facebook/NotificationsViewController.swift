//
//  NotificationsViewController.swift
//  Facebook
//
//  Created by David Bellona on 10/5/14.
//  Copyright (c) 2014 David Bellona. All rights reserved.
//

import UIKit

class NotificationsViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var notificationsImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // scroll
        scrollView.delegate = self
        scrollView.contentSize = notificationsImage.frame.size
        scrollView.sendSubviewToBack(notificationsImage)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    

   

}
