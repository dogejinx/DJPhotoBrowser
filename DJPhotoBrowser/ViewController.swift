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
    
    var tableView: UITableView!
    var task: URLSessionDownloadTask!
    var session: URLSession!
    var cache: NSCache<AnyObject, AnyObject>!
    
    fileprivate lazy var artists: [Artist] = {
        var array = [Artist]()
        for i in 0 ..< 8 {
            let artist = Artist()
            artist.avatarUrl = "http://s.cn.bing.net/th?id=OJ.HqVie0GSVpZDig&w=75&h=75&c=8&pid=MSNJVFeeds"
            artist.name = "空耳"
            artist.publishDate = NSDate()
            artist.pictureUrl = "http://tse2.mm.bing.net/th?id=OIP.7zDsonwG6EP5N8zBIzn_igEsC7&w=284&h=177&c=7&qlt=90&o=4&dpr=1.25&pid=1.7"
            artist.title = "我在东北玩泥巴"
            artist.example = "天哪~~~~恨啊~~~~挨饿~~~~多冷的隆冬,多冷的隆冬,多冷的隆冬,蛋蛋大,多冷啊~我在东北玩泥巴,虽然东北不大,我在大连没有家~多冷啊~我在东北玩泥巴,虽然东北不大,我在大连没有家~多冷啊~我在东北玩泥巴,虽然东北不大,我在大连没有家~多冷啊~我在东北玩泥巴,虽然东北不大,我在大连没有家~"
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
        
        session = URLSession.shared
        task = URLSessionDownloadTask()
        
        tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.contentInset = UIEdgeInsets.zero
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 360
        view.addSubview(tableView)
        tableView.register(UINib.init(nibName: "DJParallaxScrollingTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        cache = NSCache()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView?.frame = CGRect.init(x: 0, y: 20, width: view.bounds.width, height: view.bounds.height - 20)
        tableView.reloadData()
    }
    
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! DJParallaxScrollingTableViewCell
        let artist = artists[indexPath.row]
        if artist.name != nil {
            cell.nameLabel.text = artist.name
        }
        
        cell.dateLabel.text = "12 月 8 日"
        
        if let artworkUrl = artist.avatarUrl {
            if (self.cache.object(forKey: artworkUrl as AnyObject) != nil) {
                // 2
                // Use cache
                cell.avatarImageView.image = self.cache.object(forKey: artworkUrl as AnyObject) as? UIImage
            } else {
                // 3
                let url:URL! = URL(string: artworkUrl)
                task = session.downloadTask(with: url, completionHandler: { (location, response, error) -> Void in
                    if let data = try? Data(contentsOf: url){
                        // 4
                        DispatchQueue.main.async(execute: { () -> Void in
                            // 5
                            // Before we assign the image, check whether the current cell is visible
                            if let updateCell = tableView.cellForRow(at: indexPath) as? DJParallaxScrollingTableViewCell {
                                let img:UIImage! = UIImage(data: data)
                                updateCell.avatarImageView.image = img
                                self.cache.setObject(img, forKey: artworkUrl as AnyObject)
                            }
                        })
                    }
                })
                task.resume()
            }
        }
        
        if let artworkUrl = artist.pictureUrl {
            if (self.cache.object(forKey: artworkUrl as AnyObject) != nil) {
                // 2
                // Use cache
                if let img = self.cache.object(forKey: artworkUrl as AnyObject) as? UIImage {
                    cell.pictureImageView.image = img
                }
            } else {
                // 3
                let url:URL! = URL(string: artworkUrl)
                task = session.downloadTask(with: url, completionHandler: { (location, response, error) -> Void in
                    if let data = try? Data(contentsOf: url){
                        // 4
                        DispatchQueue.main.async(execute: { () -> Void in
                            // 5
                            // Before we assign the image, check whether the current cell is visible
                            if let updateCell = tableView.cellForRow(at: indexPath) as? DJParallaxScrollingTableViewCell {
                                let img:UIImage! = UIImage(data: data)
                                updateCell.pictureImageView.image = img
                                self.cache.setObject(img, forKey: artworkUrl as AnyObject)
                            }
                        })
                    }
                })
                task.resume()
            }
        }
        
        
        if artist.title != nil {
            cell.titleLabel.text = artist.title
        }
        
        if artist.example != nil {
            cell.exampleLabel.text = artist.example
        }
        
        cell.numberOfLikeLabel.text = "56"
        cell.numberOfCommentLabel.text = "93"
        cell.numberOfRead.text = "3002 阅读"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        for object in self.tableView.visibleCells {
            // 取出imageView和imageView的父视图
            if let cell = object as? DJParallaxScrollingTableViewCell {
                let rect = cell.pictureBackground.convert(cell.pictureBackground.bounds, to: nil)

                let delta = (cell.pictureImageView.bounds.height - cell.pictureBackground.bounds.height)
                var y = -(rect.origin.y)
                y *= 0.2
                if y > 0 {
                    y = 0
                }
                
                if y < -delta {
                    y = -delta
                }
                
                cell.pictureImageView.frame.origin.y = y

            }
        }
    }
}

