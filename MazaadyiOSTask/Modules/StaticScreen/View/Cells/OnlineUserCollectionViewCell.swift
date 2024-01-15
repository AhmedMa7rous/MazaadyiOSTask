//
//  OnlineUserCollectionViewCell.swift
//  MazaadyiOSTask
//
//  Created by Ahmed Mahrous on 15/01/2024.
//

import UIKit

class OnlineUserCollectionViewCell: UICollectionViewCell {
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center
        imageView.layer.cornerRadius = 25
        imageView.layer.borderWidth = 4
        imageView.layer.borderColor = #colorLiteral(red: 0.9488623738, green: 0.4645586014, blue: 0.446549356, alpha: 1)
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let videoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Video"))
        imageView.contentMode = .center
        imageView.backgroundColor = #colorLiteral(red: 0.3019607843, green: 0.7882352941, blue: 0.8196078431, alpha: 1)
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        addSubview(profileImageView)
        addSubview(videoImageView)
        
        NSLayoutConstraint.activate([
            profileImageView.widthAnchor.constraint(equalToConstant: 75),
            profileImageView.heightAnchor.constraint(equalToConstant: 75),
            profileImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            videoImageView.widthAnchor.constraint(equalToConstant: 30),
            videoImageView.heightAnchor.constraint(equalToConstant: 30),
            videoImageView.trailingAnchor.constraint(equalTo: profileImageView.trailingAnchor),
            videoImageView.bottomAnchor.constraint(equalTo: profileImageView.bottomAnchor)
        ])
    }
    
    func configure(with user: User) {
        profileImageView.image = UIImage(named: user.profileImageName)
        
    }
}
