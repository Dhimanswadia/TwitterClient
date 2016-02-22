//
//  ProfileViewController.swift
//  TwitterClient
//
//  Created by Dhiman on 2/20/16.
//  Copyright © 2016 Dhiman. All rights reserved.
//

import UIKit
class ProfileViewController: UIViewController {
    
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!

    
    var user: User!
    var tweets: [Tweet]!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(user != nil) {
        fullNameLabel.text = user?.name
        usernameLabel.text = "@\(user.screenname!)"
        
        avatarImageView.setImageWithURL(NSURL(string: user.profileImageUrl!)!)
        backgroundImageView.setImageWithURL(NSURL(string: user.backgroundImageUrl!)!)
        
        tweetCountLabel.text = String(user.tweet_count!)
        followingCountLabel.text = String(user.following_count!)
        followersCountLabel.text = String(user.followers_count!)
        
        
        
        // rounded edges on photo
        avatarImageView.layer.cornerRadius = 5
        avatarImageView.clipsToBounds = true
    }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tweets = tweets {
            return tweets.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
        
        cell.tweet = tweets[indexPath.row]
        return cell
    }
    
    var selectedTweet: Tweet!
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        selectedTweet = tweets![indexPath.row]
        
        return indexPath
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let vc = segue.destinationViewController
        if let vc = vc as? DetailViewController {
            vc.tweet = selectedTweet
        }
    }
    
    
}
