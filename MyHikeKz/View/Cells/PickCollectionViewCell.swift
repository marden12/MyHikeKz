//
//  PickCollectionViewCell.swift
//  MyHikeKz
//
//  Created by Dayana Marden on 21.01.18.
//  Copyright © 2018 Dayana Marden. All rights reserved.
//

import UIKit
import Cartography
class PickCollectionViewCell: UICollectionViewCell {
    public lazy var imageView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        return imgView
    }()
    fileprivate lazy var shadowView: UIView = {
        let shadowView = UIView()
        shadowView.backgroundColor = UIColor(red: 114/255, green: 97/255, blue: 97/255, alpha: 0.43)
        
        return shadowView
    }()
    public lazy var title: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 3
        label.textAlignment = .center
        label.font = UIFont(name: Standart.lightFont.rawValue, size: 18)
        return label
        
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(imageView)
        self.addSubview(title)
        imageView.addSubview(shadowView)
        configureConstraints()
    }
    func configureConstraints(){
        constrain(self, imageView,shadowView,title) { s, img,sh,t in
            img.edges == s.edges
            sh.edges == img.edges
            t.center == s.center
            t.width == s.width - 20
            t.left == s.left + 10
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



