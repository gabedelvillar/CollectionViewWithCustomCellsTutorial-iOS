//
//  PostCell.swift
//  CollectionViewWithCustomCellsTutorial
//
//  Created by Gabriel Del VIllar De Santiago on 1/26/20.
//  Copyright © 2020 Gabriel Del VIllar De Santiago. All rights reserved.
//

import UIKit


protocol PostCellHandleOptionsDelegate: class{
    func handelOptions(cell: PostCell)
}

class PostCell: UICollectionViewCell{
    
    weak var postCellHandleOptionsDelegate: PostCellHandleOptionsDelegate?
    
    var post: Post! {
           didSet{
               userLbl.text = post.user
               imageView.image = post.img
               userImg.image = post.img
           }
       }
    
    let userLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "The Black Keys"
        return lbl
    }()
    
    let userImg: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "blackkeys"))
        imageView.contentMode = .scaleAspectFill
        imageView.widthAnchor.constraint(equalToConstant:40).isActive = true
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor).isActive = true
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        return imageView
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "blackkeys"))
        imageView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var optionsBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "post_options copy"), for: .normal)
        button.tintColor = .black
        button.imageView?.contentMode = .scaleAspectFill
        button.widthAnchor.constraint(equalToConstant: 34).isActive = true
        button.addTarget(self, action: #selector(optionsBtnPressed), for: .touchUpInside)
        
        return button
    }()
    
    @objc fileprivate func optionsBtnPressed() {
        postCellHandleOptionsDelegate?.handelOptions(cell: self)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    fileprivate func setupViews(){
        backgroundColor = .white
        
        let topStackView = UIStackView(arrangedSubviews: [userImg, userLbl, UIView(),optionsBtn])
        topStackView.axis = .horizontal
        topStackView.distribution = .fillProportionally
        topStackView.alignment = .center
        topStackView.spacing = 12
        
        
        let mainStackView = UIStackView(arrangedSubviews: [topStackView, imageView])
        mainStackView.axis = .vertical
        mainStackView.spacing = 12
        mainStackView.distribution = .fillProportionally
        
        addSubview(mainStackView)
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
    }
    
   
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
