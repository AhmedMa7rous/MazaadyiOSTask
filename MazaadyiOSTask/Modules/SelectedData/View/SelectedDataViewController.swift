//
//  SelectedDataViewController.swift
//  MazaadyiOSTask
//
//  Created by Ahmed Mahrous on 14/01/2024.
//

import UIKit

class SelectedDataViewController: UIViewController {

    //MARK: - Outlet Connections
    @IBOutlet weak var staticScreenButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var selectedDataTableView: UITableView!
    
    //MARK: - Properties
    let presenter = SelectedDataPresenter()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
    }

    //MARK: - Action Connections
    @IBAction func staticScreenButtonTapped(_ sender: UIButton) {
        let vc = StaticScreenViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }

    //MARK: - Support Functions
    func setupNavigationBar(){
        navigationController?.navigationBar.isHidden = true
    }
    
    func setupTableView() {
        selectedDataTableView.delegate = self
        selectedDataTableView.dataSource = self
        selectedDataTableView.register(SelectedDataTableViewCell.nib, forCellReuseIdentifier: SelectedDataTableViewCell.identifier)
    }
}

//MARK: - TableView Functions
extension SelectedDataViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.selectedData.keys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell =  selectedDataTableView.dequeueReusableCell(withIdentifier: SelectedDataTableViewCell.identifier, for: indexPath) as? SelectedDataTableViewCell else { return UITableViewCell() }
        cell.configure(with: presenter.getKeys()[indexPath.row], and: presenter.getValues()[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
}
