//
//  ViewController.swift
//  Social
//
//  Created by Arnaud Dupuy on 14/09/2016.
//  Copyright © 2016 Arnaud Dupuy. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase

class SignInVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func facebookButtonTapped(_ sender: UIButton) {
        let facebookLogin = FBSDKLoginManager()
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil {
                print("::> Unable to authenticate with Facebook - \(error)")
            } else if result?.isCancelled == true {
                print("::> User cancel Facebook authentication")
            } else {
                print("::> Successfully authenticated with Facebook")
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential)
            }
        }
    }
    
    func firebaseAuth(_ credential: FIRAuthCredential) {
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if error != nil {
                print("::> Unable to authenticate with Firebase - \(error)")
            } else {
                print("::> Successfully authenticated with Firebase")
            }
        })
    }
}

