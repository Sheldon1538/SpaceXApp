//
//  ImageCollectionViewCell.swift
//  SpaceXApp
//
//  Created by Konstantin on 09.03.2021.
//  Copyright © 2021 Konstantin Akchurin. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageView()
        layer.cornerRadius = 26.0
        clipsToBounds = true
    }
    
    override func prepareForReuse() {
        imageView.image = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private func setupImageView() {
        contentView.addSubview(imageView)
        imageView.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor)
    }
}
