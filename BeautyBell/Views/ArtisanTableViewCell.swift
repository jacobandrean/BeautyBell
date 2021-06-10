//
//  ArtisanTableViewCell.swift
//  BeautyBell
//
//  Created by Jacob Andrean on 10/06/21.
//

import UIKit

class ArtisanTableViewCell: UITableViewCell {

    static let identifier = "ArtisanTableViewCell"
    
    private let avatar: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let name: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .thin)
        return label
    }()
    
    private let desc: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
}
