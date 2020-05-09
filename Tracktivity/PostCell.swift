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
    
    
    @IBOutlet var lbl: UILabel!
    
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
    

    @IBAction func slider(_ sender: UISlider) {
        if(sender.value > 0 && sender.value <= 25){
            sender.value = 25
        }else if(sender.value > 25 && sender.value <= 50){
            sender.value = 50
        }else if(sender.value > 50 && sender.value <= 75){
            sender.value = 75
        }else{
            sender.value = 100
        }
        lbl.text = String(Int(sender.value))
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
