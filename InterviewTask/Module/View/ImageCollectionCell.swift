//
//  ImageCollectionCell.swift
//  InterviewTask
//
//  Created by Yeskendir Salgara on 4/15/20.
//  Copyright © 2020 Yeskendir Salgara. All rights reserved.
//

import UIKit
import SnapKit

class ImageCollectionCell: UICollectionViewCell{
    
    var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func setup(image: UIImage) {
        imageView.image = image
    }
}
private extension ImageCollectionCell{
    func configure(){
        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        self.addSubview(imageView)
        imageView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
}
