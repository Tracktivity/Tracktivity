//
//  PostCell.swift
//  Tracktivity
//
//  Created by Ashraf Khan on 4/25/20.
//  Copyright © 2020 codepath. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    
    @IBOutlet weak var datetimelabel: UILabel!
    
    @IBOutlet weak var resolvebutton: UIButton!
    
    var resolved:Bool = false
    
    func setResolved(_ isResolved:Bool) {
        resolved = isResolved
        if (resolved) {
            resolvebutton.setImage(UIImage(named:"resolved"), for: UIControl.State.normal)
        }
        else {
            resolvebutton.setImage(UIImage(named:"unresolved"), for: UIControl.State.normal)
        }
    }
    
    @IBAction func resolvepost(_ sender: Any) {
        if resolvebutton.backgroundColor == UIColor.black {
            resolvebutton.setImage(UIImage(named:"resolved"), for: UIControl.State.normal)
        } else {
            resolvebutton.setImage(UIImage(named:"unresolved"), for: UIControl.State.normal)
        }
    }
    

    
    @IBOutlet var photoView: UIImageView!
    
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var captionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
