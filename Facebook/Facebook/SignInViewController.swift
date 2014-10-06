//
//  SignInViewController.swift
//  Facebook
//
//  Created by David Bellona on 10/5/14.
//  Copyright (c) 2014 David Bellona. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    
    // set components
    @IBOutlet weak var facebookImage: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var formBgImage: UIImageView!
    @IBOutlet weak var loadingActivityView: UIActivityIndicatorView!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // keyboard
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // delay
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    
    func keyboardWillShow(notification: NSNotification!) {
        var userInfo = notification.userInfo!
        // Get the keyboard height and width from the notification
        // Size varies depending on OS, language, orientation
        var kbSize = (userInfo[UIKeyboardFrameEndUserInfoKey] as NSValue).CGRectValue().size
        var durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey] as NSNumber
        var animationDuration = durationValue.doubleValue
        var curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey] as NSNumber
        var animationCurve = curveValue.integerValue
        
        UIView.animateWithDuration(animationDuration, delay: 0.0, options: UIViewAnimationOptions.fromRaw(UInt(animationCurve << 16))!, animations: {
            self.facebookImage.frame.origin.y = 65
            self.formBgImage.frame.origin.y = 140
            self.emailTextField.frame.origin.y = 146
            self.passwordTextField.frame.origin.y = 191
            self.loginButton.frame.origin.y = 250
            self.loadingActivityView.frame.origin.y = 266
            }, completion: nil)
    }
    
    func keyboardWillHide(notification: NSNotification!) {
        var userInfo = notification.userInfo!
        // Get the keyboard height and width from the notification
        // Size varies depending on OS, language, orientation
        var kbSize = (userInfo[UIKeyboardFrameEndUserInfoKey] as NSValue).CGRectValue().size
        var durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey] as NSNumber
        var animationDuration = durationValue.doubleValue
        var curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey] as NSNumber
        var animationCurve = curveValue.integerValue
        
        UIView.animateWithDuration(animationDuration, delay: 0.0, options: UIViewAnimationOptions.fromRaw(UInt(animationCurve << 16))!, animations: {
            self.facebookImage.frame.origin.y = 80
            self.formBgImage.frame.origin.y = 180
            self.emailTextField.frame.origin.y = 186
            self.passwordTextField.frame.origin.y = 231
            self.loginButton.frame.origin.y = 290
            self.loadingActivityView.frame.origin.y = 306
            
            }, completion: nil)
    }
    
    @IBAction func onTapLoginButton(sender: UIButton) {
        loginButton.selected = true
        
        loadingActivityView.startAnimating()
        delay(1, closure: { () -> () in
            
            if(self.emailTextField.text == "me") && (self.passwordTextField.text == "pass") {
                self.emailTextField.text = ""
                self.passwordTextField.text = ""
                self.performSegueWithIdentifier("loginSegue", sender: self)
            } else {
                UIAlertView(title: "Whoops!", message: "Your email or password is incorrect", delegate: nil, cancelButtonTitle: "Try again").show()
            }
            self.loadingActivityView.stopAnimating()
            self.loginButton.selected = false
            }
        )
    }
    
    
    @IBAction func onTap(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }


    
}
