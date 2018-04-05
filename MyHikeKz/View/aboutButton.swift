//
//  aboutButton.swift
//  MyHikeKz
//
//  Created by Dayana Marden on 14.02.18.
//  Copyright © 2018 Dayana Marden. All rights reserved.
//

import UIKit
import Cartography

class aboutButton: UIButton {
    lazy var imgV: UIImageView = {
        let imgV = UIImageView()
        imgV.image = UIImage(named: "loc")
        return imgV
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.titleLabel?.font = UIFont(name: Standart.regularFont.rawValue, size: 16)
        self.setTitleColor(.myOrange, for: .normal)
        self.setTitle("Показать на карте", for: .normal)
        self.semanticContentAttribute = .forceRightToLeft
        self.addSubview(imgV)
        constrain(imgV,self){ iv,s in
            iv.width == 12
            iv.height == 12
            
            
        }
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("Error")
    }
}
