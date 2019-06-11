//
//  PostDetailViewController.swift
//  fakestagram
//
//  Created by LuisE on 3/16/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import UIKit

class PostDetailViewController: UIViewController {
    public var post: Post!

    @IBOutlet weak var authorView: PostAuthorView!
    @IBOutlet weak var imgView: UIScrollView!
    @IBOutlet weak var titleLbl: UITextView!
    @IBOutlet weak var likeCounterLbl: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    
    override func loadView() {
        Bundle.main.loadNibNamed("PostDetailViewController", owner: self, options: nil)
        authorView.author = post.author
        titleLbl.text = post.title
        likeCounterLbl.text = post.likesCountText()
        guard let post = self.post else { return }
        post.load { [weak self] img in
            self?.postImageView.image = img
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print(authorView.author?.name)
    }

    func setupView(){
        
    }

}
