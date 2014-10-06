//
//  PeopleViewController.swift
//  Facebook
//
//  Created by David Bellona on 10/5/14.
//  Copyright (c) 2014 David Bellona. All rights reserved.
//

import UIKit

class PeopleViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var peopleImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // scroll
        scrollView.delegate = self
        scrollView.contentSize = peopleImage.frame.size
        scrollView.sendSubviewToBack(peopleImage)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
