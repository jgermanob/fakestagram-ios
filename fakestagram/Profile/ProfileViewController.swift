//
//  ProfileViewController.swift
//  fakestagram
//
//  Created by LuisE on 4/23/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    var post : Post?
    @IBOutlet weak var profileCollectionView: UICollectionView!
    private let reuseIdentifier = "postThumbnailCell"
    @IBOutlet weak var authorView: PostAuthorView!
    let client = ProfileClient()
    var posts: [Post] = [] {
        didSet { profileCollectionView.reloadData() }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
       authorView.author = loadProfileInfo()
        getProfilePosts()
        profileCollectionView.delegate = self
        profileCollectionView.dataSource = self
        navigationItem.title = authorView.author?.name
        // Do any additional setup after loading the view, typically from a nib.
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: screenWidth/3, height: screenWidth/3)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        profileCollectionView.collectionViewLayout = layout
    }
    
    func loadProfileInfo() -> Author{
        let account = AccountRepo().load()
        let author = Author(id: (account?.id)!, name: (account?.name)!)
        return author
    }
    
    func getProfilePosts(){
        //print("getProfilePosts()")
        client.show { [weak self] data in
            self?.posts = data
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "postDetailSegue"{
            let postDetailViewController = segue.destination as! PostDetailViewController
            postDetailViewController.authorView = self.authorView
            postDetailViewController.post = self.post!
            
        }
    }
}


extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ProfileCollectionViewCell
        cell.post = posts[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        post = posts[indexPath.row]
        performSegue(withIdentifier: "postDetailSegue", sender: self)
    }
    /*func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: CGFloat((collectionView.frame.size.width / 3) - 20), height: CGFloat(100))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }*/
    
}
