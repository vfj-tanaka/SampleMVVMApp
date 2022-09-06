//
//  HomeViewController.swift
//  SampleMVVMApp
//
//  Created by mtanaka on 2022/09/02.
//

import UIKit
import RxSwift
import RxCocoa

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
    
    private var viewModel: HomeViewModel!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageButton.layer.cornerRadius = 10
        imageButton.layer.borderWidth = 1
        imageButton.layer.borderColor = UIColor.lightGray.cgColor
        postButton.layer.cornerRadius = 5
        postButton.layer.borderWidth = 1
        postButton.layer.borderColor = UIColor.black.cgColor
        bind()
    }
    
    func bind() {
        
        self.viewModel = HomeViewModel()
        
        imageButton.rx.tap.asDriver().drive(onNext: { [weak self] in
            
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.allowsEditing = true
            self?.present(imagePickerController, animated: true, completion: nil)
        })
        .disposed(by: disposeBag)
        
        logoutButton.rx.tap.asDriver().drive(onNext: { [weak self] in
            self?.viewModel.logout()
        })
        .disposed(by: disposeBag)
    }
}

extension HomeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let editImage = info[.editedImage] as? UIImage {
            imageButton.setImage(editImage.withRenderingMode(.alwaysOriginal), for: .normal)
        } else if let originalImage = info[.originalImage] as? UIImage {
            imageButton.setImage(originalImage.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        
        imageButton.setTitle("", for: .normal)
        imageButton.imageView?.contentMode = .scaleAspectFill
        imageButton.contentHorizontalAlignment = .fill
        imageButton.contentVerticalAlignment = .fill
        imageButton.clipsToBounds = true
        dismiss(animated: true, completion: nil)
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 140
    }
}
