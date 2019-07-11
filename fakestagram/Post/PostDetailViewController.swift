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
    private let client = TimelineClient()
    let updateClient = EditPostClient()
    @IBOutlet weak var authorView: PostAuthorView!
    @IBOutlet weak var imgView: UIScrollView!
    @IBOutlet weak var titleLbl: UITextView!
    @IBOutlet weak var likeCounterLbl: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var optionButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var editPostTextField: UITextField!
    
    override func loadView() {
        Bundle.main.loadNibNamed("PostDetailViewController", owner: self, options: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    func setupView(){
        doneButton.isHidden = true
        editPostTextField.isHidden = true
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
            self.client.destroy(id: self.post.id!, success: { post in })
            self.navigationController?.popViewController(animated: true)
        }
        
        let editAction = UIAlertAction(title: "Edit", style: .default) { action in
            self.optionButton.isHidden = true
            self.titleLbl.isHidden = true
            self.editPostTextField.text = self.titleLbl.text
            self.doneButton.isHidden = false
            self.editPostTextField.isHidden = false
            self.dismiss(animated: true, completion: nil)
        }
        
        alertController.addAction(deleteAction)
        alertController.addAction(editAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func onTapDoneButton(_ sender: UIButton) {
        if editPostTextField.text != ""{
            guard let image = postImageView.image as? UIImage, let imageBase64 = image.encodedBase64() else {return}
            let payload = CreatePostBase64(title: editPostTextField.text!, imageData: imageBase64)
            updateClient.update(id: post.id!, payload: payload) { post in
                print(post)
            }

        }
        let alert = UIAlertController(title: nil, message: "Post updated", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { action in
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
        }
    
    }
    

