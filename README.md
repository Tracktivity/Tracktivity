Group Project

# Tracktivity

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
A platform that allows users to keep track of their to-do activities and share their progress with friends.

### App Evaluation
[Evaluation of your app across the following attributes]
- **Category:** social/lifestyle
- **Mobile:** mobile first experience
- **Story:** Allows users to keep track of their daily activities and keep themselves accountable by sharing their progress with friends. Also allows users to recommend activies to friends and has a quarantine specific tab with features like marking yourself safe or sharing motivational quotes.
- **Market:** Anyone that wants to share how their days have been going with other people and stay connected, especially during this time of quarantine.
- **Habit:** Users can post throughout the day to update their activity and check off their daily tasks/goals. Users can plan out the activities for their day and share with friends.
- **Scope:** Tracktivity started out with functionalities of posting daily goals and activities. Has expanded to a larger scope with added functionalities of a quarantine-specific tab and ability to explore other users' daily life plans.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* [X] sign up 
* [X] sign in/sign out
* [X] to post
* [X] profile page
* [ ] "like" feature
* [X] comment on a post
* [ ] add friend

**Optional Nice-to-have Stories**
* users can se their profile page with their photos
* user can view other user's profiles and see their photo feed

### 2. Screen Archetypes

* Login Screen
   * log in
   * create new account
* Feed Screen
   * users can view activities their friends are planning on doing for the day (to distinguish posts from existing apps like Instagram and Twitter, an activity post consists of an emoji/gif, a description/recipe, and a pie graph (what percentage completed))
   * users can comment on the activity updates 
   * users can "like" a post
* Creation
    * selection of cute gifs/icons to post the new activity update with
* Profile Screen
   * basic information (username,profile picture, etc)
   * friend list
   * [Optional] Also indicates number of activities completed/unfinished (kind of like a Leetcode heatmap)
* Personal Activity Tracker/Log Tab
    * progress bar to indicate progress/completion percentage of activity that will update the activity post in others' feeds
 
   
### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Feed 
* Profile

**Flow Navigation** (Screen to Screen)

* Login Screen -> account creation if no account
   * Feed Screen
* Creation Screen
   * Feed Screen
* Feed Screen
    * None
* Personal Activity Tracker/Log Screen
    * None
* Profile Screen
    * None
    * Personal Activity Tracker/Log (after the initial creation of starting the activity, the user can keep updating their progress in their activity list under their profile)

## Wireframes
<img src="https://github.com/Tracktivity/Tracktivity/blob/master/img.jpg" width=600>


## Schema 

### Models
Model: Post
| Property      | Type           | Description |
| ------------- | ---------------| ------------|
| objectId      | String         | unique id for the user post (default field) |
| author        | Pointer to User| image author |
| image         | File           | image that user posts |
| caption       | String         | image caption by author |
| commentsCount | Number         | number of comments that has been posted to an image |
| likesCount    | Number         | number of likes for the post |
| createdAt     | DateTime       | date when post is created (default field) |
| updatedAt     | DateTime       | date when post is last updated (default field) |
| Taskcolor     | String         | unique color for a given task |
| TypeActivity  | String         | category of activity  | 
| Status        | String         | whether user has marked themself safe during covid-19 crisis  |
| ProgressBar   | Number         | percentage of completion of the task  | 



### Networking
#### List of network requests by screen
   - Login Screen(Sign up or Sign In)
      - (Create/POST) create a user account
      ```swift
          func myMethod() {
          var user = PFUser()
          user.username = "myUsername"
          user.password = "myPassword"
    
          user.signUpInBackgroundWithBlock {
            (succeeded: Bool, error: NSError?) -> Void in
            if let error = error {
              let errorString = error.userInfo["error"] as? NSString
              // Show the errorString somewhere and let the user try again.
              } else {
              // Hooray! Let them use the app now.
              }
            }
          }
      ```
      
 - (Read/GET) Query username and password for verification purpose
      ```swift
        var user = PFUser()
        user.username = usernameField.text // make outlets to the text fields before
        user.password = passwordField.text

        user.signUpInBackgroundWithBlock {
        (succeeded: Bool, error: NSError?) -> Void in
        if let error = error {
          let errorString = error.userInfo["error"] as? NSString
          // Show the errorString somewhere and let the user try again.
        } else {
          // Hooray! Let them use the app now.
        }
        }
      
          PFUser.logInWithUsernameInBackground(usernameField.text, passwordField.text) {
           (usernameField.text: PFUser?, error: NSError?) -> Void in
           if user != nil {
            // Do stuff after successful login.
           } else {
            // The login failed. Check error to see why.
           }
          }
    ```
        
   
 - Main Screen(Feed Screen)
      - (Read/GET) Query all posts where user is author or in author's friend list
        ```swift
         let query = PFQuery(className:"Post")
         query.whereKey("author", equalTo: currentUser)
         query.order(byDescending: "createdAt")
         query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
            if let error = error { 
               print(error.localizedDescription)
            } else if let posts = posts {
               print("Successfully retrieved \(posts.count) posts.")
           // TODO: Do something with posts...
            }
         }
         ```
      - (Create/POST) Create a new post object and save it
      ```swift
        let post = PFObject(className:"Post")
        post["activitytype"] = "..."
        post["text"] = "..."
        post["author"] = PFUser.current()!
        post.saveInBackground { (succeeded, error)  in
            if (succeeded) {
                // The object has been saved.
            } else {
                // There was a problem, check error.description
            }
        }
      ```
      - (Create/POST) Create a new like on a post
      ```swift
        let post = PFObject(className:"Post")
        post["like"] = true
        post["likeCounts"]++;
        post.saveInBackground { (succeeded, error)  in
            if (succeeded) {
                // The object has been liked.
            } else {
                post["like"] = false;
                // There was a problem, check error.description
            }
        }
      ```
      - (Delete) Delete existing like
      ```
      PFObject.deleteAll(inBackground: objectArray) { (succeeded, error) in
            if (succeeded) {
                // The array of objects was successfully deleted.
            } else {
                // There was an error. Check the errors localizedDescription.
            }
        }
      ```
      - (Create/POST) Create a new comment on a post
      ```
        let comment = PFObject(className: "Comments")
        comment["text"] = text
        comment["post"] = selectedPost
        comment["author"] = PFUser.current()!

        selectedPost.add(comment, forKey: "comments")

        selectedPost.saveInBackground { (success, error) in
           if success {
               print("Comment saved")
           } else {
               print("Error saving comment")
           }
        }
      ```
      - (Delete) Delete existing comment
      ```
        PFObject.deleteAll(inBackground: objectArray) { (succeeded, error) in
            if (succeeded) {
                // The array of objects was successfully deleted.
            } else {
                // There was an error. Check the errors localizedDescription.
            }
        }

      ```  
            
   - Profile Screen
      - (Read/GET) Query logged in user object
      ```swift
        let query = PFQuery(className:"User")
        query.getObjectInBackground(withId: "xWMyZEGZ") { (user, error) in
            if error == nil {
                // Success!
                let userStatus = user["status"]
                let profileImage = user["image"]
                let username = user["username"]
                ...
            } else {
                // Fail!
            }
         }
        ```
      - (Update/PUT) Update user profile image
      ```swift
        let query = PFQuery(className:"user")
        query.getObjectInBackground(withId: "xWMyZEGZ") { (user: PFObject?, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            } else if let user = user{
                user["image"] = image
                user.saveInBackground()
            }
        }
        ```
      - (Update/PUT) Update user status
      ```swift
        let query = PFQuery(className:"user")
        query.getObjectInBackground(withId: "xWMyZEGZ") { (user: PFObject?, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            } else if let user = user{
                user["userStatus"] = "..."
                user.saveInBackground()
            }
        }
        ```
   - Activity Log/Tracker Screen
       - (Search Post Screen) 
      ``` // larger query for getting all the posts where the user is equal to currentUser
          // create new class to define userposts
      var currentUser = PFUser.currentUser()
      let userquery = PFQuery(className:"Post")
        query.whereKey("user", equalTo:currentUser)
      ``` 
       
      - (Update) Update the progress bar attribute value
      ``` //"subqueries" within the query of matching user
          let post = PFObject(className:"UserPost")
          post[progress] += 25
          post.saveInBackground { (succeeded, error)  in
            if (succeeded) {
                print("progress bar updated")
            } else {
                print("error updating progress bar")
            }
        }
      ```
      - (Read/GET) Query existing activities by progress bar completion
            
       ``` 
           let query = PFQuery(className:"UserPost")
            query.whereKey("progress", equalTo:100)
            query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
                if let error = error {
                    // Log details of the failure
                    print(error.localizedDescription)
                } else if let objects = objects {
                    // The find succeeded.
                    print("Successfully retrieved \(objects.count) activities.")
                    // Do something with the found objects
                    for object in objects {
                        print(object.objectId as Any) // print all the attributes of each post
                    }
                }
            }
        ```
       - (Read/GET) Query all posts of a specific activity type
       ```   
          let query = PFQuery(className:"Post")
            query.whereKey("activitytype", equalTo:"...")
            query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
                if let error = error {
                    // Log details of the failure
                    print(error.localizedDescription)
                } else if let objects = objects {
                    // The find succeeded.
                    print("Successfully retrieved \(objects.count) activities.")
                    // Do something with the found objects
                    for object in objects {
                        print(object.objectId as Any) // print all the attributes of each post
                    }
                }
            }
        ```
### App Walkthrough GIF

<img src="http://g.recordit.co/EroWP7jVIF.gif" width=250><br>
<img src="http://g.recordit.co/G175PbXm1y.gif" width=250><br>
<img src="http://g.recordit.co/3K66AFCHmi.gif" width=250><br>
<img src="http://g.recordit.co/sIoMdrGHpG.gif" width=250><br>

