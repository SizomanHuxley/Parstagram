//
//  FeedViewController.swift
//  Parstagram
//
//  Created by Michelob Revol on 9/30/22.
//

import UIKit
import Parse
import AlamofireImage

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    let myRefreshControl = UIRefreshControl()
    
    @IBOutlet weak var tableView: UITableView!
    
    var posts = [PFObject]()
    var numberOfLoad: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.load()
        myRefreshControl.addTarget(self, action: #selector(load), for: .valueChanged)
        tableView.refreshControl = self.myRefreshControl
    }
    
    // override func viewDidAppear(_ animated: Bool) {
    // super.viewDidAppear(animated)
    //}
    
    
    @objc func load(){
        numberOfLoad = 5
        let query = PFQuery(className: "posts")
        query.order(byDescending: "createdAt")
        query.includeKey("owner")
        query.limit = numberOfLoad
        
        query.findObjectsInBackground {(posts, error) in
            if posts != nil{
                self.posts = posts!
                self.tableView.reloadData()
                self.myRefreshControl.endRefreshing()
            }
        }
    }
    
    
    func loadMore(){
        numberOfLoad = numberOfLoad + 5
        let query = PFQuery(className: "posts")
        query.order(byDescending: "createdAt")
        query.includeKey("owner")
        query.limit = numberOfLoad
        query.findObjectsInBackground {(posts, error) in
            if posts != nil{
                self.posts = posts!
                self.tableView.reloadData()
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == posts.count{
            self.loadMore()
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
        let post = posts [indexPath.row]
        let user = post["owner"] as! PFUser
        cell.usernameLabel.text = user.username
        cell.captionLabel.text = post["caption"] as? String
        
        let imageFile = post["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        
        cell.photoView.af.setImage(withURL: url)
        return cell
        
    }
    /*func numberOfSections(in tableView: UITableView) -> Int {
     // #warning Incomplete implementation, return the number of sections
     return 1
     }
     */
}
