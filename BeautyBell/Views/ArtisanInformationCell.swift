//
//  ArtisanInformationCell.swift
//  BeautyBell
//
//  Created by Jacob Andrean on 11/06/21.
//

import UIKit

class ArtisanInformationCell: UICollectionViewCell {
    static let identifier = "ArtisanInformationCell"
    
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(systemName: "person")
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .thin)
        label.text = "User"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 0
        label.text = "hi"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(avatarImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(descLabel)
        setupViewConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViewConstraint() {
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            avatarImageView.widthAnchor.constraint(equalToConstant: 50),
            avatarImageView.heightAnchor.constraint(equalToConstant: 50),
            nameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            descLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 10),
            descLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            descLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
//            descLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    public func configure(with viewModel: ArtisanInformationCellViewModel) {
        avatarImageView.sd_setImage(with: viewModel.avatar, completed: nil)
        
        let starFill = NSTextAttachment()
        let star = NSTextAttachment()
        starFill.image = UIImage(systemName: "star.fill")?.withTintColor(.black)
        star.image = UIImage(systemName: "star")
        
        let atrString = NSMutableAttributedString(string: "\(viewModel.name)\n")
        
        if let rating = Int(viewModel.rating) {
            for i in 0...4 {
                if i <= rating {
                    atrString.append(NSAttributedString(attachment: starFill))
                } else {
                    atrString.append(NSAttributedString(attachment: star))
                }
            }
        }
        nameLabel.attributedText = atrString
        descLabel.text = viewModel.description
    }
}
