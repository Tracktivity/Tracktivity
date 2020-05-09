//
//  ProfileViewController.swift
//  Tracktivity
//
//  Created by Yiheng Cen Feng on 4/27/20.
//  Copyright © 2020 codepath. All rights reserved.
//

import UIKit
import Parse

class ProfileViewController: UIViewController {
    var postArray: [PFObject]?
    
    

    @IBOutlet var dataTimeLabel: UILabel!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    
    @IBOutlet var captionLabel: UILabel!
    @IBOutlet var profileview: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let user = PFUser.current()
        usernameLabel.text = user!.username

        let post = postArray![0]
        captionLabel.text = post["caption"] as? String
        
        dataTimeLabel.text = post["dateTime"] as? String
        
        
        //profileview.setGradientBackground(colorOne: Colors.white, colorTwo: Colors.green, colorThree: Colors.blue, colorFour: Colors.green)
       
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
