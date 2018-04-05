//
//  UIColor+Font.swift
//  MyHikeKz
//
//  Created by Dayana Marden on 08.12.17.
//  Copyright © 2017 Dayana Marden. All rights reserved.
//

import UIKit
enum Standart: String {
    case regularFont = "YanoneKaffeesatz-Regular"
    case robotoFont = "Roboto-Light"
    case lightFont = "YanoneKaffeesatz-Light"
}
extension UIColor {
    static let backgroundColor = UIColor(displayP3Red: 241/255, green: 241/255, blue: 241/255, alpha: 1)
    static let myGray = UIColor(displayP3Red: 120/255, green: 119/255, blue: 118/255, alpha: 1)
    static let myOrange = UIColor(displayP3Red: 213/255, green: 123/255, blue: 52/255, alpha: 1)
    static let myBlue = UIColor(displayP3Red: 165/255, green: 205/255, blue: 200/255, alpha: 1)
    static let myBrown = UIColor(displayP3Red: 153/255, green: 106/255, blue: 95/255, alpha: 1)
    static let myDarkGray = UIColor(displayP3Red: 78/255, green: 76/255, blue: 73/255, alpha: 1)
    
}
