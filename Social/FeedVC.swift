//
//  FeedVC.swift
//  Social
//
//  Created by Arnaud Dupuy on 16/09/2016.
//  Copyright © 2016 Arnaud Dupuy. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Firebase

class FeedVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func signOutPressed(_ sender: UIButton) {
        do {
            try FIRAuth.auth()?.signOut()
        } catch {
            print("::> Error trying to sign out with Firebase")
        }
        let keychainResult: Bool = KeychainWrapper.defaultKeychainWrapper().removeObjectForKey(KEY_UID)
        print("::> UID deleted from keychain with result: \(keychainResult)")
        dismiss(animated: true, completion: nil)
    }
}
