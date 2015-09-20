//
//  ProfileViewController.swift
//  HTN_Motion
//
//  Created by Kashish Goel on 2015-09-19.
//  Copyright (c) 2015 Kashish Goel. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit


class ProfileViewController: UIViewController,FBSDKLoginButtonDelegate {

   // @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var fbLoginButton: FBSDKLoginButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.fbLoginButton.delegate = self
        self.fbLoginButton.readPermissions = ["public_profile"]
        self.fbLoginButton.publishPermissions = ["publish_actions"]
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "fbProfileChanged:",
            name: FBSDKProfileDidChangeNotification,
            object: nil)
        FBSDKProfile.enableUpdatesOnAccessTokenChange(true)
        
        // If we have a current Facebook access token, force the profile change handler
        if ((FBSDKAccessToken.currentAccessToken()) != nil)
        {
            self.fbProfileChanged(self)
        } }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    

    //facebooks functions
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        if (error != nil)
        {
            println( "\(error.localizedDescription)" )
        }
        else if (result.isCancelled)
        {
            // Logged out?
            println( "Login Cancelled")
        }
        else
        {
            // Logged in?
            println( "Logged in, segue now")
            self.performSegueWithIdentifier("showHome", sender: self)
        }
    }
    
    
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        
    }
    
    
    //see bitfountain
    func fbProfileChanged(sender: AnyObject!) {
        
        let fbProfile = FBSDKProfile.currentProfile()
        if (fbProfile != nil)
        {
            // Fetch & format the profile picture
            let strProfilePicURL = fbProfile.imagePathForPictureMode(FBSDKProfilePictureMode.Square, size: imageView.frame.size)
            let url = NSURL(string: strProfilePicURL, relativeToURL: NSURL(string: "http://graph.facebook.com/"))
            let imageData = NSData(contentsOfURL: url!)
            let image = UIImage(data: imageData!)
            
            self.nameLabel.text = fbProfile.name
            self.imageView.image = image
            
            self.nameLabel.hidden = false
            self.imageView.hidden = false
            self.nextButton.hidden = false
        }
        else
        {
            self.nameLabel.text = ""
            self.imageView.image = UIImage(named: "")
            
            self.nameLabel.hidden = true
            self.imageView.hidden = true
        }
    }
    
    
    
    @IBAction func nextButtonPressed(sender: UIButton) {
    self.performSegueWithIdentifier("showHome", sender: self)
    }


}
