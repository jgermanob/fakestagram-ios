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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    func setupView(){
        authorView.author = post.author
        titleLbl.text = post.title
        likeCounterLbl.text = post.likesCountText()
        guard let post = self.post else { return }
        post.load { [weak self] img in
            self?.postImageView.image = img
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "profileCommentSegue"{
            let commentsViewController = segue.destination as! CommentsViewController
            commentsViewController.post = self.post
            commentsViewController.commentClient = CommentClient(post: self.post!)
            commentsViewController.createComment = CreateCommentClient(post: self.post!)
            //commentsViewController.postOwner.author = self.post?.author
        }
    }
    
    @IBAction func onTapComment(_ sender: UIButton) {
        performSegue(withIdentifier: "profileCommentSegue", sender: self)
    }
    
    @IBAction func onTapPostSettings(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Post options", message: nil, preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { action in
            
        }
        alertController.addAction(deleteAction)
        present(alertController, animated: true, completion: nil)
    }
    
    
}
