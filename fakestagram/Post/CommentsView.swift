//
//  CommentsView.swift
//  fakestagram
//
//  Created by Jesús Germán Ortiz Barajas on 6/13/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import Foundation
import UIKit

class CommentsView : UIView{
    var author : Author? {
        didSet{ updateView() }
    }
    
    private let avatarView: SVGView = {
        let svg = SVGView()
        svg.translatesAutoresizingMaskIntoConstraints = false
        return svg
    }()
    private let nameLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Lorem"
        lbl.font = UIFont.boldSystemFont(ofSize: lbl.font.pointSize)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    var postCaption: UILabel = {
        let postCaption = UILabel()
        postCaption.text = "Post caption"
        postCaption.translatesAutoresizingMaskIntoConstraints = false
        return postCaption
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
            avatarView.widthAnchor.constraint(equalToConstant: 52),
            avatarView.heightAnchor.constraint(equalToConstant: 52)
            ])
        avatarView.clipsToBounds = true
        avatarView.layer.cornerRadius = 26
        
        addSubview(nameLbl)
        NSLayoutConstraint.activate([
            nameLbl.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            nameLbl.leadingAnchor.constraint(equalTo: avatarView.trailingAnchor, constant: 10),
            nameLbl.heightAnchor.constraint(equalToConstant: 32)
            ])
        
        addSubview(postCaption)
        NSLayoutConstraint.activate([
            postCaption.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            postCaption.leadingAnchor.constraint(equalTo: nameLbl.trailingAnchor, constant: 5),
            postCaption.heightAnchor.constraint(equalToConstant: 32)
            ])
    }
    
    func updateView(){
        guard let author = self.author else { return }
        nameLbl.text = author.name
        avatarView.loadContent(from: author.avatarUrl())
    }
}
