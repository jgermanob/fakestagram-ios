//
//  CommentAuthorView.swift
//  fakestagram
//
//  Created by Jesús Germán Ortiz Barajas D3 on 6/14/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import UIKit

class CommentAuthorView: UIView {
    
    var author : Author? {
        didSet{ updateView() }
    }
    
    private let avatarView: SVGView = {
        let svg = SVGView()
        svg.translatesAutoresizingMaskIntoConstraints = false
        return svg
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    func setupView() {
        self.backgroundColor = .clear
        addSubview(avatarView)
        NSLayoutConstraint.activate([
            avatarView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            avatarView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            avatarView.widthAnchor.constraint(equalToConstant: 42),
            avatarView.heightAnchor.constraint(equalToConstant: 42)
            ])
        avatarView.clipsToBounds = true
        avatarView.layer.cornerRadius = 26
        author = loadProfileInfo()
    }
    
    func updateView(){
        let author = loadProfileInfo()
        avatarView.loadContent(from: author.avatarUrl())
    }
    
    func loadProfileInfo() -> Author{
        let account = AccountRepo().load()
        let author = Author(id: (account?.id)!, name: (account?.name)!)
        return author
    }
}
