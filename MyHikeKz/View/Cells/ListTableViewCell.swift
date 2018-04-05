//
//  ListTableViewCell.swift
//  MyHikeKz
//
//  Created by Dayana Marden on 25.03.18.
//  Copyright © 2018 Dayana Marden. All rights reserved.
//

import UIKit
import Cartography
class ListTableViewCell: UITableViewCell {
    lazy var name: UILabel = {
        let label = UILabel()
        label.textColor = .myGray
        label.font = UIFont(name: Standart.robotoFont.rawValue, size: 20)
        label.text = "Чарынский каньон"
        return label
    }()
    lazy var date: UILabel = {
        let label = UILabel()
        label.textColor = .myGray
        label.font = UIFont(name: Standart.robotoFont.rawValue, size: 16)
        label.text = "28.03.2018"
        return label
    }()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(name)
        self.addSubview(date)
        self.accessoryType = .disclosureIndicator
        self.backgroundColor = .backgroundColor
        constrain(name,date,self){n,d,s in
            n.left == s.left + 5
            n.top == s.top + 5
            
            d.left == n.left
            d.top == n.bottom + 5
            
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not implemented coder")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
