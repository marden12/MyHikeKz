//
//  CustomButtonWithImage.swift
//  MyHikeKz
//
//  Created by Dayana Marden on 25.02.18.
//  Copyright © 2018 Dayana Marden. All rights reserved.
//

import UIKit
import PureLayout
import Cartography
class CustomButtonWithImage: UIButton{
    let label = UILabel()
    
    lazy var commImg: UIImageView = {
        let imgV = UIImageView()
        return imgV
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(commImg)
        self.addSubview(self.label)
        constrain(commImg){c in
            c.width == 14
            c.height == 14
            
        }
        self.backgroundColor = .clear
        self.layer.borderColor = UIColor.clear.cgColor
        self.titleLabel?.font = UIFont(name: Standart.robotoFont.rawValue, size: 14)
        self.titleLabel?.minimumScaleFactor = 10/UIFont.labelFontSize
        self.titleLabel?.adjustsFontSizeToFitWidth = true
        self.setTitleColor(.myGray, for: .normal)
        commImg.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0), excludingEdge: .right)
        self.titleLabel?.autoPinEdge(.left, to: .right, of: self.commImg, withOffset: 5)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("Error")
        
    }
}

