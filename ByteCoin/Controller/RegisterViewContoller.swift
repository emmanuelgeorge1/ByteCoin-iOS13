//
//  RegisterViewContoller.swift
//  ByteCoin
//
//  Created by Emmanuel George on 28/08/22.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor.black
    }
    
    @IBAction func registerPressed(_ sender: UIButton) {
        if let email  = emailTextfield.text, let password = passwordTextfield.text{
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let err = error {
                    self.displayAlert(withTitle: "Error", message: error!.localizedDescription)
                    print(err)
                }else{
                    //Navigate to the ChatViewController
                    self.performSegue(withIdentifier: "registerToDashboard", sender: self)
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
