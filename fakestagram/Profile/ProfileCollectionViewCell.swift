//
//  ProfileCollectionViewCell.swift
//  fakestagram
//
//  Created by Jesús Germán Ortiz Barajas D3 on 5/4/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import Foundation
import UIKit

class ProfileCollectionViewCell : UICollectionViewCell{
    @IBOutlet weak var profilePostImage: UIImageView!
    public var post: Post? {
        didSet { updateView() }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateView()
    }
    
    private func updateView() {
        guard let post = self.post else { return }
        post.load { [weak self] img in
            self?.profilePostImage.image = img
        }
    }
}
