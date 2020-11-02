//
//  RegisterViewController.swift
//  iFireChat
//
//  Created by Bansri Rawal on 10/28/20.
//

import Foundation
import UIKit
import Firebase

class RegisterViewController: UIViewController{

    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    
    @IBOutlet weak var registerButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func registerPressed(_ sender: UIButton) {
        
        if let email = emailText.text, let password = passwordText.text{
            
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if error != nil{
                    print("Firebase Authorization")
                }
                else{
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
                    vc.modalPresentationStyle = .overFullScreen
                    self.present(vc, animated: true, completion: nil)
                    
                }
            }
        }
        
        
        
    }
    


}
