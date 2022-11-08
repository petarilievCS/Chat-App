//
//  SceneDelegate.swift
//  Flash Chat iOS13
//
//  Created by Petar Iliev on 07/11/2022.
//  Copyright © 2022 Petar Iliev. All rights reserved.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBAction func registerPressed(_ sender: UIButton) {
        if let email = emailTextfield.text, let password = passwordTextfield.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if error != nil {
                    print(error!.localizedDescription)
                } else {
                    // registration successful
                    self.performSegue(withIdentifier: "registerToChat", sender: self)
                }
            }
        }
    }
    
}
