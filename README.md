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

* sign up
* sign in/sign out
* to post
* "like" feature
* comment on a post
* add friend


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


