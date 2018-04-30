//
//  CommentsTableViewCell.swift
//  MyHikeKz
//
//  Created by Dayana Marden on 26.02.18.
//  Copyright © 2018 Dayana Marden. All rights reserved.
//

import UIKit
import Cartography

class CommentsTableViewCell: UITableViewCell {
    lazy var user_name: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Standart.robotoFont.rawValue, size: 14)
        label.textColor = .myOrange
        return label
    }()
    lazy var current_time: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Standart.robotoFont.rawValue, size: 14)
        label.textColor = .myOrange
        return label
    }()
    lazy var comment_text: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Standart.robotoFont.rawValue, size: 14)
        label.textColor = .black
        label.numberOfLines = 100
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        [user_name,current_time,comment_text].forEach{
            self.addSubview($0)
        }
        setupConstraints()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not implemented coder")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupConstraints(){
        constrain(user_name,self,current_time,comment_text){u, s, c, com in
            u.top == s.top + 8
            u.left == s.left + 8
            
            c.top == s.top + 8
            c.left == u.right + 8
            
            com.top == u.bottom + 8
            com.left == s.left + 8
            
        }
    }
}
