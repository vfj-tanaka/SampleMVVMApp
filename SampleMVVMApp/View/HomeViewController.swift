//
//  HomeViewController.swift
//  SampleMVVMApp
//
//  Created by mtanaka on 2022/09/02.
//

import UIKit

final class HomeViewController: UIViewController {
    
    @IBOutlet private weak var imageButton: UIButton!
    @IBOutlet private weak var postButton: UIButton!
    @IBOutlet private weak var logoutButton: UIButton!
    
    private let cellKey = "HomeTableViewCell"
    @IBOutlet private weak var homeTableView: UITableView! {
        didSet {
            homeTableView.register(UINib(nibName: cellKey, bundle: nil), forCellReuseIdentifier: cellKey)
            homeTableView.dataSource = self
            homeTableView.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = homeTableView.dequeueReusableCell(withIdentifier: cellKey) as? HomeTableViewCell else { return UITableViewCell() }
        cell.confirure(image: "")
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    
}
