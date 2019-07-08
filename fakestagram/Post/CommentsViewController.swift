//
//  CommentsViewController.swift
//  fakestagram
//
//  Created by Jesús Germán Ortiz Barajas on 6/13/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import UIKit

class CommentsViewController: UIViewController {
    @IBOutlet weak var postOwner: CommentsView!
    public var post: Post!
    @IBOutlet weak var commentsTableView: UITableView!
    var commentClient : CommentClient?
    var createComment : CreateCommentClient?
    var comments : [Comment] = []{
        didSet{commentsTableView.reloadData()}
    }
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var commentButton: UIButton!
    
    
    override func viewWillAppear(_ animated: Bool) {
        commentClient!.show { [weak self] data in
            self?.comments = data
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postOwner.author = post.author
        postOwner.postCaption.text = post.title
        commentsTableView.delegate = self
        commentsTableView.dataSource = self
    }
    
    @IBAction func onTapPostComment(_ sender: UIButton) {
        //let content = CreateComment(content: commentTextField.text!)
        if commentTextField.text != ""{
            let comment = CreateComment(content: commentTextField.text!)
            createComment?.create(codable: comment, success: { comment in
                self.commentClient!.show { [weak self] data in
                    self?.comments = data
                }
                self.commentTextField.text = ""
                self.commentsTableView.reloadData()
            })
        }else{
            let alertController = UIAlertController(title: "Comment", message: "Write a comment to post", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(action)
            present(alertController, animated: true, completion: nil)
        }
    }

}
extension CommentsViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let commentCell = commentsTableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath) as! CommentCell
        commentCell.authorView.author = comments[indexPath.row].author
        commentCell.authorView.author = commentCell.authorView.loadProfileInfo()
        commentCell.commentAuthorLabel.text = comments[indexPath.row].author?.name
        commentCell.commentLabel.text = comments[indexPath.row].content
        return commentCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(73)
    }
}


class CommentCell : UITableViewCell{
    @IBOutlet weak var commentAuthorLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var authorView: CommentAuthorView!
    
    
}
