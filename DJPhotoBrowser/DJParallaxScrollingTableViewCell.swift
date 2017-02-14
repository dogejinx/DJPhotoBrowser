//
//  DJParallaxScrollingTableViewCell.swift
//  DJPhotoBrowser
//
//  Created by linxian on 2017/2/14.
//  Copyright © 2017年 DogeJinx. All rights reserved.
//

import UIKit

class DJParallaxScrollingTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var exampleLabel: UILabel!
    @IBOutlet weak var numberOfLikeLabel: UILabel!
    @IBOutlet weak var numberOfCommentLabel: UILabel!
    @IBOutlet weak var numberOfRead: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
