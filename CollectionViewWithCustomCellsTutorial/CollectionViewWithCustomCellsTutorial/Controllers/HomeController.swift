//
//  ViewController.swift
//  CollectionViewWithCustomCellsTutorial
//
//  Created by Gabriel Del VIllar De Santiago on 1/22/20.
//  Copyright © 2020 Gabriel Del VIllar De Santiago. All rights reserved.
//

import UIKit



class HomeController: UICollectionViewController {
    
    fileprivate var posts = [Post]()
    
    fileprivate let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        collectionView.register(PostCell.self, forCellWithReuseIdentifier: cellId)
        
        fetchPosts()
        
        let refreshControl = UIRefreshControl()
        
        refreshControl.addTarget(self, action: #selector(fetchPosts), for: .valueChanged)
        collectionView.refreshControl = refreshControl
    }
    
    @objc fileprivate func fetchPosts(){
        self.collectionView.refreshControl?.endRefreshing()
        posts = [Post(user: "The Blue Stones", img: #imageLiteral(resourceName: "bluestones")), Post(user: "The Black Keys", img: #imageLiteral(resourceName: "blackkeys")), Post(user: "Mind Pump", img: #imageLiteral(resourceName: "mindpump"))]
        
        collectionView.reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PostCell
        cell.postCellHandleOptionsDelegate = self
        cell.post = posts[indexPath.item]
        
        
        return cell
    }
    

}

extension HomeController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: self.view.frame.width, height: 300)
    }
}

extension HomeController: PostCellHandleOptionsDelegate {
    func handelOptions(cell: PostCell) {
        
        guard let indexPath = collectionView.indexPath(for: cell) else {return}
    
        let alertControllerView = UIAlertController(title: "Options", message: nil, preferredStyle: .actionSheet)
        
        alertControllerView.addAction(.init(title: "Delete Post", style: .destructive, handler: { (_) in
            self.posts.remove(at: indexPath.item)
            self.collectionView.deleteItems(at: [indexPath])
        }))
        
        alertControllerView.addAction(.init(title: "Cancel", style: .cancel, handler: nil))
        
        present(alertControllerView, animated: true)


    }
    
    
}

