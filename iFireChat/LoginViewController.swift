//
//  LoginViewController.swift
//  iFireChat
//
//  Created by Bansri Rawal on 10/28/20.
//

import Foundation
import UIKit
import Firebase

class LoginViewController: UIViewController{
    
    
    
    @IBOutlet weak var emailText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func LogInPressed(_ sender: UIButton) {
        if let email = emailText.text, let password = passwordText.text{
        
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                if error != nil{
                    print("Error in Authorization")
                }
                else{
//                    let vc = self?.storyboard?.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
//                    vc.modalPresentationStyle = .fullScreen
//                    self?.present(vc, animated: true, completion: nil)
                    self?.performSegue(withIdentifier: K.loginSegue, sender: nil)
                }
          // ...
        }
        }
        
    }
    
}
