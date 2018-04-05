
//
//  CustomTextField.swift
//  MyHikeKz
//
//  Created by Dayana Marden on 09.12.17.
//  Copyright © 2017 Dayana Marden. All rights reserved.
//
import UIKit
import SkyFloatingLabelTextField

class CustomTextField: SkyFloatingLabelTextField{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        self.textColor = .myGray
        self.lineColor = .myGray
        self.selectedTitleColor = .myOrange
        self.selectedLineColor = .myGray
        self.titleFont = UIFont(name: Standart.robotoFont.rawValue, size: 12)!
        self.font = UIFont(name: Standart.robotoFont.rawValue, size: 16)
        self.textAlignment = .left
        self.lineHeight = 0.5
        self.selectedLineHeight = 0.5
        self.tintColorDidChange()
        self.autocapitalizationType = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
