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
import SwiftKeychainWrapper

class SignInVC: UIViewController {

    @IBOutlet weak var emailField: RoundTextField!
    @IBOutlet weak var passwordField: RoundTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let uid = KeychainWrapper.defaultKeychainWrapper().stringForKey(KEY_UID) {
            print("::> Retrieve uid from keychain")
            performSegue(withIdentifier: "toFeedSegue", sender: nil)
        }
        
    }
    
    @IBAction func signInTapped(_ sender: UIButton) {
        if let email = emailField.text, let pwd = passwordField.text {
            FIRAuth.auth()?.signIn(withEmail: email, password: pwd, completion: { (user, error) in
                if error == nil {
                    print("::> User Email/password authenticate with Firebase")
                    self.completeSignIn(uid: user?.uid)
                } else {
                    FIRAuth.auth()?.createUser(withEmail: email, password: pwd, completion: { (user, error) in
                        if error != nil {
                            print("::> Couldn't create user Email/password with Firebase - \(error)")
                        } else {
                            print("::> User Email/password created and authenticated with Firebase")
                            self.completeSignIn(uid: user?.uid)
                        }
                    })
                }
            })
        }
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
                self.completeSignIn(uid: user?.uid)
            }
        })
    }
    
    func completeSignIn(uid: String?) {
        if let uid = uid {
            let keychainResult = KeychainWrapper.defaultKeychainWrapper().setString(uid, forKey: KEY_UID)
            print("::> Keychain saved with result \(keychainResult)")
            performSegue(withIdentifier: "toFeedSegue", sender: nil)
        }
    }
}

