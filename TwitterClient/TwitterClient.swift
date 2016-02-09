//
//  TwitterClient.swift
//  TwitterClient
//
//  Created by Dhiman on 2/9/16.
//  Copyright © 2016 Dhiman. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

let twitterConsumerKey = "Av1aIESkjZpi5Bm49Ja16DXG8"
let twitterConsumerSecret = "okJY0ktditQN1wp0q2Sn72M6JswpaWkZd1DrMWQgyNoHMSngz9"
let twitterBaseURL = NSURL(string: "https://apps.twitter.com")

class TwitterClient: BDBOAuth1SessionManager {
    
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        return Static.instance
    }
}