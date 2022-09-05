//
//  HomeTableViewCell.swift
//  SampleMVVMApp
//
//  Created by mtanaka on 2022/09/05.
//

import UIKit

final class HomeTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var sampleImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        sampleImageView.image = nil
    }
    
    func confirure(image: String) {
        
    }
}
