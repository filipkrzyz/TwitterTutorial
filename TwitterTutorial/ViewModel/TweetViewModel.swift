//
//  TweetViewModel.swift
//  TwitterTutorial
//
//  Created by Filip Krzyzanowski on 07/09/2020.
//  Copyright © 2020 Filip Krzyzanowski. All rights reserved.
//

import UIKit

struct TweetViewModel {
    
    // MARK: - Properties
    
    let tweet: Tweet
    let user: User
    
    var timestamp: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        let now = Date()
        return formatter.string(from: tweet.timestamp, to: now) ?? ""
    }
    
    var headerTimestamp: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a ・ dd/MM /yyyy"
        return dateFormatter.string(from: tweet.timestamp)
    }
    
    var profileImageUrl: URL? {
        return user.profileImageUrl
    }
    
    var usernameText: String {
        return "@\(user.username)"
    }
    
    var userInfoText: NSAttributedString {
        let attributedString = NSMutableAttributedString(string: user.fullname,
                                                 attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        attributedString.append(NSAttributedString(string: " @\(user.username)",
            attributes: [.font: UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.lightGray]))
        
        attributedString.append(NSAttributedString(string: " ・\(timestamp)",
            attributes: [.font: UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.lightGray]))
        
        return attributedString
    }
    
    var retweetAtributedString: NSAttributedString? {
        return attributedText(value: tweet.retweetsCount, text: "Retweets")
    }
    
    var likesAtributedString: NSAttributedString? {
        return attributedText(value: tweet.likesCount, text: "Likes")
    }
    
    // MARK: - Lifecycle
    
    init(tweet: Tweet) {
        self.tweet = tweet
        self.user = tweet.user
    }
    
    // MARK: - Helpers
    
    fileprivate func attributedText(value: Int, text: String) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: "\(value)", attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        
        attributedString.append(NSAttributedString(string: " \(text)",
            attributes: [.font: UIFont.systemFont(ofSize: 14),
                         .foregroundColor: UIColor.lightGray]))
        
        return attributedString
    }
    
}
