//
//  MoreViewController.swift
//  Facebook
//
//  Created by David Bellona on 10/5/14.
//  Copyright (c) 2014 David Bellona. All rights reserved.
//

import UIKit

class MoreViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var settingsImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // scroll
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: 320, height: settingsImage.frame.height + 112)
        scrollView.sendSubviewToBack(settingsImage)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
