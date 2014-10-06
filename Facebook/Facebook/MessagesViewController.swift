//
//  MessagesViewController.swift
//  Facebook
//
//  Created by David Bellona on 10/5/14.
//  Copyright (c) 2014 David Bellona. All rights reserved.
//

import UIKit

class MessagesViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var messagesImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // scroll
        scrollView.delegate = self
        scrollView.contentSize = messagesImage.frame.size
        scrollView.sendSubviewToBack(messagesImage)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    


}
