//
//  CustomButton.swift
//  MyHikeKz
//
//  Created by Dayana Marden on 16.01.18.
//  Copyright © 2018 Dayana Marden. All rights reserved.
//

import UIKit
import Cartography
class CustomButton: UIButton{
    let text: String = ""
    lazy var label: UILabel = {
        let l = UILabel()
        l.textColor = .myBrown
        l.font = UIFont(name: Standart.regularFont.rawValue, size: 16)
        l.numberOfLines = 2
        return l
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(label)
        constrain(self,label){s,l in
            l.top == s.bottom + 5
            l.centerX == s.centerX
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("Error")
    }
    
}
