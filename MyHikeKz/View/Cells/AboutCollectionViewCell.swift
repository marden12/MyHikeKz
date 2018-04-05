//
//  AboutCollectionViewCell.swift
//  MyHikeKz
//
//  Created by Dayana Marden on 31.01.18.
//  Copyright © 2018 Dayana Marden. All rights reserved.
//

import UIKit
import Cartography
class AboutCollectionViewCell: UICollectionViewCell {
    
    lazy var imageV: UIImageView = {
        let imgView = UIImageView()
        return imgView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(imageV)
        self.backgroundColor = .backgroundColor
        constrain(imageV,self){iv,s in
            iv.edges == s.edges
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
