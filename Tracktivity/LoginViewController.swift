//
//  LoginViewController.swift
//  Tracktivity
//
//  Created by Yiheng Cen Feng on 4/18/20.
//  Copyright © 2020 codepath. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var icon: UIImageView!
    
    @IBAction func signup(_ sender: Any) {
        let user = PFUser()
        user.username = username.text
        user.password = password.text

        user.signUpInBackground { (success, error) in
           if success {
               self.performSegue(withIdentifier: "loginSegue", sender: nil)
           } else {
               print("Error: \(error?.localizedDescription)")
           }
        }
    }
    
    @IBAction func login(_ sender: Any) {
        let usernameval = username.text!
        let passwordval = password.text!

        PFUser.logInWithUsername(inBackground: usernameval, password: passwordval) { (user, error) in
            if user != nil {
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else {
                print("Error: \(error?.localizedDescription)")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.setGradientBackground(colorOne: Colors.white, colorTwo: Colors.green, colorThree: Colors.blue, colorFour: Colors.purple)
        
        icon.layer.cornerRadius = icon.frame.size.height/2
        icon.clipsToBounds = true
        icon.clipsToBounds = true
        icon.contentMode = .scaleAspectFill
    }
    
}
