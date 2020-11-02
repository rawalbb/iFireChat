//
//  ViewController.swift
//  iFireChat
//
//  Created by Bansri Rawal on 10/28/20.
//

import UIKit
import CLTypingLabel

class WelcomeViewController: UIViewController {

    
    @IBOutlet weak var appTitle: CLTypingLabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        appTitle.text = K.appName
    }


}

