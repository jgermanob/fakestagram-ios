//
//  TimelineViewController.swift
//  fakestagram
//
//  Created by LuisE on 3/16/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController {
    @IBOutlet weak var postsCollectionView: UICollectionView!
    let client = TimelineClient()
    var posts: [Post] = [] {
        didSet { postsCollectionView.reloadData() }
    }
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear()")
        postsCollectionView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configCollectionView()
        NotificationCenter.default.addObserver(self, selector: #selector(didLikePost(_:)), name: .didLikePost, object: nil)

        client.show { [weak self] data in
            self?.posts = data
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    private func configCollectionView() {
        postsCollectionView.delegate = self
        postsCollectionView.dataSource = self
        let postCollectionViewCellXib = UINib(nibName: String(describing: PostCollectionViewCell.self), bundle: nil)
        postsCollectionView.register(postCollectionViewCellXib, forCellWithReuseIdentifier: PostCollectionViewCell.reuseIdentifier)
    }

    @objc func didLikePost(_ notification: NSNotification) {
        guard let userInfo = notification.userInfo,
            let row = userInfo["row"] as? Int,
            let data = userInfo["post"] as? Data,
            let json = try? JSONDecoder().decode(Post.self, from: data) else { return }
        //posts[row] = json
    }
    
    func loadNextPage(){}
}

extension TimelineViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.postsCollectionView.frame.width, height: 600)
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostCollectionViewCell.reuseIdentifier, for: indexPath) as! PostCollectionViewCell
        cell.post = posts[indexPath.row]
        return cell
    }
}
