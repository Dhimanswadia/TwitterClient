//
//  Tweet.swift
//  TwitterClient
//
//  Created by Dhiman on 2/14/16.
//  Copyright © 2016 Dhiman. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var user: User?
    var text: String?
    var createdAtString: String?
    var createdAt: NSDate?
    var id: Int!
    var favorited: Bool!
    var retweetCount: Int!
    var retweeted: Bool!
    var favoriteCount: Int!
    
    init(dictionary: NSDictionary) {
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        text = dictionary["text"] as? String
        createdAtString = dictionary["created_at"] as? String
        id = dictionary["id"] as! Int
        
        let formatter = NSDateFormatter() // expensive
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        createdAt = formatter.dateFromString(createdAtString!)
        // use lazy when you need the variable
        
        favorited = (dictionary["favorited"] as? Bool)!
        retweetCount = dictionary["retweet_count"] as? Int
        retweeted = (dictionary["retweeted"] as? Bool?)!
        favoriteCount = dictionary["favorite_count"] as? Int
    }
    
    class func tweetsWithArray(array: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in array {
            tweets.append(Tweet(dictionary: dictionary))
        }
        return tweets
    }
}
