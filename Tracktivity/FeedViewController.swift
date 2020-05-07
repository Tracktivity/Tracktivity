//
//  FeedViewController.swift
//  Tracktivity
//
//  Created by Yiheng Cen Feng on 4/19/20.
//  Copyright © 2020 codepath. All rights reserved.
//

import UIKit
import Parse
//import AlamofireImage
import MessageInputBar

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MessageInputBarDelegate {
  
    @IBOutlet var tableView: UITableView!
    
    let commentBar = MessageInputBar()
    var showsCommentBar = false
    var posts = [PFObject]()
    var selectedPost: PFObject!
    var postButtom = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commentBar.inputTextView.placeholder = "Type here..."
        commentBar.sendButton.title = "Post"
        commentBar.delegate = self

        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.keyboardDismissMode = .interactive
        // Do any additional setup after loading the view.
        
        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(keyboardWillBeHidden(note:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillBeHidden(note: Notification) {
        commentBar.inputTextView.text = nil
        showsCommentBar = false
        becomeFirstResponder()
    }
    
    override var inputAccessoryView: UIView? {
        return commentBar
    }
    
    override var canBecomeFirstResponder: Bool {
        return showsCommentBar
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className: "Posts")
        query.includeKeys(["author", "comments", "comments.author"])
        query.limit = 20
        
        query.findObjectsInBackground { (posts, error) in
            if posts != nil {
                self.posts = posts!
                self.tableView.reloadData()
            }
        }
    }
    
    func messageInputBar(_ inputBar: MessageInputBar, didPressSendButtonWith text: String) {
        // Create the comment
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        
        if(postButtom == true) {
            let post = PFObject(className: "Posts")
            
            post["caption"] = text
            post["author"] = PFUser.current()
    
            post["dateTime"] = formatter.string(from: Date())
            
            post.saveInBackground { (success, error) in
                if success {
                    self.postButtom = false
                    print("Saved!")
                }else{
                    print("error!")
                }
            }
            tableView.reloadData()
            self.viewDidAppear(true)
        } else {
            let comment = PFObject(className: "Comments")
            comment["text"] = text
            comment["post"] = selectedPost
            comment["author"] = PFUser.current()!
            
            comment["dateTime"] = formatter.string(from: Date())

            selectedPost.add(comment, forKey: "comments")

            selectedPost.saveInBackground { (success, error) in
                if success {
                    print("Comment saved")
                } else {
                    print("Error saving comment")
                }
            }

            tableView.reloadData()
        }

        // Clear and dismiss the input bar
        commentBar.inputTextView.text = nil

        showsCommentBar = false
        becomeFirstResponder()
        commentBar.inputTextView.resignFirstResponder()
    }
    
    @IBAction func logout(_ sender: Any) {
        PFUser.logOut()
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(withIdentifier: "LoginViewController")
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        
        delegate.window?.rootViewController = loginViewController
    }
    
    
   
    @IBAction func onPostButton(_ sender: Any) {
        postButtom = true
        showsCommentBar = true
        becomeFirstResponder()
        commentBar.inputTextView.becomeFirstResponder()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let post = posts[section]
        let comments = (post["comments"] as? [PFObject]) ?? []
        return comments.count + 2
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = posts[indexPath.section]
        let comments = (post["comments"] as? [PFObject]) ?? []
        
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
            
            let user = post["author"] as! PFUser
            cell.usernameLabel.text = user.username
            
            cell.captionLabel.text = post["caption"] as! String
            cell.datetimelabel.text = post["dateTime"] as! String
            
            return cell
        } else if indexPath.row <= comments.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell") as! CommentCell
            
            let comment = comments[indexPath.row - 1]
            cell.commentLabel.text = comment["text"] as? String
            
            cell.datetimeLabel.text = comment["dateTime"] as! String
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddCommentCell")!
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = posts[indexPath.section]
        let comments = (post["comments"] as? [PFObject]) ?? []
        
        if indexPath.row == comments.count + 1 {
            showsCommentBar = true
            becomeFirstResponder()
            commentBar.inputTextView.becomeFirstResponder()
            
            selectedPost = post
        }
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if segue.identifier == "PostDetails" {
           // Find the selected post
           let cell = sender as! UITableViewCell
           let indexPath = tableView.indexPath(for: cell)!
           let post = posts[indexPath.section]
           
           // Pass the selected post to the datails view controller
           let detailsViewController = segue.destination as! PostDetailsViewController
           detailsViewController.post = post
           
           tableView.deselectRow(at: indexPath, animated: true)
       } 
    }


}
