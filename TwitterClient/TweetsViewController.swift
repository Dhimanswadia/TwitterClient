//
//  TweetsViewController.swift
//  TwitterClient
//
//  Created by Dhiman on 2/14/16.
//  Copyright © 2016 Dhiman. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var OnlogOut: UIButton!
    var tweets: [Tweet]?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
              self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        
        TwitterClient.sharedInstance.homeTimelineWithParams(nil) { (tweets, error) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
        cell.tweet = tweets![indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tweets = tweets {
            return tweets.count
        }
        
        return 0
    }
    
    @IBAction func onLogout(sender: AnyObject) {
        User.currentUser?.logout()
        
    }
    
    var selectedTweet: Tweet!
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        selectedTweet = tweets![indexPath.row]
        
        return indexPath
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    @IBAction func onAvatarImagePress(sender: AnyObject) {
        let button = sender as! UIButton
        let view = button.superview!
       let cell = view.superview as! TweetCell
        let indexPath = tableView.indexPathForCell(cell)
        selectedTweet = tweets![indexPath!.row]
   }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        print("second")
        
        let dc = segue.destinationViewController
        
        if let dc = dc as? DetailViewController {
            dc.tweet = selectedTweet
        }
            
        else if let dc = dc as? CreateViewController {
            dc.user = User.currentUser
        }
            
      else if let dc = dc as? ProfileViewController {
          dc.user = selectedTweet.user
        }
       
        
   }


}
