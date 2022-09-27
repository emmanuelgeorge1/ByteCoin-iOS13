//
//  LoginViewContoller.swift
//  ByteCoin
//
//  Created by Emmanuel George on 28/08/22.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import UIKit
import Firebase
class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
    @IBAction func loginPressed(_ sender: UIButton) {
        
        if let email = emailTextfield.text, let password = passwordTextfield.text{
            Auth.auth().signIn(withEmail: email, password: password) {authResult, error in
                if let err = error{
                    print(err)
                    self.displayAlert(withTitle: "Error", message: error!.localizedDescription)
                }else{
                    self.performSegue(withIdentifier: "loginToDashboard", sender: self)
                }
           
            }
        }
        
    }
    func displayAlert(withTitle title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
}
