//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by Alicia Isler on 9/24/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell
{
    
    @IBOutlet weak var retweetButton: UIButton!
    
    @IBOutlet weak var favbutton: UIButton!
    
    
    @IBAction func retweet(_ sender: Any) {
        TwitterAPICaller.client?.retweet(tweetId: tweetId, success: {
            self.setRetweeted(isRetweeted: true)
        }) { (error) in
            print("Error is retweeting \(error)")
        }
    }
    
    
    var favorited:Bool = false
    var tweetId:Int = -1
    
    @IBAction func favoriteTweet(_ sender: Any) {
        let toBeFavorited = !favorited
        if (toBeFavorited) {
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(isFavorited: true)
            }, failure: { (error) in
                print("Favorite did not succeed: \(error)")
                
            })
        } else {
            TwitterAPICaller.client?.unfavoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(isFavorited: false)
            }, failure: { (error) in
                print("Unfavorite did not succeed: \(error)")
                
            })
        }
        
        
    }
    
    
    func setFavorite( isFavorited:Bool){
        favorited = isFavorited
        if (favorited) {
            favbutton.setImage(UIImage(named:"favor-icon-red"), for: UIControl.State.normal)
        }
        else {
            favbutton.setImage(UIImage(named: "favor-icon"), for: UIControl.State.normal)
        }
    }
    
    func setRetweeted( isRetweeted:Bool){
        if (isRetweeted) {
            retweetButton?.setImage(UIImage(named:"retweet-icon-green"), for: UIControl.State.normal)
            retweetButton?.isEnabled = false
        }
        else {
            retweetButton?.setImage(UIImage(named:"retweet-icon"), for: UIControl.State.normal)
            retweetButton?.isEnabled = true
        }
    }
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
