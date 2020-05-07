//
//  PostDetailsViewController.swift
//  Tracktivity
//
//  Created by Yiheng Cen Feng on 4/27/20.
//  Copyright © 2020 codepath. All rights reserved.
//

import UIKit
import Parse

class PostDetailsViewController: UIViewController {
    
    var post: PFObject?
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let user = post?["author"] as! PFUser
        usernameLabel.text = user.username

        captionLabel.text = post!["caption"] as? String
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
