//
//  HomeTableViewCell.swift
//  SampleMVVMApp
//
//  Created by mtanaka on 2022/09/05.
//

import UIKit

final class HomeTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var postImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        postImageView.layer.cornerRadius = 10
        postImageView.layer.borderWidth = 1
        postImageView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    override func prepareForReuse() {
        postImageView.image = nil
    }
    
    func confirure(image: String) {
        
    }
}
