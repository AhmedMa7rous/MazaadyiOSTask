//
//  StaticScreenViewController.swift
//  MazaadyiOSTask
//
//  Created by Ahmed Mahrous on 12/01/2024.
//

import UIKit

class StaticScreenViewController: UIViewController {
    //MARK: _ Outlet Connections
    @IBOutlet weak var onlineUsersCollectionView: UICollectionView!
    @IBOutlet weak var profileImageView: UIImageView!
    
    //MARK: Properties
    var onlineUsers: [User] = []  // Replace User with your user model

    
    //MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupCollectionView()
        setupOnlineStatus()
        // Dummy data for testing
        onlineUsers = [
                User(name: "User1", profileImageName: "Avatar", isOnline: true),
                User(name: "User2", profileImageName: "Avatar", isOnline: false),
                User(name: "User3", profileImageName: "Avatar", isOnline: true),
                User(name: "User4", profileImageName: "Avatar", isOnline: true),
                User(name: "User5", profileImageName: "Avatar", isOnline: true),
                User(name: "User6", profileImageName: "Avatar", isOnline: true)
                ]
    }
    
    //MARK: Action Connections
    
    
    //MARK: Support Functions
    func setupNavigationBar(){
        navigationController?.navigationBar.isHidden = true
    }
    
    func setupCollectionView() {
        onlineUsersCollectionView.delegate = self
        onlineUsersCollectionView.dataSource = self
        onlineUsersCollectionView.register(OnlineUserCollectionViewCell.nib, forCellWithReuseIdentifier: OnlineUserCollectionViewCell.identifier)
    }
    
    func setupOnlineStatus() {
        let onlineStatusView: UIView = {
            let view = UIView()
            view.backgroundColor = .green
            view.layer.cornerRadius = 6
            view.layer.borderWidth = 1
            view.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        self.view.addSubview(onlineStatusView)
        
        NSLayoutConstraint.activate([
            onlineStatusView.widthAnchor.constraint(equalToConstant: 12),
            onlineStatusView.heightAnchor.constraint(equalToConstant: 12),
            onlineStatusView.trailingAnchor.constraint(equalTo: profileImageView.trailingAnchor),
            onlineStatusView.bottomAnchor.constraint(equalTo: profileImageView.bottomAnchor)
        ])
    }
}

//MARK: - CollectionView Functions
extension StaticScreenViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return onlineUsers.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = onlineUsersCollectionView.dequeueReusableCell(withReuseIdentifier: OnlineUserCollectionViewCell.identifier, for: indexPath) as? OnlineUserCollectionViewCell else {
            fatalError("Unable to dequeue OnlineUserCell")
        }
        
        let user = onlineUsers[indexPath.item]
        cell.configure(with: user)
        
        return cell
    }
    
    // UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90, height: collectionView.bounds.height)
    }
}
