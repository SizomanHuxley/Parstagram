//
//  LoginViewController.swift
//  Parstagram
//
//  Created by Michelob Revol on 9/30/22.
//

import UIKit
import Parse
import AlamofireImage

class LoginViewController: UIViewController {

    
    @IBOutlet weak var usenameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after
    }
    

    @IBAction func onSignIn(_ sender: Any) {
        let username = usenameField.text
        let password = passwordField.text
        
        PFUser.logInWithUsername(inBackground: username!, password: password!){
            (user, error) in
            if user != nil {
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
            else {
                print("Error: \(String(describing: error?.localizedDescription)))")
            }
        }
    }
    
    
    @IBAction func onSignup(_ sender: Any) {
        
        let user = PFUser()
        user.username = usenameField.text
        user.password = passwordField.text
        
        user.signUpInBackground {(success, error) in
            if success{
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
            else {
                print("Error: \(String(describing: error?.localizedDescription)))")
            }
    }
        
    }
    // MARK: - Navigation


}
