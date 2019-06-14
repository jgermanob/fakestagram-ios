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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postOwner.author = post.author
        postOwner.postCaption.text = post.title
        // Do any additional setup after loading the view.
    }

}
