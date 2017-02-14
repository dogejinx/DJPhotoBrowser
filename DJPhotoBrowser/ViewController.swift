//
//  ViewController.swift
//  DJPhotoBrowser
//
//  Created by linxian on 2017/2/13.
//  Copyright © 2017年 DogeJinx. All rights reserved.
//

import UIKit


class Artist {
    
    var avatarUrl: String? = nil
    var name: String? = nil
    var publishDate: NSDate? = nil
    var pictureUrl: String? = nil
    var title: String? = nil
    var example: String? = nil
    
    var numberOfLike: Int = 0
    var numberOfComment: Int = 0
    var numberOfRead: Int = 0
    
}


class ViewController: UIViewController {
    
    var tableView: UITableView?
    
    fileprivate lazy var artists: [Artist] = {
        var array = [Artist]()
        for i in 0 ..< 8 {
            let artist = Artist()
            artist.avatarUrl = "http://s.cn.bing.net/th?id=OJ.HqVie0GSVpZDig&w=75&h=75&c=8&pid=MSNJVFeeds"
            artist.name = "空耳"
            artist.publishDate = NSDate()
            artist.pictureUrl = "http://tse2.mm.bing.net/th?id=OIP.7zDsonwG6EP5N8zBIzn_igEsC7&w=284&h=177&c=7&qlt=90&o=4&dpr=1.25&pid=1.7"
            artist.title = "我在东北玩泥巴"
            artist.example = "天哪~~~~恨啊~~~~挨饿~~~~多冷的隆冬,多冷的隆冬,多冷的隆冬,蛋蛋大,多冷啊~我在东北玩泥巴,虽然东北不大,我在大连没有家~"
            artist.numberOfLike = 55
            artist.numberOfComment = 69
            artist.numberOfRead = 4927
            array.append(artist)
        }
        
        return array
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView?.rowHeight = UITableViewAutomaticDimension
        tableView?.estimatedRowHeight = 360
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView?.frame = view.bounds
    }
    
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! DJParallaxScrollingTableViewCell
        let artist = artists[indexPath.row]
        cell.nameLabel.text = artist.name
        cell.dateLabel.text = "12 月 8 日"
        DispatchQueue.global().async {
            if artist.avatarUrl != nil {
                if let url = URL(string: artist.avatarUrl!) {
                    
                    if let data = Data(contentsOf: url) try {
                    
                    } throw {
                        
                    }
                }
            }
        }
        cell.avatarImageView.image = UIImage(data: NSData(contentsOf: NSURL(string: artist.avatarUrl!) as! URL) as Data)
        cell.pictureImageView.image = UIImage(data: NSData(contentsOf: NSURL(string: artist.pictureUrl!) as! URL) as Data)
        cell.titleLabel.text = artist.title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

