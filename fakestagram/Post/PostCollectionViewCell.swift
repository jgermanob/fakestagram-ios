//
//  PostCollectionViewCell.swift
//  fakestagram
//
//  Created by LuisE on 3/16/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import UIKit

class PostCollectionViewCell: UICollectionViewCell {
    var delegate: CommentButtonDelegate?
    static let reuseIdentifier = "postViewCell"
    public var row: Int = -1
    public var post: Post? {
        didSet { updateView() }
    }

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var authorView: PostAuthorView!
    @IBOutlet weak var titleLbl: UITextView!
    @IBOutlet weak var likesCountLbl: UILabel!
    @IBOutlet weak var commentsCountLbl: UILabel!
    @IBOutlet weak var likeBtn: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        updateView()
    }

    private func updateView() {
        guard let post = self.post else { return }
        post.load { [weak self] img in
            self?.imageView.image = img
        }
        authorView.author = post.author
        titleLbl.text = post.title
        likesCountLbl.text = post.likesCountText()
        commentsCountLbl.text = post.commentsCountText()
    }

    @IBAction func tapLike(_ sender: Any) {
        guard let post = post else { return }
        let client = LikeUpdaterClient(post: post, row: row)
        self.post = client.call()
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "postDetailSegue"{
            let commentsViewController = segue.destination as! CommentsViewController
            commentsViewController.postOwner.author = post?.author
            commentsViewController.postOwner.postCaption.text = post?.title
        }
    }
    
    @IBAction func tapComment(_ sender: Any) {
        self.delegate?.onTapCommentButton(post: self.post)
    }
    
}

protocol CommentButtonDelegate {
    func onTapCommentButton(post: Post?)
}
